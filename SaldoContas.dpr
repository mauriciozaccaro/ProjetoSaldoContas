program SaldoContas;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  uHerancaCadastros in 'Heranca\uHerancaCadastros.pas' {frmHerancaCadastros},
  uBanco in 'Cadastros\uBanco.pas' {frmCadBancos},
  uCliente in 'Cadastros\uCliente.pas' {frmCadClientes},
  uCadConta in 'Cadastros\uCadConta.pas' {frmCadContas},
  uCadMovBancario in 'Movimentos\uCadMovBancario.pas' {frmCadMovBancario},
  uDTMConexao in 'DataModule\uDTMConexao.pas' {DtmConexaoPrincipal: TDataModule},
  uEnum in 'Heranca\uEnum.pas',
  cBanco in 'Classes\cBanco.pas',
  uHerancaConsulta in 'heranca\uHerancaConsulta.pas' {frmHerancaConsulta},
  cMovBancario in 'Classes\cMovBancario.pas',
  uConsultaContaBancaria in 'Consultas\uConsultaContaBancaria.pas' {frmConsultaContaBancaria},
  cCliente in 'Classes\cCliente.pas',
  cCadConta in 'Classes\cCadConta.pas',
  uRelatorioMovContas in 'Consultas\uRelatorioMovContas.pas' {Form1},
  uHerancaRelatorios in 'heranca\uHerancaRelatorios.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
