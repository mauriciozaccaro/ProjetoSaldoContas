unit uRelatorioMovBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaRelatorios, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmRelatorioMovBancario = class(TfrmHerancaRelatorio)
    QryRelatorioIdConta: TLargeintField;
    QryRelatoriocliente: TWideStringField;
    QryRelatoriobanco: TWideStringField;
    QryRelatorionumConta: TLargeintField;
    QryRelatoriosaldoInicial: TFloatField;
    QryRelatoriosaldoAnterior: TFloatField;
    QryRelatoriototalCredito: TFloatField;
    QryRelatoriototalDebito: TFloatField;
    QryRelatoriosaldoAtual: TFloatField;
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);
    procedure btnBuscaContaClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  frmRelatorioMovBancario: TfrmRelatorioMovBancario;

implementation

{$R *.dfm}

uses uConsultaContaBancaria, uHerancaConsulta, uCadMovBancario, uConsultaBanco,
  uConsultaCliente;

procedure TfrmRelatorioMovBancario.btnBuscaBancoClick(Sender: TObject);
begin
  LimparCampos;
  inherited;
end;

procedure TfrmRelatorioMovBancario.btnBuscaClienteClick(Sender: TObject);
begin
  LimparCampos;
  inherited;
end;

procedure TfrmRelatorioMovBancario.btnBuscaContaClick(Sender: TObject);
begin
  LimparCampos;
  inherited;
end;

end.
