unit UFrmAutenticacao;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Edit;

type
  TfrmAutenticacao = class(TForm)
    rectPrincipal: TRectangle;
    lytPrincipal: TLayout;
    lytTitulo: TLayout;
    imgTitulo: TImage;
    lytBotoes: TLayout;
    RectCPF: TRectangle;
    RectSenha: TRectangle;
    RectEntrar: TRectangle;
    lblEntrar: TLabel;
    lblEntreComCPF: TLabel;
    Label2: TLabel;
    CircInfo: TCircle;
    CircFechar: TCircle;
    Label4: TLabel;
    Z: TLabel;
    Label3: TLabel;
    edtCPF: TEdit;
    edtSenha: TEdit;
    procedure CircFecharClick(Sender: TObject);
    procedure RectEntrarClick(Sender: TObject);
  private
    { Private declarations }
    procedure AbrirHome;
    procedure Logar;
  public
    { Public declarations }
  end;

var
  frmAutenticacao: TfrmAutenticacao;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

uses UfrmHome, UService.Intf, UService.Login, UEntity.Logins;

procedure TfrmAutenticacao.CircFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmAutenticacao.Logar;
var
  xCPF, xSenha: String;
  xServiceLogin: IService;
begin
   xCPF := edtCPF.Text;
  xSenha := edtSenha.Text;
  if Trim(edtCPF.Text) = EmptyStr then
      raise Exception.Create('Informe o CPF.');

  if Trim(edtSenha.Text) = EmptyStr then
    raise Exception.Create('Informe a Senha.');

  xServiceLogin := TServiceLogin.Create(
    TLogin.Create(Trim(edtCPF.Text),
                  Trim(edtSenha.Text)));

  try
    TServiceLogin(xServiceLogin).Autenticar;
    Self.AbrirHome;
    frmAutenticacao.Close
  except
    on e: exception do
      raise Exception.Create('Login: ' + e.Message);
  end;
end;

procedure TfrmAutenticacao.RectEntrarClick(Sender: TObject);
begin
  Self.Logar;
end;

procedure TfrmAutenticacao.AbrirHome;
begin
  if not Assigned(frmHome) then
    frmHome := TfrmHome.Create(application);

  frmHome.Show;
  Application.MainForm := frmHome;
end;

end.
