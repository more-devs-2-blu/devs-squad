unit UService.Endereco;

interface

uses
  UService.Base,
  Generics.Collections,
  UEntity.Enderecos;

type
  TServiceEndereco = class(TServiceBase)
  private
    FEndereco: TEndereco;
    FEnderecos: TObjectList<TEndereco>;

    function GetEnderecos: TObjectList<TEndereco>;

  public
    constructor Create; overload;
    constructor Create(aEndereco: TEndereco); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    //
    procedure ListarBairro(const aBairro: String);

    function ObterRegistro(const aId: Integer): TObject; override;
    function ObterId(const aEndereco: TEndereco) : Integer;

    property Enderecos: TObjectList<TEndereco> read GetEnderecos;
  end;

implementation

uses
  System.SysUtils,
  REST.Types,
  UUtils.Constants,
  DataSet.Serialize,
  FireDAC.comp.Client,
  UService.Intf, System.JSON, REST.Client;

{ TServiceEndereco }

constructor TServiceEndereco.Create;
begin
  Inherited Create;
  FEnderecos := TObjectList<TEndereco>.Create;
end;

constructor TServiceEndereco.Create(aEndereco: TEndereco);
begin
  FEndereco := aEndereco;
  Self.Create;
end;

destructor TServiceEndereco.Destroy;
begin
  FreeAndNil(FEndereco);
  FreeAndNil(FEnderecos);

  inherited;
end;

procedure TServiceEndereco.Excluir;
begin
  if (not Assigned(FEndereco)) or (FEndereco.Id = 0) then
    raise Exception.Create('Nenhum Endereco foi escolhida para exclusão.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_ENDERECOS + '/%d', [FEndereco.Id]);
    FRESTRequest.Method := rmDelete;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO_SEM_RETORNO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create('Erro não catalogado.');
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceEndereco.GetEnderecos: TObjectList<TEndereco>;
begin
  Result := FEnderecos;
end;

procedure TServiceEndereco.Listar;
var
  xMemTable: TFDMemTable;
begin
  FEnderecos.Clear;

  xMemTable := TFDMemTable.Create(nil);

  try
    try
      FRESTClient.BaseURL := URL_BASE_ENDERECOS;
      FRESTRequest.Method := rmGet;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          xMemTable.LoadFromJSON(FRESTResponse.Content);

          while not xMemTable.Eof do
          begin
            FEnderecos.Add(TEndereco.Create(xMemTable.FieldByName('Numero').AsInteger,
                                            xMemTable.FieldByName('Cep').AsString,
                                            xMemTable.FieldByName('Bairro').AsString,
                                            xMemTable.FieldByName('Logradouro').AsString,
                                            xMemTable.FieldByName('Complemento').AsString,
                                            xMemTable.FieldByName('Id').AsInteger));

            xMemTable.Next;
          end;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não autorizado.');
        else
          raise Exception.Create('Erro ao carregar a lista de Endereços. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
      end;
    except
      on e: exception do
        raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceEndereco.ListarBairro(const aBairro: String);
var
  xMemTable: TFDMemTable;
begin
  FEnderecos.Clear;

  xMemTable := TFDMemTable.Create(nil);

  try
    try
      FRESTClient.BaseURL := URL_BASE_ENDERECOS;
      FRESTRequest.Method := rmGet;
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          xMemTable.LoadFromJSON(FRESTResponse.Content);

          while not xMemTable.Eof do
          begin
            FEnderecos.Add(TEndereco.Create(xMemTable.FieldByName('Numero').AsInteger,
                                            xMemTable.FieldByName('Cep').AsString,
                                            xMemTable.FieldByName('Bairro').AsString,
                                            xMemTable.FieldByName('Logradouro').AsString,
                                            xMemTable.FieldByName('Complemento').AsString,
                                            xMemTable.FieldByName('Id').AsInteger));

            xMemTable.Next;
          end;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não autorizado.');
        else
          raise Exception.Create('Erro ao carregar a lista de Endereços. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
      end;
    except
      on e: exception do
        raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

function TServiceEndereco.ObterId(const aEndereco: TEndereco): Integer;
var
  xMemTable: TFDMemTable;
  xJSON : TJSONObject;
begin
  Result := 0;

  xMemTable := TFDMemTable.Create(nil);
  xJSON := TJSONObject.Create;
  try
//
//    xJSON.AddPair('cep', FEndereco.Cep);
//    xJSON.AddPair('bairro', FEndereco.Bairro);
//    xJSON.AddPair('numero', FEndereco.Numero.ToString);
//    xJSON.AddPair('logradouro', FEndereco.Logradouro);
//    xJSON.AddPair('complemento', FEndereco.Complemento);

    FRESTClient.BaseURL := URL_BASE_ENDERECOS + '/id';
    FRESTRequest.Method := rmPOST;
    FRESTRequest.Params.AddBody(FEndereco.JSON);
    FRESTRequest.Execute;

    if FRESTResponse.StatusCode = API_SUCESSO then
    begin
      TryStrToInt(FRESTResponse.Content, Result);
//
//      if xMemTable.FindFirst then
//        Result := StrToInt(FRESTResponse.Content);
    end;
  finally
    FreeAndNil(xJSON);
  end;
end;

function TServiceEndereco.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  // verificar
end;

procedure TServiceEndereco.Registrar;
begin
 try
    FRESTClient.BaseURL := URL_BASE_ENDERECOS;
    FRESTRequest.Method := rmPost;
    FRESTRequest.Params.AddBody(FEndereco.JSON);
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
      else
        raise Exception.Create('Erro não catalogado.');
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
