unit UService.Ocorrencia;

interface

uses
  UService.Base,
  Generics.Collections,
  UEntity.Ocorrencias,
  UEntity.Usuarios,
  UEntity.Enderecos;

type
  TServiceOcorrencia = class(TServiceBase)
    private
      FOcorrencia: TOcorrencia;
      FOcorrencias:TObjectList<TOcorrencia>;

      function GetOcorrencias: TObjectList<TOcorrencia>;

      procedure PreencherOcorrencias(const aJsonOcorrencias: String);
      procedure CarregarUsuario(const aJsonUsuario: String; var aUsuario: TUsuario);
      procedure CarregarEndereco(const aJsonEndereco: String; var aEndereco: TEndereco);

    public
      constructor Create; overload;
      constructor Create(aOcorrencia: TOcorrencia); overload;
      destructor Destroy; override;

      procedure Registrar; override;
      procedure Listar; override;
      procedure Excluir; override;

      procedure ListaPorUsuario(const aIdUsuario: Integer);
      procedure ListaPorBairro(const aBairro: String);
      procedure ListaPorLogradouro(const aLogradouro: String);
      function ObterRegistro(const aId: Integer): TObject; override;

      property Ocorrencias: TObjectList<TOcorrencia> read GetOcorrencias;
  end;

implementation

uses
  System.SysUtils, REST.Types,
  UUtils.Constants, DataSet.Serialize,
  FireDAC.comp.Client,
  UService.Intf, UService.Endereco,
  UService.Usuario,
  UUtils.Functions,
  System.JSON, FMX.Dialogs,
  DateUtils;

{ TServiceOcorrencia }

procedure TServiceOcorrencia.CarregarEndereco(const aJsonEndereco: String;
  var aEndereco: TEndereco);
var
  xMemTable: TFDMemTable;
begin
  aEndereco := nil;
  xMemTable := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonEndereco);

    if xMemTable.RecordCount > 0 then
    begin

      aEndereco := TEndereco.Create(xMemTable.FieldByName('Numero').AsInteger,
                                    xMemTable.FieldByName('Cep').AsString,
                                    xMemTable.FieldByName('Bairro').AsString,
                                    xMemTable.FieldByName('Logradouro').AsString,
                                    xMemTable.FieldByName('Complemento').AsString,
                                    xMemTable.FieldByName('Id').AsInteger);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceOcorrencia.CarregarUsuario(const aJsonUsuario: String; var aUsuario: TUsuario);
var
  xMemTable: TFDMemTable;
begin
  aUsuario     := nil;
  xMemTable := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonUsuario);

    if xMemTable.RecordCount > 0 then
    begin
      aUsuario := TUsuario.Create(xMemTable.FieldByName('Id').AsInteger,
                                  xMemTable.FieldByName('TipoUsuario').AsString,
                                  xMemTable.FieldByName('Nome').AsString,
                                  xMemTable.FieldByName('Telefone').AsString,
                                  xMemTable.FieldByName('Bairro').AsString,
                                  xMemTable.FieldByName('Email').AsString,
                                  xMemTable.FieldByName('Cpf').AsString,
                                  xMemTable.FieldByName('Senha').AsString);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

constructor TServiceOcorrencia.Create(aOcorrencia: TOcorrencia);
begin
   FOcorrencia := aOcorrencia;
   Self.Create;
end;

constructor TServiceOcorrencia.Create;
begin
  Inherited Create;
  FOcorrencias := TObjectList<TOcorrencia>.Create;
end;

destructor TServiceOcorrencia.Destroy;
begin
  FreeAndNil(FOcorrencia);
  FreeAndNil(FOcorrencias);
  inherited;
end;

