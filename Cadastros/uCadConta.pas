unit uCadConta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls, uEnum,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, cCadConta,
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
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);

  private
    { Private declarations }
    objConta : TCadConta;
    function Gravar(EstadoTela : TEstadoDaTela)  : Boolean; override;
    function Excluir : Boolean; override;

    function PossuiMovimento(campo : String)  : Boolean;

  public
    { Public declarations }

  end;

var
  frmCadContas: TfrmCadContas;
  botaoClicado : Integer;  // [0 - Cliente; 1 - Banco; 2 - Conta Banc�ria]


implementation

{$R *.dfm}

 uses uConsultaContaBancaria;



procedure TfrmCadContas.btnAlterarClick(Sender: TObject);
var ativo : String;
begin
TrueBoolStrs  := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

  if (objConta.SelecionarRegistro(QryListagemGrid.FieldByName('IdConta').AsInteger)) then
  begin
    edtCodigo.Text          := IntToStr(objConta.codConta);
    edtBanco.Text           := IntToStr(objConta.codBanco);
    edtCliente.Text         := IntToStr(objConta.codCliente);
    edtNumConta.Text        := IntToStr(objConta.numConta);
    edtSaldoInicial.Text    := FloatToStr(objConta.saldoInicial);
    ativo                   := objConta.situacao;
    ckSituacao.Checked      := StrToBool(ativo);
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;

end;



procedure TfrmCadContas.btnBuscaBancoClick(Sender: TObject);
begin
  inherited;
  botaoClicado := 1;
  frmConsultaContaBancaria  :=  TfrmConsultaContaBancaria.Create(Self);
  frmConsultaContaBancaria.ShowModal;
  frmConsultaContaBancaria.Release;
end;



procedure TfrmCadContas.btnBuscaClienteClick(Sender: TObject);
begin
  inherited;
  botaoClicado := 0;
  frmConsultaContaBancaria  :=  TfrmConsultaContaBancaria.Create(Self);
  frmConsultaContaBancaria.ShowModal;
  frmConsultaContaBancaria.Release;
end;



function TfrmCadContas.Excluir: Boolean;
begin
  objConta.codConta   := StrToInt(grdListagemGrid.Fields[0].text);
  objConta.codBanco   := StrToInt(grdListagemGrid.Fields[1].text);

  if(MessageDlg('Deseja excluir o registro do Banco '''
              + IntToStr(objConta.codConta)
              + ' -  Nr '
              + IntToStr(objConta.numConta)
              + ''' ? ', TMsgDlgType.mtInformation, [mbYes, mbNo], 0) = mrYes) then

   // lembrar de mudar isso, melhoir criar dentro da classe e s� trazer o Result
  {if(PossuiMovimento(campo) = true then
    MessageDlg('N�o � poss�vel excluir registros que possem movimenta��o!',
                TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0 );
    Abort;         }

  begin
    Result  := objConta.ExcluiRegistro;
  end else
  begin
    Abort;
  end;

end;



procedure TfrmCadContas.FormShow(Sender: TObject);
begin
  inherited;
  QryListagemGrid.Open;
end;



function TfrmCadContas.Gravar(EstadoTela: TEstadoDaTela): Boolean;
begin

end;



function TfrmCadContas.PossuiMovimento(campo : String): Boolean;
begin

end;



end.
