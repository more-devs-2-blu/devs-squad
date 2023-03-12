unit UUtils.Functions;

interface

type
  TUtilsFunctions = class
  public
    class function IIF<T>(const aConditional: Boolean;
      const aValueTrue, aValueFalse: T): T;
    class function EnviarEmail(aDestinatario, aAssunto, aCorpo: String) : Boolean;
  end;

implementation

uses
  IdSMTP,
  IdMessage,
  IdSSLOpenSSL,
  IdExplicitTLSClientServerBase,
  UUtils.Constants,
  System.SysUtils;

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

    xSocketSSL.Host := MAIL_SMTP;
    xSocketSSL.Port := MAIL_PORT;

    xSMTP.IOHandler := xSocketSSL;
    xSMTP.Host := MAIL_SMTP;
    xSMTP.Port := MAIL_PORT;
    xSMTP.AuthType := satDefault;
    xSMTP.Username := MAIL_EMAIL;
    xSMTP.Password := MAIL_PASSWORD;
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

end.
