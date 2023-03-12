unit UfraApoios;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation;

type
  TfraApoio = class(TFrame)
    rectLista: TRectangle;
    lstApoio: TListView;
    lblTituloFrame: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FraApoio: TFraApoio;

implementation

{$R *.fmx}

end.
