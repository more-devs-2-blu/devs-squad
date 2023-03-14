unit UDAO.Ocorrencia;

interface

uses
  UDAO.Base, System.JSON;

type
  TDAOOcorrencia = class(TDAOBase)
    private
      function ProcurarUsuario(const aId: Integer): TJSONObject;
      function ProcurarEnderedeco(const aId: Integer) : TJSONObject;
      function ProcurarTipoProblema(const aId: Integer): String;
      function ProcurarStatus(const aId: Integer): String;
    public
      Constructor Create;
      function ObterRegistros: TJSONArray; override;
      function ObterRegistrosPorUsuario(aIdUsuario: Integer): TJSONArray;
      function ObterRegistrosPorBairro(aBairro: String): TJSONArray;
      function ObterRegistrosPorLogradouro(aLogradouro: String): TJSONArray;
      function ProcurarPorId(const aIdentificador: Integer): TJSONObject; override;
  end;

implementation

uses
  System.SysUtils, UDAO.Intf, UDAO.Status, UDAO.TipoProblema, UDAO.Usuario,
  UDAO.Endereco, UUtil.Banco;

{ TDAOOcorrencia }

constructor TDAOOcorrencia.Create;
begin
  FTabela := 'ocorrencia';
end;

function TDAOOcorrencia.ObterRegistros: TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdTipoProblema: Integer;
  xIdStatus: Integer;
  xIdEndereco: Integer;
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

    xIdEndereco := StrToInt(xJSONObject.GetValue('idendereco').Value);
    xJSONObject.AddPair('endereco', Self.ProcurarEnderedeco(xIdEndereco));
    xJSONObject.RemovePair('idendereco');

    xIdStatus := StrToInt(xJSONObject.GetValue('idstatus').Value);
    xJSONObject.AddPair('status', Self.ProcurarStatus(xIdStatus));
    xJSONObject.RemovePair('idstatus');

    xIdTipoProblema := StrToInt(xJSONObject.GetValue('idtipoproblema').Value);
    xJSONObject.AddPair('tipoProblema', Self.ProcurarTipoProblema(xIdTipoProblema));
    xJSONObject.RemovePair('idtipoproblema');

    xJSONArrayAux.AddElement(xJSONObject);
  end;

  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOOcorrencia.ObterRegistrosPorBairro(aBairro: String): TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdTipoProblema: Integer;
  xIdStatus: Integer;
  xIdEndereco: Integer;
begin

  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format(
      'SELECT * FROM OCORRENCIA LEFT JOIN ENDERECO ON OCORRENCIA.idendereco = ENDERECO.id WHERE bairro = "%s";',
      [aBairro]));
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

    xIdEndereco := StrToInt(xJSONObject.GetValue('idendereco').Value);
    xJSONObject.AddPair('endereco', Self.ProcurarEnderedeco(xIdEndereco));
    xJSONObject.RemovePair('idendereco');

    xIdStatus := StrToInt(xJSONObject.GetValue('idstatus').Value);
    xJSONObject.AddPair('status', Self.ProcurarStatus(xIdStatus));
    xJSONObject.RemovePair('idstatus');

    xIdTipoProblema := StrToInt(xJSONObject.GetValue('idtipoproblema').Value);
    xJSONObject.AddPair('tipoProblema', Self.ProcurarTipoProblema(xIdTipoProblema));
    xJSONObject.RemovePair('idtipoproblema');

    xJSONArrayAux.AddElement(xJSONObject);
  end;

  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOOcorrencia.ObterRegistrosPorLogradouro(
  aLogradouro: String): TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdTipoProblema: Integer;
  xIdStatus: Integer;
  xIdEndereco: Integer;
begin

  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format(
      'SELECT * FROM OCORRENCIA LEFT JOIN ENDERECO ON OCORRENCIA.idendereco = ENDERECO.id WHERE logradouro = "%s";',
      [aLogradouro]));
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

    xIdEndereco := StrToInt(xJSONObject.GetValue('idendereco').Value);
    xJSONObject.AddPair('endereco', Self.ProcurarEnderedeco(xIdEndereco));
    xJSONObject.RemovePair('idendereco');

    xIdStatus := StrToInt(xJSONObject.GetValue('idstatus').Value);
    xJSONObject.AddPair('status', Self.ProcurarStatus(xIdStatus));
    xJSONObject.RemovePair('idstatus');

    xIdTipoProblema := StrToInt(xJSONObject.GetValue('idtipoproblema').Value);
    xJSONObject.AddPair('tipoProblema', Self.ProcurarTipoProblema(xIdTipoProblema));
    xJSONObject.RemovePair('idtipoproblema');

    xJSONArrayAux.AddElement(xJSONObject);
  end;

  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOOcorrencia.ObterRegistrosPorUsuario(
  aIdUsuario: Integer): TJSONArray;
