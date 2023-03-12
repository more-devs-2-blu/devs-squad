unit UFraHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Controls.Presentation, FMX.ListView, FMX.Objects, UfraOcorrencias;

type
  TfraHome = class(TFrame)
    RectApoiar: TRectangle;
    lblApoiar: TLabel;
    lblTituloFrame: TLabel;
    rectLista: TRectangle;
    lstOcorrencias: TListView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fraHome: TFraHome;

implementation

{$R *.fmx}

end.
