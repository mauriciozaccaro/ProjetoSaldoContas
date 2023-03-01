unit uCadMovBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, Vcl.Buttons, ZAbstractRODataset, ZAbstractDataset,
  ZDataset;

type
  TfrmCadMovBancario = class(TfrmHerancaCadastros)
    edtCodigo: TLabeledEdit;
    Label1: TLabel;
    edtBanco: TMaskEdit;
    Label2: TLabel;
    edtCliente: TMaskEdit;
    Label3: TLabel;
    edtSaldoInicial: TCurrencyEdit;
    btnBuscaBanco: TSpeedButton;
    btnBuscaCliente: TSpeedButton;
    edtNomeCliente: TEdit;
    edtNomeBanco: TEdit;
    edtNumConta: TLabeledEdit;
    Label4: TLabel;
    Label5: TLabel;
    cbTipoMovimento: TDBLookupComboBox;
    edtSituacao: TLabeledEdit;
    QryBuscaConta: TZQuery;
    DataSource1: TDataSource;
    dtsBuscaConta: TDataSource;
    QryListagemGridIdMovContas: TLargeintField;
    QryListagemGridcliente: TWideStringField;
    QryListagemGridbanco: TWideStringField;
    QryListagemGridnumConta: TLargeintField;
    QryListagemGridvalor: TFloatField;
    QryListagemGridtipoMov: TWideMemoField;
    QryListagemGridsituacao: TWideMemoField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadMovBancario: TfrmCadMovBancario;

implementation

{$R *.dfm}

procedure TfrmCadMovBancario.FormCreate(Sender: TObject);
begin
  inherited;
//  if Assigned(objMovBanco) then
  //  FreeAndNil(objMovBanco;)
end;

end.
