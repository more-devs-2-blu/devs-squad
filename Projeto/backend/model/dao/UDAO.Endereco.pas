unit UDAO.Endereco;

interface

uses
  UDAO.Base;

type
  TDAOEndereco = class(TDAOBase)
  public
    constructor Create;
  end;

implementation

{ TDAOEndereco }

constructor TDAOEndereco.Create;
begin
  FTabela := 'endereco';
end;


end.

