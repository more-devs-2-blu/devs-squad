unit UfraOcorrencias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Objects, FMX.Controls.Presentation;

type
  TfraOcorrencias = class(TFrame)
    fraOcorrencias: TLabel;
    rectLista: TRectangle;
    lstOcorrencias: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CarregarRegistros;
  end;

var
  FraOcorrencia: TFraOcorrencias;

implementation

uses
  UService.Intf, UService.Ocorrencia, UEntity.Ocorrencias,
  UService.Usuario.Authenticated;

{$R *.fmx}

{ TfraOcorrencias }

procedure TfraOcorrencias.CarregarRegistros;
var
  xServiceOcorrencia : IService;
  xOcorrencia : TOcorrencia;
begin

  xServiceOcorrencia := TServiceOcorrencia.Create;
  TServiceOcorrencia(xServiceOcorrencia).ListaPorUsuario(1);
  for xOcorrencia in TServiceOcorrencia(xServiceOcorrencia).Ocorrencias do
    ShowMessage(xOcorrencia.Endereco.Logradouro);
    ShowMessage(gbInstance.Usuario.Id.ToString);
end;

end.