var
  xJSONArray, xJSONArrayAux: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdTipoProblema: Integer;
  xIdStatus: Integer;
  xIdEndereco: Integer;
begin

  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format('SELECT * FROM %s WHERE idusuario = %d',
      [FTabela, aIdUsuario]));
  except
    on e: Exception do
      raise Exception.Create('Erro ao Obter Registros: ' + e.Message);
  end;

  if xJSONArray.Count = 0 then
    Exit(xJSONArray);

  xJSONArrayAux := TJSONArray.Create;
  xJSONObject := TJSONObject.Create;
  for I := 0 to Pred(xJSONArray.Count) do
  begin
    xJSONObject := TJSONObject.ParseJSONValue(
      TEncoding.ASCII.GetBytes(
        xJSONArray[I].ToJSON), 0) as TJSONObject;

    xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
    xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
    xJSONObject.RemovePair('idusuario');

    xIdEndereco := StrToInt(xJSONObject.GetValue('idendereco').Value);
    xJSONObject.AddPair('endereco', Self.ProcurarEnderedeco(xIdEndereco));
    xJSONObject.RemovePair('idendereco');

    xIdStatus := StrToInt(xJSONObject.GetValue('idstatus').Value);
    xJSONObject.AddPair('status', Self.ProcurarStatus(xIdStatus));
    xJSONObject.RemovePair('idstatus');

    xIdTipoProblema := StrToInt(xJSONObject.GetValue('idtipoproblema').Value);
    xJSONObject.AddPair('tipoProblema', Self.ProcurarTipoProblema(xIdTipoProblema));
    xJSONObject.RemovePair('idtipoproblema');

    xJSONArrayAux.AddElement(xJSONObject);
  end;

  FreeAndNil(xJSONArray);
  Result := xJSONArrayAux;
end;

function TDAOOcorrencia.ProcurarPorId(const aIdentificador: Integer): TJSONObject;
var
  xJSONObject: TJSONObject;
  xIdUser: Integer;
  xIdTipoProblema: Integer;
  xIdStatus: Integer;
  xIdEndereco: Integer;
begin
  xJSONObject := inherited;

  if xJSONObject.Count = 0 then
    Exit(xJSONObject);

  xIdUser := StrToInt(xJSONObject.GetValue('idusuario').Value);
  xJSONObject.AddPair('usuario', Self.ProcurarUsuario(xIdUser));
  xJSONObject.RemovePair('idusuario');

  xIdEndereco := StrToInt(xJSONObject.GetValue('idendereco').Value);
  xJSONObject.AddPair('endereco', Self.ProcurarEnderedeco(xIdEndereco));
  xJSONObject.RemovePair('idendereco');

  xIdStatus := StrToInt(xJSONObject.GetValue('idstatus').Value);
  xJSONObject.AddPair('status', Self.ProcurarStatus(xIdStatus));
  xJSONObject.RemovePair('idstatus');

  xIdTipoProblema := StrToInt(xJSONObject.GetValue('idtipoproblema').Value);
  xJSONObject.AddPair('tipoProblema', Self.ProcurarTipoProblema(xIdTipoProblema));
  xJSONObject.RemovePair('idtipoproblema');

  Result := xJSONObject;
end;

function TDAOOcorrencia.ProcurarStatus(const aId: Integer): String;
var
  xDAO: IDAO;
  xConsulta: TJSONObject;
begin
  xDAO := TDAOStatus.Create;
  try
    xConsulta := xDAO.ProcurarPorId(aId);
    Result := xConsulta.GetValue('nome').Value;
  finally
    xDAO := nil;
  end;
end;

function TDAOOcorrencia.ProcurarTipoProblema(const aId: Integer): String;
var
  xDAO: IDAO;
  xConsulta : TJSONObject;
begin
  xDAO := TDAOTipoProblema.Create;
  try
    xConsulta := xDAO.ProcurarPorId(aId);
    Result := xConsulta.GetValue('nome').Value;
  finally
    xDAO := nil;
  end;
end;

function TDAOOcorrencia.ProcurarEnderedeco(const aId: Integer): TJSONObject;
var
  xDAO: IDAO;
begin
  xDAO := TDAOEndereco.Create;
  try
    Result := xDAO.ProcurarPorId(aId);
  finally
    xDAO := nil;
  end;
end;

function TDAOOcorrencia.ProcurarUsuario(const aId: Integer): TJSONObject;
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
