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
  end;

var
  FraOcorrencia: TFraOcorrencias;

implementation

{$R *.fmx}

end.
