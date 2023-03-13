unit UfrmHome;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts;

type
  TfrmHome = class(TForm)
    rectUsuario: TRectangle;
    crcUsuario: TCircle;
    Image1: TImage;
    lblSair: TLabel;
    lblApoios: TLabel;
    lblHome: TLabel;
    lblCriarOcorrencia: TLabel;
    lblSuasOcorrencias: TLabel;
    lytContainer: TLayout;
    procedure lblSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lblCriarOcorrenciaClick(Sender: TObject);
    procedure lblSuasOcorrenciasClick(Sender: TObject);
    procedure lblPesquisarOcorrenciasClick(Sender: TObject);
    procedure lblApoiosClick(Sender: TObject);
    procedure lblHomeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
    procedure RemoverTelaAnterior;
  public
    { Public declarations }
  end;

var
  frmHome: TfrmHome;

implementation

{$R *.fmx}

uses UFraHome, UfraCriarOcorrencia, UfraOcorrencias, UfraApoios;

procedure TfrmHome.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfrmHome.FormShow(Sender: TObject);
begin
  if not assigned(FraHome) then
    FraHome := TFraHome.Create(Application);

  FraHome.Align := TAlignLayout.Center;
  lytContainer.AddObject(FraHome);
end;

procedure TfrmHome.lblApoiosClick(Sender: TObject);
begin
    Self.RemoverTelaAnterior;

  if not assigned(FraApoio) then
    FraApoio := TFraApoio.Create(Application);

  FraApoio.Align := TAlignLayout.Center;
  lytContainer.AddObject(FraApoio);
end;

procedure TfrmHome.lblCriarOcorrenciaClick(Sender: TObject);
begin
  Self.RemoverTelaAnterior;

  if not assigned(FraCriarOcorrencia) then
    FraCriarOcorrencia := TFraCriarOcorrencia.Create(Application);

  FraCriarOcorrencia.Align := TAlignLayout.Center;
  lytContainer.AddObject(FraCriarOcorrencia);
end;

procedure TfrmHome.lblHomeClick(Sender: TObject);
begin
  Self.RemoverTelaAnterior;

  if not assigned(FraHome) then
    FraHome := TFraHome.Create(Application);

  FraHome.Align := TAlignLayout.Center;
  lytContainer.AddObject(FraHome);
end;

procedure TfrmHome.lblPesquisarOcorrenciasClick(Sender: TObject);
begin
  //não implementado
end;

procedure TfrmHome.lblSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmHome.lblSuasOcorrenciasClick(Sender: TObject);
begin
  Self.RemoverTelaAnterior;

  if not assigned(FraOcorrencia) then
    FraOcorrencia := TFraOcorrencias.Create(Application);

  FraOcorrencia.Align := TAlignLayout.Center;
  FraOcorrencia.CarregarRegistros;
  lytContainer.AddObject(FraOcorrencia);
end;

procedure TfrmHome.RemoverTelaAnterior;
var
  I: Integer;
begin
  for I := Pred(lytContainer.ControlsCount) downto 0 do
    lytContainer.RemoveObject(I);
end;

end.
