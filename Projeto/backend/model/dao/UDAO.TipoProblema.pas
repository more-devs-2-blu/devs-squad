unit UDAO.TipoProblema;

interface

uses
  UDAO.Base;

type
  TDAOTipoProblema = class(TDAOBase)
  public
    constructor Create;
  end;

implementation

{ TDAOTipoProblema }

constructor TDAOTipoProblema.Create;
begin
  FTabela := 'tipoProblema';
end;


end.

