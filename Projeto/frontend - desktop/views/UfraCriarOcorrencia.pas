unit UfraCriarOcorrencia;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ListBox, FMX.Edit;

type
  TfraCriarOcorrencia = class(TFrame)
    rectPrincipal: TRectangle;
    rectCEP: TRectangle;
    rectBairro: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    rectNumero: TRectangle;
    rectComplemento: TRectangle;
    Label4: TLabel;
    rectRua: TRectangle;
    Label5: TLabel;
    rectProblema: TRectangle;
    Label6: TLabel;
    rectDescricao: TRectangle;
    Label7: TLabel;
    rbUrgencia: TRadioButton;
    rectEnviar: TRectangle;
    Label8: TLabel;
    edtCEP: TEdit;
    edtBairro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtRua: TEdit;
    edtDescricao: TEdit;
    edtProblema: TEdit;
    Label9: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FraCriarOcorrencia: TfraCriarOcorrencia;

implementation

{$R *.fmx}

end.
