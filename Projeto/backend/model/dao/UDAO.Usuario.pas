unit UDAO.Usuario;

interface

uses
  UDAO.Base;

type
  TDAOUsuario = class(TDAOBase)
  public
    function ValidarLogin(const aCpf, aPassword: String): Integer;
    constructor Create;
  end;

implementation

uses
  JSON, UUtil.Banco, SysUtils;

{ TDAOUsuario }

constructor TDAOUsuario.Create;
begin
  FTabela := 'usuario'
end;

function TDAOUsuario.ValidarLogin(const aCpf, aPassword: String): Integer;
var
  xJSONArray: TJSONArray;
begin
  Result := 0;
  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format('SELECT * FROM %S WHERE cpf = %s AND senha = %s',
      [FTabela, QuotedStr(aCpf), QuotedStr(aPassword)]));

    if Assigned(xJSONArray) and (xJSONArray.Count > 0) then
      Result := StrToIntDef(xJSONArray[0].FindValue('id').Value, 0)
  except on e: Exception do
    raise Exception.Create('Erro ao validar usuário: ' + e.Message);
  end;

end;

end.

