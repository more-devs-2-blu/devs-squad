unit UController.Login;

interface

uses
  Horse,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
  GBSwagger.Path.Attributes,
  UController.Base,
  UEntity.Logins;

type
  [SwagPath('login', 'Login')]
  TControllerLogin = class(TControllerBase)
    private
    public
      [SwagPOST('Autentica��o do Usu�rio')]
      [SwagParamBody('Informa��es do Login', TLogin)]
      [SwagResponse(200, 'Token (String)')]
      [SwagResponse(400)]
      class procedure PostLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

uses
  System.JSON,
  System.SysUtils, UController.Usuario;

{ TControllerLogin }

class procedure TControllerLogin.PostLogin(Req: THorseRequest;
  Res: THorseResponse; Next: TProc);
var
  xToken: TJWT;
  xCompactToken: String;
  xJSONLogin: TJSONObject;
  xUser, xPassword: String;
begin
  xToken := TJWT.Create;
  try
    //Token Claims
    xToken.Claims.Issuer     := 'DevsSquad';
    xToken.Claims.Subject    := 'HackWeek';
    xToken.Claims.Expiration := Now + 1;

    xJSONLogin := Req.Body<TJSONObject>;

    if not Assigned(xJSONLogin) then
    begin
      Res.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if not xJSONLogin.TryGetValue<String>('cpf', xUser) then
    begin
      Res.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    if not xJSONLogin.TryGetValue<String>('senha', xPassword) then
    begin
      Res.Status(THTTPStatus.BadRequest);
      Exit;
    end;

    //Outros Claims
    xToken.Claims.SetClaimOfType<Integer>('id', UController.Usuario.GIdUser);
    xToken.Claims.SetClaimOfType<String>('cpf', xUser);

    //Assinatura
    xCompactToken := TJOSE.SHA256CompactToken('KeyDevsSquad', xToken);

    Res.Send(xCompactToken);
  finally
    xToken.Free;
  end;
end;

end.
