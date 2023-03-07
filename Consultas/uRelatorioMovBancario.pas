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
    QryRelatoriototalCredito: TLargeintField;
    QryRelatoriototalDebito: TLargeintField;
    QryRelatoriosaldoAtual: TLargeintField;
    procedure btnBuscaBancoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorioMovBancario: TfrmRelatorioMovBancario;
  botaoClicado : Integer;

implementation

{$R *.dfm}

uses uConsultaContaBancaria;

procedure TfrmRelatorioMovBancario.btnBuscaBancoClick(Sender: TObject);
begin
  inherited;
  botaoClicado    := 1;
  frmConsultaContaBancaria    :=  TfrmConsultaContaBancaria.Create(Self);
  frmConsultaContaBancaria.ShowModal;
  frmConsultaContaBancaria.Release;
end;

end.
