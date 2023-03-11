unit UDAO.Status;

interface

uses
  UDAO.Base;

type
  TDAOStatus = class(TDAOBase)
  public
    constructor Create;
  end;

implementation

{ TDAOStatus }

constructor TDAOStatus.Create;
begin
  FTabela := 'status';
end;


end.

