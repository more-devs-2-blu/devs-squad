unit UService.Login;

interface

uses
  UEntity.Logins, UService.Base;

type
  TServiceLogin = class(TServiceBase)
    private
      FLogin: TLogin;

      procedure SalvarToken;
      procedure UsuarioAutenticado;
    public
      constructor Create(aLogin: TLogin);
      destructor  Destroy; override;

      procedure Registrar; override;
      procedure Listar; override;
      procedure Excluir; override;

      function ObterRegistro(const aId: Integer): TObject; override;

      procedure Autenticar;
  end;

implementation

uses
  REST.Authenticator.Basic, REST.Types,
  System.JSON, UUtils.Constants, System.SysUtils,
  System.Classes,
  UService.Intf, UService.Usuario, UEntity.Usuarios,
  UService.Usuario.Authenticated, JOSE.Core.JWT,
  JOSE.Core.Builder;

{ TServiceLogin }

procedure TServiceLogin.Autenticar;
var
  xJSONBody: TJSONObject;
  xHTTPBasicAut: THTTPBasicAuthenticator;
begin
  xJSONBody     := TJSONObject.Create;
  xHTTPBasicAut := THTTPBasicAuthenticator.Create(FLogin.CPF, FLogin.Senha);

  try
    try
      FRESTClient.Authenticator := xHTTPBasicAut;
      FRESTClient.BaseURL       := URL_BASE_LOGIN;

      xJSONBody.AddPair('cpf',    FLogin.CPF);
      xJSONBody.AddPair('senha', FLogin.Senha);

      FRESTRequest.Method := rmPost;
      FRESTRequest.Params.AddBody(xJSONBody);
      FRESTRequest.Execute;

      case FRESTResponse.StatusCode of
        API_SUCESSO:
        begin
          FLogin.Token := FRESTResponse.Content;
          Self.SalvarToken;
          Self.UsuarioAutenticado;
        end;
        API_NAO_AUTORIZADO:
          raise Exception.Create('Usuário não autorizado.');
        else
          raise Exception.Create('Erro não catalogado.');
      end;
    except
      on e: exception do
        raise Exception.Create(e.Message);
    end;
  finally
    FreeAndNil(xJSONBody);
    FreeAndNil(xHTTPBasicAut);
  end;
end;

constructor TServiceLogin.Create(aLogin: TLogin);
begin
  Inherited Create;

  FLogin := aLogin;
end;

destructor TServiceLogin.Destroy;
begin
  FreeAndNil(FLogin);
  inherited;
end;

procedure TServiceLogin.Excluir;
begin
  inherited;
  //Método sem implementação no momento
end;

procedure TServiceLogin.Listar;
begin
  inherited;
  //Método sem implementação no momento
end;

function TServiceLogin.ObterRegistro(const aId: Integer): TObject;
begin
  Result := nil;
  //Método sem implementação no momento
end;

procedure TServiceLogin.Registrar;
begin
  inherited;
  //Método sem implementação no momento
end;

procedure TServiceLogin.SalvarToken;
var
  xStringList: TStringList;
begin
  xStringList := TStringList.Create;
  try
    xStringList.Add(FLogin.Token);
    xStringList.SaveToFile('Token.jwt');
  finally
    xStringList.Free;
  end;
end;

procedure TServiceLogin.UsuarioAutenticado;
var
  xServiceUsuario: IService;
  xJWT: TJWT;
  xIdUsuario: Integer;
  xUserAuthenticated: TUsuarioAuthenticated;
begin
  xJWT := TJOSE.DeserializeCompact('KeyDevsSquad', FLogin.Token);

  try
    if not xJWT.Claims.JSON.TryGetValue<Integer>('id', xIdUsuario) then
      raise Exception.Create('Não foi possível registrar autenticação');

    xServiceUsuario := TServiceUsuario.Create;

    xUserAuthenticated      := TUsuarioAuthenticated.GetInstance;
    xUserAuthenticated.Usuario := TUsuario(xServiceUsuario.ObterRegistro(xIdUsuario));
  finally
    FreeAndNil(xJWT);
  end;
end;

end.
