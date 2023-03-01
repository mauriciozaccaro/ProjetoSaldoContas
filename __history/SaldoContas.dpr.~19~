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
  cBanco in 'Classes\cBanco.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
