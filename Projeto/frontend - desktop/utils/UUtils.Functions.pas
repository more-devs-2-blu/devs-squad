unit UUtils.Functions;

interface

type
  TUtilsFunctions = class
  public
    class function IIF<T>(const aConditional: Boolean;
      const aValueTrue, aValueFalse: T): T;
    class function EnviarEmail(aDestinatario, aAssunto, aCorpo: String) : Boolean;
    class function LerVariavelDeAmbiente(aChave: String) : String;
  end;

implementation

uses
  IdSMTP,
  IdMessage,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  UUtils.Constants,
  System.SysUtils, DotEnv4Delphi;

{ TUtilsFunctions }

// para funcionar precisa ter as duas DLL na pasta raiz onde o arquivo binário está sendo executado.
class function TUtilsFunctions.EnviarEmail(aDestinatario, aAssunto, aCorpo: String) : Boolean;
var
  xSMTP: TIdSMTP;
  xMessage: TIdMessage;
  xSocketSSL : TIdSSLIOHandlerSocketOpenSSL;
begin

  Result := False;

  try
    xSMTP := TIdSMTP.Create;
    xMessage := TIdMessage.Create;
    xSocketSSL := TIdSSLIOHandlerSocketOpenSSL.Create;

    xSocketSSL.SSLOptions.Mode := sslmClient;
    xSocketSSL.SSLOptions.Method := sslvTLSv1_2;

    xSocketSSL.Host := Self.LerVariavelDeAmbiente('MAIL_SMTP');
    xSocketSSL.Port := StrToIntDef(Self.LerVariavelDeAmbiente('MAIL_PORT'), 9000);

    xSMTP.IOHandler := xSocketSSL;
    xSMTP.Host := Self.LerVariavelDeAmbiente('MAIL_SMTP');
    xSMTP.Port := StrToIntDef(Self.LerVariavelDeAmbiente('MAIL_PORT'),9000);
    xSMTP.AuthType := satDefault;
    xSMTP.Username := Self.LerVariavelDeAmbiente('MAIL_EMAIL');
    xSMTP.Password := Self.LerVariavelDeAmbiente('MAIL_API_TOKEN');
    xSMTP.UseTLS := utUseExplicitTLS;

    xMessage.From.Address := aDestinatario;
    xMessage.Recipients.Add;
    xMessage.Recipients.Items[0].Address := aDestinatario;
    xMessage.Subject := aAssunto;
    xMessage.Body.Add(aCorpo);

    try
      xSMTP.Connect;
      xSMTP.Send(xMessage);
      Result := True;
    except
      Result := False;
    end;

  finally
    FreeAndNil(xSMTP);
    FreeAndNil(xMessage);
    FreeAndNil(xSocketSSL);
  end;

end;

class function TUtilsFunctions.IIF<T>(const aConditional: Boolean;
  const aValueTrue, aValueFalse: T): T;
begin
  if aConditional then
    Result := aValueTrue
  else
    Result := aValueFalse;
end;

class function TUtilsFunctions.LerVariavelDeAmbiente(aChave: String): String;
begin
  Result := DotEnv.Env(aChave);
end;

end.
