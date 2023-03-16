unit UService.Apoio;

interface

uses
  UService.Base,
  Generics.Collections,
  UEntity.Apoios,
  UEntity.Usuarios,
  UEntity.Ocorrencias,
  UEntity.Enderecos;

type
  TServiceApoio = class(TServiceBase)
  private
    FApoio: TApoios;
    FApoios: TObjectList<TApoios>;

    function GetApoios: TObjectList<TApoios>;

    procedure PreencherApoios(const aJsonApoios: String);
    procedure CarregarUsuario(const aJsonUsuario: String;
      var aUsuario: TUsuario);
    procedure CarregarOcorrencia(const aJsonOcorrencia: String;
      var aOcorrencia: TOcorrencia);

  public
    constructor Create; overload;
    constructor Create(aApoios: TApoios); overload;
    destructor Destroy; override;

    procedure Registrar; override;
    procedure Listar; override;
    procedure Excluir; override;

    function ObterRegistro(const aId: Integer): TObject; override;
    procedure ListarApoiosDeUsuario(const aId: Integer);
    procedure ApoiarOcorrencia(const aIdOcorrencia, aQntApoios,
      aIdStatus: Integer);

    property Apoios: TObjectList<TApoios> read GetApoios;

  end;

implementation

uses
  System.SysUtils, REST.Types,
  UUtils.Constants, DataSet.Serialize,
  FireDAC.comp.Client,
  UService.Intf, UService.Ocorrencia,
  UService.Usuario, UService.Endereco,
  UUtils.Functions, System.JSON, System.DateUtils;

{ TServiceApoio }

constructor TServiceApoio.Create;
begin
  Inherited Create;
  FApoios := TObjectList<TApoios>.Create;
end;

procedure TServiceApoio.ApoiarOcorrencia(const aIdOcorrencia, aQntApoios,
  aIdStatus: Integer);
var
  xJSON: TJSONObject;
begin

  xJSON := TJSONObject.Create;
  xJSON.AddPair('id', aIdOcorrencia.ToString);
  xJSON.AddPair('idstatus', aIdStatus.ToString);
  xJSON.AddPair('qtdapoio', aQntApoios.ToString);

  try
    FRESTClient.BaseURL := URL_BASE_OCORRENCIAS;
    FRESTRequest.Params.AddBody(xJSON);
    FRESTRequest.Method := rmPUT;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
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

procedure TServiceApoio.CarregarOcorrencia(const aJsonOcorrencia: String;
  var aOcorrencia: TOcorrencia);
var
  xJSON, xJSONAux: TJSONObject;
  xEndereco: TEndereco;
  xUsuario: TUsuario;
  xDataNula: Boolean;
  xDataFinal, xDataAlteracao: TDateTime;
begin
  aOcorrencia := nil;
  xJSON := TJSONObject.Create(nil);
  xJSONAux := TJSONObject.Create(nil);

  try
    xJSON := TJSONObject.ParseJSONValue(aJsonOcorrencia) as TJSONObject;
    xJSONAux := TJSONObject.ParseJSONValue
      (xJSON.GetValue<TJSONObject>('endereco').ToString) as TJSONObject;

    xEndereco := TEndereco.Create(xJSONAux.GetValue<Integer>('numero'),
      xJSONAux.GetValue<String>('cep'), xJSONAux.GetValue<String>('bairro'),
      xJSONAux.GetValue<String>('logradouro'),
      xJSONAux.GetValue<String>('complemento'),
      xJSONAux.GetValue<Integer>('id'));

    Self.CarregarUsuario(xJSON.GetValue<TJSONObject>('usuario').ToString,
      xUsuario);

    xDataNula := TUtilsFunctions.IIF<Boolean>
      (xJSON.GetValue<String>('datafinal') = EmptyStr, True, False);

    if xDataNula then
      xDataFinal := 0
    else
      xDataFinal := ISO8601ToDate(xJSON.GetValue<String>('datafinal'));

    xDataNula := TUtilsFunctions.IIF<Boolean>
      (xJSON.GetValue<String>('dataalteracao') = EmptyStr, True, False);

    if xDataNula then
      xDataAlteracao := 0
    else
      xDataAlteracao := ISO8601ToDate(xJSON.GetValue<String>('dataalteracao'));

    aOcorrencia := TOcorrencia.Create(xJSON.GetValue<Integer>('id'),
      xJSON.GetValue<Integer>('qntapoio'),
      ISO8601ToDate(xJSON.GetValue<String>('datainicial')), xDataFinal,
      xDataAlteracao, xJSON.GetValue<Integer>('urgencia'),
      xJSON.GetValue<String>('descricao'),
      xJSON.GetValue<String>('tipoProblema'), xJSON.GetValue<String>('status'),
      xUsuario, xEndereco);
  finally
    FreeAndNil(xJSON);
    FreeAndNil(xJSONAux);
  end;
