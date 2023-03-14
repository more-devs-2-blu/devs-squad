unit UfraApoios;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Controls.Presentation, Skia,
  Skia.FMX;

type
  TfraApoio = class(TFrame)
    rectLista: TRectangle;
    lstApoio: TListView;
    lblTituloFrame: TLabel;
    TimerGifCarregar: TTimer;
    SkAnimatedImage1: TSkAnimatedImage;
    procedure TimerGifCarregarTimer(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarRegistros;
    procedure IniciarGifLoad;
  public
    { Public declarations }
  end;

var
  FraApoio: TFraApoio;

implementation

uses
  UEntity.Apoios, UService.Intf, UService.Apoio,
  UService.Usuario.Authenticated;

{$R *.fmx}

{ TfraApoio }

procedure TfraApoio.CarregarRegistros;
var
  xServiceApoio: IService;
  xApoio: TApoios;
begin
  try
//    lstOcorrencias.Items.Clear;

    xServiceApoio := TServiceApoio.Create;
    TServiceApoio(xServiceApoio).
      ListarApoiosDeUsuario(GbInstance.Usuario.Id);

    for xApoio in TServiceApoio(xServiceApoio).Apoios do
//      Self.PrepararListView(xOcorrencia);
        ShowMessage(xApoio.Ocorrencia.Usuario.Nome);
  except

  end;
end;

procedure TfraApoio.IniciarGifLoad;
begin
  TimerGifCarregar.Enabled := false;
  SkAnimatedImage1.Visible := False;
  CarregarRegistros;
end;

procedure TfraApoio.TimerGifCarregarTimer(Sender: TObject);
begin
  IniciarGifLoad;
end;

end.
