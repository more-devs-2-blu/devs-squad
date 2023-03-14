unit UDAO.Endereco;

interface

uses
  UDAO.Base, UEntity.Enderecos, System.JSON;

type
  TDAOEndereco = class(TDAOBase)
  public
    constructor Create;
    function ProcurarIdPorEndereco(const aEndereco: TEndereco): Integer;
  end;

implementation

uses
  UUtil.Banco, System.SysUtils;

{ TDAOEndereco }

constructor TDAOEndereco.Create;
begin
  FTabela := 'endereco';
end;


function TDAOEndereco.ProcurarIdPorEndereco(
  const aEndereco: TEndereco): Integer;
var
  xJSONArray: TJSONArray;
  xJSONObject: TJSONObject;
  I: Integer;
  xIdUser: Integer;
  xIdTipoProblema: Integer;
  xIdStatus: Integer;
  xIdEndereco: Integer;
  xQuery: String;
begin

  xQuery := 'SELECT * FROM %s WHERE cep = "%s" and bairro = "%s" and ' +
    'numero = %d and logradouro = "%s" and complemento = "%s"';
  try
    xJSONArray := TUtilBanco.ExecutarConsulta(
      Format(xQuery,
      [FTabela, aEndereco.Cep,
      aEndereco.Bairro, aEndereco.Numero,
      aEndereco.Logradouro, aEndereco.Complemento]));
  except
    on e: Exception do
      raise Exception.Create('Erro ao Obter Registros: ' + e.Message);
  end;

  if xJSONArray.Count = 0 then
    Exit(0);

  xJSONObject := TJSONObject.ParseJSONValue(
    TEncoding.ASCII.GetBytes(
      xJSONArray[0].ToJSON), 0) as TJSONObject;

  FreeAndNil(xJSONArray);
  xIdEndereco := xJSONObject.GetValue<Integer>('id');
  Result := xJSONObject.GetValue<Integer>('id');
end;

end.

