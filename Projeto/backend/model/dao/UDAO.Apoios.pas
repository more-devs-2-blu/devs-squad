unit UDAO.Apoios;

interface

uses
  UDAO.Base, System.JSON;

type
  TDAOApoios = class(TDAOBase)
    private
      function ProcurarUsuario(const aId: Integer): TJSONObject;
      function ProcurarOcorrencia(const aId: Integer) : TJSONObject;
    public
      Constructor Create;
      function ObterRegistros: TJSONArray; override;
      function ObterRegistrosPorUsuario(aIdUsuario: Integer): TJSONArray;
      function ProcurarPorId(const aIdentificador: Integer): TJSONObject; override;
  end;

implementation

uses
  System.SysUtils, UDAO.Intf, UDAO.Usuario, UDAO.Ocorrencia, UUtil.Banco;

{ TDAOApoios }

constructor TDAOApoios.Create;
begin
  FTabela := 'apoio';
end;

function TDAOApoios.ObterRegistros: TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdOcorrencia: Integer;
begin
  xJSONArray := inherited;

  if xJSONArray.Count = 0 then
    Exit(xJSONArray);

  xJSONArrayAux := TJSONArray.Create;

  for I := 0 to Pred(xJSONArray.Count) do
  begin
    xJSONObject := TJSONObject.ParseJSONValue(
      TEncoding.ASCII.GetBytes(
        xJSONArray[I].ToJSON), 0) as TJSONObject;

    xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
    xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
    xJSONObject.RemovePair('idusuario');

    xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
    xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
    xJSONObject.RemovePair('idusuario');

    xIdOcorrencia := StrToInt(xJSONObject.GetValue('idocorrencia').Value);
    xJSONObject.AddPair('ocorrencia', Self.ProcurarOcorrencia(xIdOcorrencia));
    xJSONObject.RemovePair('idocorrencia');

    xJSONArrayAux.AddElement(xJSONObject);
  end;

  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOApoios.ObterRegistrosPorUsuario(aIdUsuario: Integer): TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdOcorrencia: Integer;
begin

  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format('SELECT * FROM %s WHERE id = %d',
      [FTabela, aIdUsuario]));
  except
    on e: Exception do
      raise Exception.Create('Erro ao Obter Registros: ' + e.Message);
  end;

  if xJSONArray.Count = 0 then
    Exit(xJSONArray);

  xJSONArrayAux := TJSONArray.Create;

  for I := 0 to Pred(xJSONArray.Count) do
  begin
    xJSONObject := TJSONObject.ParseJSONValue(
      TEncoding.ASCII.GetBytes(
        xJSONArray[I].ToJSON), 0) as TJSONObject;

    xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
    xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
    xJSONObject.RemovePair('idusuario');

    xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
    xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
    xJSONObject.RemovePair('idusuario');

    xIdOcorrencia := StrToInt(xJSONObject.GetValue('idocorrencia').Value);
    xJSONObject.AddPair('ocorrencia', Self.ProcurarOcorrencia(xIdOcorrencia));
    xJSONObject.RemovePair('idocorrencia');

    xJSONArrayAux.AddElement(xJSONObject);
  end;

  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOApoios.ProcurarPorId(const aIdentificador: Integer): TJSONObject;
var
  xJSONObject: TJSONObject;
  xIdUser: Integer;
  xIdOcorrencia: Integer;
begin
  xJSONObject := inherited;

  if xJSONObject.Count = 0 then
    Exit(xJSONObject);

  xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
  xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
  xJSONObject.RemovePair('idusuario');

  xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
  xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
  xJSONObject.RemovePair('idusuario');

  xIdOcorrencia := StrToInt(xJSONObject.GetValue('idocorrencia').Value);
  xJSONObject.AddPair('ocorrencia', Self.ProcurarOcorrencia(xIdOcorrencia));
  xJSONObject.RemovePair('idocorrencia');

  Result := xJSONObject;
end;

function TDAOApoios.ProcurarOcorrencia(const aId: Integer): TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAOOcorrencia.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

function TDAOApoios.ProcurarUsuario(const aId: Integer): TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAOUsuario.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

end.