end;

procedure TServiceApoio.CarregarUsuario(const aJsonUsuario: String;
  var aUsuario: TUsuario);
var
  xJSON: TJSONObject;
begin
  aUsuario := nil;
  xJSON := TJSONObject.Create;

  try
    xJSON := TJSONObject.ParseJSONValue(aJsonUsuario) as TJSONObject;

    if xJSON.Count > 0 then
    begin

      aUsuario := TUsuario.Create(xJSON.GetValue<Integer>('id'),
        xJSON.GetValue<String>('tipousuario'), xJSON.GetValue<String>('nome'),
        xJSON.GetValue<String>('telefone'), xJSON.GetValue<String>('bairro'),
        xJSON.GetValue<String>('email'), xJSON.GetValue<String>('cpf'),
        xJSON.GetValue<String>('senha'));
    end;
  finally
    FreeAndNil(xJSON);
  end;
end;

constructor TServiceApoio.Create(aApoios: TApoios);
begin
  FApoio := aApoios;
  Self.Create;
end;

destructor TServiceApoio.Destroy;
begin
  FreeAndNil(FApoio);
  FreeAndNil(FApoios);
  inherited;
end;

procedure TServiceApoio.Excluir;
begin
  if (not Assigned(FApoio)) or (FApoio.Id = 0) then
    raise Exception.Create('Nenhum Apoio foi escolhido para exclusão.');

  try
    FRESTClient.BaseURL := Format(URL_BASE_APOIOS + '/%d', [FApoio.Id]);
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

function TServiceApoio.GetApoios: TObjectList<TApoios>;
begin
  Result := FApoios;
end;

procedure TServiceApoio.Listar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_APOIOS;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherApoios(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create
        ('Erro ao carregar a lista de Ocorrencias. Código do Erro: ' +
        FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

procedure TServiceApoio.ListarApoiosDeUsuario(const aId: Integer);
begin
  try
    FRESTClient.BaseURL := URL_BASE_APOIOS + '/usuario/' + aId.ToString;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    case FRESTResponse.StatusCode of
      API_SUCESSO:
        Self.PreencherApoios(FRESTResponse.Content);
      API_NAO_AUTORIZADO:
        raise Exception.Create('Usuário não autorizado.');
    else
      raise Exception.Create
        ('Erro ao carregar a lista de Ocorrencias. Código do Erro: ' +
        FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: Exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceApoio.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  // Verificar
end;

procedure TServiceApoio.PreencherApoios(const aJsonApoios: String);
var
  xArray: TJSONArray;
  xUsuario: TUsuario;
  xOcorrencia: TOcorrencia;
  I: Integer;
begin
  FApoios.Clear;

  xArray := TJSONArray.Create(nil);

  try
    xArray := TJSONObject.ParseJSONValue(aJsonApoios) as TJSONArray;

    for I := 0 to xArray.Count - 1 do
    begin

      Self.CarregarUsuario(xArray[I].GetValue<TJSONObject>('usuario').ToString,
        xUsuario);

      Self.CarregarOcorrencia(xArray[I].GetValue<TJSONObject>('ocorrencia')
        .ToString, xOcorrencia);

      FApoios.Add(TApoios.Create(xArray[I].GetValue<Integer>('id'), xUsuario,
        xOcorrencia));
    end;
  finally
    FreeAndNil(xArray);
  end;
end;

procedure TServiceApoio.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_APOIOS;
    FRESTRequest.Params.AddBody(FApoio.JSON);
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
    on e: Exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
