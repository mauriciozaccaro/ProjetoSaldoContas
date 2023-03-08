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
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);
    procedure btnBuscaContaClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  frmRelatorioMovBancario: TfrmRelatorioMovBancario;

implementation

{$R *.dfm}

uses uConsultaContaBancaria, uHerancaConsulta;

procedure TfrmRelatorioMovBancario.btnBuscaBancoClick(Sender: TObject);
begin
  inherited;
  LimparCampos;
  edtCodBanco.Text        :=  IntToStr(iCampoIdBanco);
  edtNomeBanco.Text       :=  sCampoBanco;
end;

procedure TfrmRelatorioMovBancario.btnBuscaClienteClick(Sender: TObject);
begin
  LimparCampos;
  edtCodCliente.Text      :=  IntToStr(iCampoIdCliente);
  edtNomeCliente.Text     :=  sCampoCliente;
  inherited;
end;

procedure TfrmRelatorioMovBancario.btnBuscaContaClick(Sender: TObject);
begin
  LimparCampos;
  edtCodConta.Text        :=  IntToStr(iCampoIdConta);
  edtNumConta.Text        :=  IntToStr(iCampoNumConta);
  edtCodBanco.Text        :=  IntToStr(iCampoIdBanco);
  edtCodCliente.Text      :=  IntToStr(iCampoIdCliente);
  edtNomeBanco.Text       :=  sCampoBanco;
  edtNomeCliente.Text     :=  sCampoCliente;
  inherited;
end;

procedure TfrmRelatorioMovBancario.Button1Click(Sender: TObject);
begin
  inherited;

end;

end.
