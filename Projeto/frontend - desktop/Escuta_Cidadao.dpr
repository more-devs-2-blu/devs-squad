program Escuta_Cidadao;

uses
  System.StartUpCopy,
  FMX.Forms,
  UfrmHome in 'views/UfrmHome.pas' {frmHome},
  UfraApoios in 'views/UfraApoios.pas' {fraApoio: TFrame},
  UfraOcorrencias in 'views/UfraOcorrencias.pas' {fraOcorrencias: TFrame},
  UfraCriarOcorrencia in 'views/UfraCriarOcorrencia.pas' {fraCriarOcorrencia: TFrame},
  UFraHome in 'views/UFraHome.pas' {fraHome: TFrame},
  UFrmAutenticacao in 'views/UFrmAutenticacao.pas' {frmAutenticacao};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmAutenticacao, frmAutenticacao);
  Application.Run;
end.
