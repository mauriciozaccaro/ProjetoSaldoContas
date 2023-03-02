unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao;

type
  TfrmCadClientes = class(TfrmHerancaCadastros)
    edtCodigo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtDocumento: TLabeledEdit;
    ckSituacao: TCheckBox;
    QryListagemGridIdCliente: TLargeintField;
    QryListagemGridnome: TWideStringField;
    QryListagemGridnumDocumento: TLargeintField;
    QryListagemGridsituacao: TWideStringField;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

{$R *.dfm}

procedure TfrmCadClientes.FormShow(Sender: TObject);
begin
  inherited;
  QryListagemGrid.Open;
end;

end.
