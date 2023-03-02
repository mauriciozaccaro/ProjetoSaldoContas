unit uCadMovBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, Vcl.Buttons, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, cMovBancario, uEnum, uDTMConexao, uConsultaContaBancaria, uHerancaConsulta;

type
  TfrmCadMovBancario = class(TfrmHerancaCadastros)
    edtCodigo: TLabeledEdit;
    Label1: TLabel;
    edtBanco: TMaskEdit;
    Label2: TLabel;
    edtCliente: TMaskEdit;
    Label3: TLabel;
    edtValor: TCurrencyEdit;
    btnBuscaBanco: TSpeedButton;
    btnBuscaCliente: TSpeedButton;
    edtNomeCliente: TEdit;
    edtNomeBanco: TEdit;
    edtNumConta: TLabeledEdit;
    Label4: TLabel;
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
    rdgCredDeb: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);

  private
    { Private declarations }
    objMovConta : TMovBancario;
    function Gravar(EstadoTela : TEstadoDaTela)  : Boolean; override;
    function Excluir  : Boolean; override;

  public
    { Public declarations }
  end;

var
  frmCadMovBancario: TfrmCadMovBancario;

implementation

{$R *.dfm}



{$region 'Eventos da propria tela e bot�es'}

procedure TfrmCadMovBancario.FormClose(Sender: TObject;
var Action: TCloseAction);
begin
  inherited;
    if Assigned(objMovConta) then
    FreeAndNil(objMovConta);
end;



procedure TfrmCadMovBancario.FormCreate(Sender: TObject);
begin
  inherited;
  objMovConta    := TMovBancario.Create(DtmConexaoPrincipal.ConexaoDB);
end;



procedure TfrmCadMovBancario.btnAlterarClick(Sender: TObject);
var ativo : String;
begin
TrueBoolStrs := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

  if (objMovConta.SelecionarRegistro(QryListagemGrid.FieldByName('IdMovContas').AsInteger)) then
  begin
    edtCodigo.Text          := IntToStr(objMovConta.codigo);
    edtBanco.Text           := IntToStr(objMovConta.codConta);
    edtValor.Text           := FloatToStr(objMovConta.valor);
    edtSituacao.Text        := objMovConta.situacao;
   // cbTipoMovimento.Text    := objMovConta.tipoMovimento;
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;

end;


{$endregion}




procedure TfrmCadMovBancario.btnBuscaBancoClick(Sender: TObject);
begin
  inherited;
  frmConsultaContaBancaria  := TfrmConsultaContaBancaria.Create(Self);
  frmConsultaContaBancaria.ShowModal;

  edtBanco.Text         := frmConsultaContaBancaria.grdListagemConsulta.Fields[0].Text;
  edtNomeBanco.Text     := frmConsultaContaBancaria.grdListagemConsulta.Fields[1].Text;
  edtCliente.Text       := frmConsultaContaBancaria.grdListagemConsulta.Fields[5].Text;
  edtNomeCliente.Text   := frmConsultaContaBancaria.grdListagemConsulta.Fields[4].Text;
  edtNumConta.Text      := frmConsultaContaBancaria.grdListagemConsulta.Fields[2].Text;

  frmConsultaContaBancaria.Release;
end;

procedure TfrmCadMovBancario.btnBuscaClienteClick(Sender: TObject);
begin
  inherited;
  LimparCampos;
end;

procedure TfrmCadMovBancario.btnGravarClick(Sender: TObject);
begin
  if (rdgCredDeb.ItemIndex = -1) then
    MessageDlg('� obrigat�rio informar o Tipo de Movimento', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    abort;

  inherited;
end;

function TfrmCadMovBancario.Excluir: Boolean;
begin

end;


function TfrmCadMovBancario.Gravar(EstadoTela: TEstadoDaTela): Boolean;
begin

end;

end.