procedure TServiceOcorrencia.Excluir;
begin
  if (not Assigned(FOcorrencia)) or (FOcorrencia.Id = 0) then
    raise Exception.Create('Nenhum Palpite foi escolhido para exclusão.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_OCORRENCIAS + '/%d', [FOcorrencia.Id]);
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
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

function TServiceOcorrencia.GetOcorrencias: TObjectList<TOcorrencia>;
begin
  Result := FOcorrencias;
end;

procedure TServiceOcorrencia.ListaPorBairro(const aBairro: String);
var
  xBairro : String;
begin
  try
    xBairro := StringReplace(aBairro,' ','+',[rfReplaceAll]);
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS +
                            '/bairro/' + xBairro;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherOcorrencias(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
      else
        raise Exception.Create('Erro ao carregar a lista de Ocorrncias. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TServiceOcorrencia.ListaPorLogradouro(
  const aLogradouro: String);
var
  xLogradouro : String;
begin
  try
    xLogradouro := StringReplace(aLogradouro,' ','+',[rfReplaceAll]);
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS +
                            '/logradouro/' + xLogradouro;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherOcorrencias(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
      else
        raise Exception.Create('Erro ao carregar a lista de Ocorrencias. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TServiceOcorrencia.ListaPorUsuario(const aIdUsuario: Integer);
begin
  try
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS +
                            '/usuario/' + aIdUsuario.ToString;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherOcorrencias(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
      else
        raise Exception.Create('Erro ao carregar a lista de Ocorrências. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TServiceOcorrencia.Listar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherOcorrencias(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
      else
        raise Exception.Create('Erro ao carregar a lista de Ocorrencias. C�digo do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

function TServiceOcorrencia.ObterRegistro(const aId: Integer): TObject;
var
  xMemTable: TFDMemTable;
  xUsuario: TUsuario;
  xEndereco: TEndereco;
begin
  try
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS + '/' + aId.ToString;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        begin
          xMemTable := TFDMemTable.Create(nil);
          try
            xMemTable.LoadFromJSON(FRESTResponse.Content);

            Self.CarregarUsuario(
              xMemTable.FieldByName('Usuario').AsString, xUsuario);

            Self.CarregarEndereco(
              xMemTable.FieldByName('Endereco').AsString, xEndereco);

            Result :=
              TOcorrencia
                .Create(xMemTable.FieldByName('Id').AsInteger,
                        xMemTable.FieldByName('QntApoio').asInteger,
                        xMemTable.FieldByName('DataInicial').AsDateTime,
                        xMemTable.FieldByName('DataFinal').AsDateTime,
                        xMemTable.FieldByName('DataAlteracao').AsDateTime,
                        xMemTable.FieldByName('Urgencia').AsInteger,
                        xMemTable.FieldByName('Descricao').AsString,
                        xMemTable.FieldByName('TipoProblema').AsString,
                        xMemTable.FieldByName('Status').AsString,
                        xUsuario,
                        xEndereco);
          finally
            FreeAndNil(xMemTable);
          end;
        end;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
      else
        raise Exception.Create('Erro ao carregar a lista de Ocorrencias. C�digo do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

procedure TServiceOcorrencia.PreencherOcorrencias(const aJsonOcorrencias: String);
var
  xJSON, xJSONAux: TJSONValue;
  xArray: TJSONArray;
  xUsuario: TUsuario;
  xEndereco: TEndereco;
  xDataNula: Boolean;
  I: Integer;
  xString: String;
  xDataFinal, xDataAlteracao: TDateTime;
begin
  FOcorrencias.Clear;

  xArray := TJSONArray.Create;
  xJSON := TJSONValue.Create;
  xJSONAux := TJSONValue.Create;

  try
    xArray := TJSONObject.ParseJSONValue(aJsonOcorrencias) as TJSONArray;
    xJSON := xArray[0];


    for I := 0 to xArray.Count - 1 do
    begin
      xJSON := xArray[I];
      xJSONAux := xJSON.GetValue<TJSONValue>('usuario');
      xUsuario := TUsuario.Create(xJSONAux.GetValue<Integer>('id'),
                                  xJSONAux.GetValue<String>('tipousuario'),
                                  xJSONAux.GetValue<String>('nome'),
                                  xJSONAux.GetValue<String>('telefone'),
                                  xJSONAux.GetValue<String>('bairro'),
                                  xJSONAux.GetValue<String>('email'),
                                  xJSONAux.GetValue<String>('cpf'),
                                  xJSONAux.GetValue<String>('senha'));

      xJSONAux := xJSON.GetValue<TJSONValue>('endereco');
      xEndereco := TEndereco.Create(xJSONAux.GetValue<Integer>('numero'),
                                    xJSONAux.GetValue<String>('cep'),
                                    xJSONAux.GetValue<String>('bairro'),
                                    xJSONAux.GetValue<String>('logradouro'),
                                    xJSONAux.GetValue<String>('complemento'),
                                    xJSONAux.GetValue<Integer>('id'));

      xDataNula := TUtilsFunctions.IIF<Boolean>(
        xJSON.GetValue<String>('datafinal') = EmptyStr, True, False);

      if xDataNula then
        xDataFinal := 0
      else
        xDataFinal := ISO8601ToDate(xJSON.GetValue<String>('datafinal'));

      xDataNula := TUtilsFunctions.IIF<Boolean>(
        xJSON.GetValue<String>('dataalteracao') = EmptyStr, True, False);

      if xDataNula then
        xDataAlteracao := 0
      else
        xDataAlteracao := ISO8601ToDate(xJSON.GetValue<String>('dataalteracao'));

      FOcorrencias.Add(
        TOcorrencia.Create( xJSON.GetValue<Integer>('id'),
                            xJSON.GetValue<Integer>('qntapoio'),
                            ISO8601ToDate(xJSON.GetValue<String>('datainicial')),
                            xDataFinal,
                            xDataAlteracao,
                            xJSON.GetValue<Integer>('urgencia'),
                            xJSON.GetValue<String>('descricao'),
                            xJSON.GetValue<String>('tipoProblema'),
                            xJSON.GetValue<String>('status'),
                            xUsuario,
                            xEndereco));
    end;
  finally
    FreeAndNil(xJSONAux);
  end;
end;

procedure TServiceOcorrencia.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS;
    FRESTRequest.Params.AddBody(FOcorrencia.JSON);
    FRESTRequest.Method := rmPost;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_CRIADO:
        Exit;
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usu�rio n�o autorizado.');
      else
        raise Exception.Create('Erro n�o catalogado.');
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
