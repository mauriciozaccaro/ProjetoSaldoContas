unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cCliente, uDTMConexao;

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
    procedure btnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    objCliente : TCliente;
  public
    { Public declarations }
  end;

var
  frmCadClientes: TfrmCadClientes;

implementation

{$R *.dfm}


procedure TfrmCadClientes.btnAlterarClick(Sender: TObject);
var ativo : String;
begin
TrueBoolStrs  := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

  if (objCliente.SelecionarRegistro(QryListagemGrid.FieldByName('IdCliente').AsInteger)) then
  begin
    edtCodigo.Text          := IntToStr(objCliente.codigo);
    edtNome.Text            := objCliente.nome;
    edtDocumento.Text       := objCliente.documento;
    ativo                   := objCliente.situacao;
    ckSituacao.Checked      := StrToBool(ativo);
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmCadClientes.FormShow(Sender: TObject);
begin
  inherited;
  QryListagemGrid.Open;
end;

end.
