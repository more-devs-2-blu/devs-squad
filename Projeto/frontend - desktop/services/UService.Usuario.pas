unit UService.Usuario;

interface

uses
  UEntity.Usuarios, UService.Base;

type
  TServiceUsuario = class(TServiceBase)
    private
      FUsuario: TUsuario;
    public
      constructor Create; overload;
      constructor Create(aUser: TUsuario); overload;
      destructor  Destroy; override;

      procedure Registrar; override;
      procedure Listar; override;
      procedure Excluir; override;

      function ObterRegistro(const aId: Integer): TObject; override;
  end;

implementation

uses
  REST.Types,
  System.JSON, UUtils.Constants, System.SysUtils,
  System.Classes, FireDAC.comp.Client, DataSet.Serialize;

{ TServiceUsuario }

constructor TServiceUsuario.Create;
begin
  Inherited Create;
end;

constructor TServiceUsuario.Create(aUser: TUsuario);
begin
  FUsuario := aUser;

  Self.Create;
end;

destructor TServiceUsuario.Destroy;
begin
  FreeAndNil(FUsuario);
  inherited;
end;

procedure TServiceUsuario.Excluir;
begin
  //Método sem implementação no momento
end;

procedure TServiceUsuario.Listar;
begin
  //Método sem implementação no momento
end;

function TServiceUsuario.ObterRegistro(const aId: Integer): TObject;
var
  xMemTable: TFDMemTable;
begin
  Result := nil;

  xMemTable := TFDMemTable.Create(nil);

  try
    FRESTClient.BaseURL := URL_BASE_USUARIOS + '/' + aId.ToString;
    FRESTRequest.Method := rmGet;
    FRESTRequest.Execute;

    if FRESTResponse.StatusCode = API_SUCESSO then
    begin
      xMemTable.LoadFromJSON(FRESTResponse.Content);

      if xMemTable.FindFirst then
        Result := TUsuario.Create(xMemTable.FieldByName('id').AsInteger,
                                  xMemTable.FieldByName('tipousuario').AsString,
                                  xMemTable.FieldByName('nome').AsString,
                                  xMemTable.FieldByName('telefone').AsString,
                                  xMemTable.FieldByName('bairro').AsString,
                                  xMemTable.FieldByName('email').AsString,
                                  xMemTable.FieldByName('cpf').AsString,
                                  xMemTable.FieldByName('senha').AsString);
    end;
  finally
    FreeAndNil(xMemTable);
  end;
end;

procedure TServiceUsuario.Registrar;
begin
  try
    FRESTClient.BaseURL := URL_BASE_USUARIOS;
    FRESTRequest.Method := rmPost;
    FRESTRequest.Params.AddBody(FUsuario.JSON);
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
