unit UfraCriarOcorrencia;

interface

uses
  System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.ListBox, FMX.Edit, FMX.Memo.Types,
  FMX.ScrollBox,
  FMX.Memo, uDados;

type
  TfraCriarOcorrencia = class(TFrame)
    rectPrincipal: TRectangle;
    rectCEP: TRectangle;
    rectBairro: TRectangle;
    lblCEP: TLabel;
    lblBairro: TLabel;
    lblNumero: TLabel;
    rectNumero: TRectangle;
    rectComplemento: TRectangle;
    lblComplemento: TLabel;
    rectRua: TRectangle;
    lblRua: TLabel;
    rectProblema: TRectangle;
    lblProblema: TLabel;
    rectDescricao: TRectangle;
    lblDescricao: TLabel;
    rbUrgencia: TRadioButton;
    rectEnviar: TRectangle;
    lblEnviar: TLabel;
    edtCEP: TEdit;
    edtBairro: TEdit;
    edtNumero: TEdit;
    edtComplemento: TEdit;
    edtRua: TEdit;
    edtDescricao: TEdit;
    lblTituloFrame: TLabel;
    rectPesquisa: TRectangle;
    imgLupa: TImage;
    cmbProblema: TComboBox;
    procedure rectPesquisaClick(Sender: TObject);
    procedure rectEnviarClick(Sender: TObject);
  private
    { Private declarations }
    procedure BuscarCEP;
    procedure Registrar;
  public
    { Public declarations }
  end;

var
  FraCriarOcorrencia: TfraCriarOcorrencia;

implementation

uses
  UService.Intf,
  UService.Ocorrencia,
  UService.Endereco,
  UEntity.Enderecos,
  UEntity.Ocorrencias,
  System.SysUtils, UService.Usuario.Authenticated, UUtils.Functions,
  UEntity.Usuarios;

{$R *.fmx}

procedure TfraCriarOcorrencia.BuscarCEP;
begin
  DmDados.RESTClient1.BaseURL := 'https://viacep.com.br/ws/' + edtCEP.Text + '/json';

  try
    DmDados.RESTRequest1.Execute;
    edtBairro.Text := DmDados.FDMemTable1.FieldByName('bairro').AsString;
    edtRua.Text := DmDados.FDMemTable1.FieldByName('logradouro').AsString;
  except
    on e: exception do
      raise Exception.Create('Não foi encontrado dados do CEP informado. ');
  end;
end;

procedure TfraCriarOcorrencia.rectEnviarClick(Sender: TObject);
begin
  Self.Registrar;
end;

procedure TfraCriarOcorrencia.rectPesquisaClick(Sender: TObject);
begin
  BuscarCEP;
end;

procedure TfraCriarOcorrencia.Registrar;
var
  xServiceOcorrencia: IService;
  xOcorrencia: TOcorrencia;

  xServiceEndereco: IService;
  xEndereco: TEndereco;
  xIdEndereco: Integer;

  xUsuario: TUsuario;

begin
  if Trim(edtCEP.Text) = EmptyStr then
    raise Exception.Create('Informe o CEP.');

  if Trim(edtBairro.Text) = EmptyStr then
    raise Exception.Create('Informe o Bairro.');

  if Trim(edtRua.Text) = EmptyStr then
    raise Exception.Create('Informe a Rua.');

  if Trim(edtNumero.Text) = EmptyStr then
    raise Exception.Create('Informe o Número.');

  if Trim(edtComplemento.Text) = EmptyStr then
    raise Exception.Create('Informe o Complemento.');

  if cmbProblema.ItemIndex = -1 then
    raise Exception.Create('Informe o Problema da Ocorrência.');

  if Trim(edtDescricao.Text) = EmptyStr then
    raise Exception.Create('Informe a Descrição.');

  xEndereco := TEndereco.Create(
                      StrToInt(Trim(edtNumero.Text)),
                      Trim(edtCEP.Text),
                      Trim(edtBairro.Text),
                      Trim(edtRua.Text),
                      Trim(edtComplemento.Text));

  xServiceEndereco := TServiceEndereco.Create(xEndereco);
  xServiceEndereco.Registrar;

//  xServiceEndereco := TServiceEndereco.Create(xEndereco);
  xIdEndereco := TServiceEndereco(xServiceEndereco).ObterId(xEndereco);

  xEndereco.Free;

  xEndereco := TEndereco.Create(
                      StrToInt(Trim(edtNumero.Text)),
                      Trim(edtCEP.Text),
                      Trim(edtBairro.Text),
                      Trim(edtRua.Text),
                      Trim(edtComplemento.Text),
                      xIdEndereco);

  xServiceOcorrencia := TServiceOcorrencia.Create(
    TOcorrencia.Create( 0,
                        0,
                        Now,
                        0,
                        0,
                        TUtilsFunctions.IIF<Byte>(rbUrgencia.IsChecked,1,0),
                        Trim(edtDescricao.Text),
                        cmbProblema.ItemIndex.ToString,
                        '1',
                        GbInstance.Usuario,
                        xEndereco));

  try
    xServiceOcorrencia.Registrar;
    ShowMessage('Ocorrência registrada com sucesso.');
  except
    on e: exception do
      raise Exception.Create('Erro: ' + E.Message);
  end;

end;

end.
