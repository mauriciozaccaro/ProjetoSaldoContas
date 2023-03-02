unit uCadConta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Buttons, RxToolEdit, RxCurrEdit, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmCadContas = class(TfrmHerancaCadastros)
    edtCodigo: TLabeledEdit;
    edtNumConta: TLabeledEdit;
    Label1: TLabel;
    btnBuscaBanco: TSpeedButton;
    ckSituacao: TCheckBox;
    Label2: TLabel;
    btnBuscaCliente: TSpeedButton;
    edtSaldoInicial: TCurrencyEdit;
    Label3: TLabel;
    edtBanco: TMaskEdit;
    edtCliente: TMaskEdit;
    edtNomeBanco: TEdit;
    edtNomeCliente: TEdit;
    QryListagemGridIdConta: TLargeintField;
    QryListagemGridBanco: TWideStringField;
    QryListagemGridCliente: TWideStringField;
    QryListagemGridnumConta: TLargeintField;
    QryListagemGridsaldoInicial: TFloatField;
    QryListagemGridsituacao: TWideStringField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadContas: TfrmCadContas;

implementation

{$R *.dfm}

procedure TfrmCadContas.FormShow(Sender: TObject);
begin
  inherited;
  QryListagemGrid.Open;
end;

end.
