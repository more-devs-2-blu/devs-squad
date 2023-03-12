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
      FApoios : TObjectList<TApoios>;

      function GetApoios: TObjectList<TApoios>;

      procedure PreencherApoios(const aJsonApoios: String);
      procedure CarregarUsuario(const aJsonUsuario: String; var aUsuario: TUsuario);
      procedure CarregarOcorrencia(const aJsonEndereco: String; var aOcorrencia: TOcorrencia);

    public
      constructor Create; overload;
      constructor Create(aApoios: TApoios); overload;
      destructor Destroy; override;

      procedure Registrar; override;
      procedure Listar; override;
      procedure Excluir; override;

      function ObterRegistro(const aId: Integer): TObject; override;

      property Ocorrencias: TObjectList<TApoios> read GetApoios;

  end;

implementation

uses
  System.SysUtils, REST.Types,
  UUtils.Constants, DataSet.Serialize,
  FireDAC.comp.Client,
  UService.Intf, UService.Ocorrencia,
  UService.Usuario,UService.Endereco,
   UUtils.Functions;


{ TServiceApoio }

constructor TServiceApoio.Create;
begin
  Inherited Create;
  FApoios := TObjectList<TApoios>.Create;
end;

procedure TServiceApoio.CarregarOcorrencia(const aJsonEndereco: String;
  var aOcorrencia: TOcorrencia);
begin
  //
end;

procedure TServiceApoio.CarregarUsuario(const aJsonUsuario: String; var aUsuario: TUsuario);
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
    on e: exception do
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
        raise Exception.Create('Erro ao carregar a lista de Ocorrencias. Código do Erro: ' + FRESTResponse.StatusCode.ToString);
    end;
  except
    on e: exception do
      raise Exception.Create(e.Message);
  end;

end;

function TServiceApoio.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //Verificar
end;

procedure TServiceApoio.PreencherApoios(const aJsonApoios: String);
var
  xMemTable: TFDMemTable;
  xMemTableApoio: TFDMemTable;
  xUsuario: TUsuario;
  xEndereco: TEndereco;
  xOcorrencia: TOcorrencia;
  xStatus: Byte;

begin
  FApoios.Clear;

  xMemTable      := TFDMemTable.Create(nil);
  xMemTableApoio := TFDMemTable.Create(nil);

  try
    xMemTable.LoadFromJSON(aJsonApoios);

    while not xMemTable.Eof do
    begin
      xMemTableApoio.LoadFromJSON(xMemTable.FieldByName('usuario').AsString);
      xUsuario := TUsuario.Create(xMemTableApoio.FieldByName('Id').AsInteger,
                                  xMemTable.FieldByName('TipoUsuario').AsString,
                                  xMemTable.FieldByName('Nome').AsString,
                                  xMemTable.FieldByName('Telefone').AsString,
                                  xMemTable.FieldByName('Bairro').AsString,
                                  xMemTable.FieldByName('Email').AsString,
                                  xMemTable.FieldByName('Cpf').AsString,
                                  xMemTable.FieldByName('Senha').AsString);

      xMemTableApoio.LoadFromJSON(xMemTable.FieldByName('ocorrencia').AsString);
      xOcorrencia := TOcorrencia.Create(xMemTableApoio.FieldByName('id').AsInteger,
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

      xStatus := TUtilsFunctions.IIF<Byte>(
        xMemTable.FieldByName('status').AsString = 'true',
        1, 0);


      FApoio.Add(TApoios.Create(xMemTable.FieldByName('id').AsInteger,
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
    on e: exception do
      raise Exception.Create(e.Message);
  end;
end;

end.
