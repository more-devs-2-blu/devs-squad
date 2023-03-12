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

      function GetOcorrencia: TObjectList<TOcorrencia>;

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

      function ObterRegistro(const aId: Integer): TObject; override;

      property Ocorrencias: TObjectList<TOcorrencia> read GetOcorrencia;
  end;

implementation

uses
  System.SysUtils, REST.Types,
  UUtils.Constants, DataSet.Serialize,
  FireDAC.comp.Client,
  UService.Intf, UService.Endereco,
  UService.Usuario, UUtils.Functions;

{ TServiceOcorrencia }

procedure TServiceOcorrencia.CarregarEndereco(const aJsonEndereco: String;
  var aEndereco: TEndereco);
var
  xMemTable: TFDMemTable;
  xStatus: Byte;
begin
  aEndereco := nil;
  xMemTable := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonEndereco);

    if xMemTable.RecordCount > 0 then
    begin
      xStatus := TUtilsFunctions.IIF<Byte>(
        xMemTable.FieldByName('status').AsString = 'true',
        1, 0);

      aEndereco := TEndereco.Create(xMemTable.FieldByName('Id').AsInteger,
                                   xMemTable.FieldByName('Numero').AsInteger,
                                   xMemTable.FieldByName('Cep').AsString,
                                   xMemTable.FieldByName('Bairro').AsString,
                                   xMemTable.FieldByName('Logradouro').AsString,
                                   xMemTable.FieldByName('Complemento').AsString);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceOcorrencia.CarregarUsuario(const aJsonUsuario: String; var aUsuario: TUsuario);
var
  xMemTable: TFDMemTable;
  xStatus: Byte;
begin
  aUsuario     := nil;
  xMemTable := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonUsuario);

    if xMemTable.RecordCount > 0 then
    begin
      xStatus := TUtilsFunctions.IIF<Byte>(
        xMemTable.FieldByName('status').AsString = 'true',
        1, 0);

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

function TServiceOcorrencia.GetOcorrencia: TObjectList<TOcorrencia>;
begin
  Result := FOcorrencias;
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
        raise Exception.Create('Usuário não autorizado.');
      else
        raise Exception.Create('Erro ao carregar a lista de Ocorrencias. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

function TServiceOcorrencia.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //Verificar
end;

procedure TServiceOcorrencia.PreencherOcorrencias(const aJsonOcorrencias: String);
var
  xMemTable: TFDMemTable;
  xMemTableOcorrencia: TFDMemTable;
  xUsuario: TUsuario;
  xEndereco: TEndereco;
  xStatus: Byte;

begin
  FOcorrencias.Clear;

  xMemTable     := TFDMemTable.Create(nil);
  xMemTableOcorrencia := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonOcorrencias);

    while not xMemTable.Eof do
    begin
      xMemTableOcorrencia.LoadFromJSON(xMemTable.FieldByName('usuario').AsString);
      xUsuario := TUsuario.Create(xMemTableOcorrencia.FieldByName('Id').AsInteger,
                                  xMemTable.FieldByName('TipoUsuario').AsString,
                                  xMemTable.FieldByName('Nome').AsString,
                                  xMemTable.FieldByName('Telefone').AsString,
                                  xMemTable.FieldByName('Bairro').AsString,
                                  xMemTable.FieldByName('Email').AsString,
                                  xMemTable.FieldByName('Cpf').AsString,
                                  xMemTable.FieldByName('Senha').AsString);

      xMemTableOcorrencia.LoadFromJSON(xMemTable.FieldByName('endereco').AsString);
      xEndereco := TEndereco.Create(xMemTableOcorrencia.FieldByName('id').AsInteger,
                                    xMemTable.FieldByName('Numero').AsInteger,
                                    xMemTable.FieldByName('Cep').AsString,
                                    xMemTable.FieldByName('Bairro').AsString,
                                    xMemTable.FieldByName('Logradouro').AsString,
                                    xMemTable.FieldByName('Complemento').AsString);

      xStatus := TUtilsFunctions.IIF<Byte>(
        xMemTable.FieldByName('status').AsString = 'true',
        1, 0);

      FOcorrencias.Add(TOcorrencia.Create(xMemTable.FieldByName('id').AsInteger,
                                    xMemTable.FieldByName('Qntapoio').AsInteger,
                                    xMemTable.FieldByName('DataInicial').AsDateTime,
                                    xMemTable.FieldByName('DataFinal').AsDateTime,
                                    xMemTable.FieldByName('DataAlteracao').AsDateTime,
                                    xMemTable.FieldByName('Urgencia').AsInteger,
                                    xMemTable.FieldByName('Descricao').AsString,
                                    xMemTable.FieldByName('TipoProblema').AsString,
                                    xMemTable.FieldByName('Status').AsString,
                                    xUsuario,
                                    xEndereco));
      xMemTable.Next;
    end;
  finally
    FreeAndNil(xMemTable);
    FreeAndNil(xMemTableOcorrencia);
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
