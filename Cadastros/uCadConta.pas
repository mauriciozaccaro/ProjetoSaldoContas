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
    QryListagemGridIdBanco: TLargeintField;
    QryListagemGridIdCliente: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure mskEditChange(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);

  private
    { Private declarations }
    objConta : TCadConta;
    function Gravar(EstadoTela : TEstadoDaTela)  : Boolean; override;
    function Excluir : Boolean; override;
    function PossuiMovimento(campo : String)  : Boolean;

    procedure LimparCampos; override;

  public
    { Public declarations }

  end;

var
  frmCadContas: TfrmCadContas;
  botaoClicado : Integer;  // [0 - Cliente; 1 - Banco; 2 - Conta Banc�ria]


implementation

{$R *.dfm}

 uses uConsultaContaBancaria, uDTMConexao;



procedure TfrmCadContas.btnAlterarClick(Sender: TObject);
var ativo : String;
begin
  inherited;
  try
  TrueBoolStrs  := ['S', 's'];
  FalseBoolStrs := ['N', 'n'];

    if (objConta.SelecionarRegistro(QryListagemGrid.FieldByName('IdConta').AsInteger)) then
    begin
      edtCodigo.Text          := IntToStr(objConta.codConta);
      edtBanco.Text           := IntToStr(objConta.codBanco);
      edtNomeBanco.Text       := objConta.banco;
      edtCliente.Text         := IntToStr(objConta.codCliente);
      edtNomeCliente.Text     := objConta.cliente;
      edtNumConta.Text        := IntToStr(objConta.numConta);
      edtSaldoInicial.Text    := FloatToStr(objConta.saldoInicial);
      ativo                   := objConta.situacao;
      ckSituacao.Checked      := StrToBool(ativo);

     { somente um teste
      edtBanco.Enabled        := false;
      edtNomeBanco.Enabled    := false;
      edtCliente.Enabled      := false;
      edtNomeCliente.Enabled  := false;
      }


    end
    else begin
      btnCancelar.Click;
      Abort;
    end;

finally
end;


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



procedure TfrmCadContas.btnNovoClick(Sender: TObject);
begin
  inherited;
  LimparCampos;
  edtCliente.Text := ''

end;



function TfrmCadContas.Excluir: Boolean;
var nr : Integer;
begin
  objConta.codConta   := StrToInt(grdListagemGrid.Fields[0].text);
  nr                  :=StrToInt(grdListagemGrid.Fields[3].text);

  if(MessageDlg('Deseja excluir o registro do Banco '''
              + IntToStr(objConta.codConta)
              + ' -  Nr '
              + IntToStr(nr)
              + ''' ? ', TMsgDlgType.mtInformation, [mbYes, mbNo], 0) = mrYes) then
  begin

    if(objConta.PossuiMovimento(objConta.codConta) = true) then
    begin
    MessageDlg('Conta possui movimento, imposs�vel excluir! ' +#13+#13
             + 'Se dejesar, voc� pode zerar (0,00) o saldo e ''inativar'' a conta.',
               TMsgDlgType.mtError, [mbOk], 0);
    Abort;
    end;

   Result  := objConta.ExcluiRegistro;

  end else
  begin
    Abort;
  end;

end;



procedure TfrmCadContas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(objConta) then
    FreeAndNil(objConta);
end;



procedure TfrmCadContas.FormCreate(Sender: TObject);
begin
  inherited;
  objConta    := TCadConta.Create(DtmConexaoPrincipal.ConexaoDB);
end;



procedure TfrmCadContas.FormShow(Sender: TObject);
begin
  inherited;
  QryListagemGrid.Open;
end;



function TfrmCadContas.Gravar(EstadoTela: TEstadoDaTela): Boolean;
var ativo : Boolean;
begin
TrueBoolStrs := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

    if (edtCodigo.Text <> EmptyStr) then
      objConta.codConta  := StrToInt(edtCodigo.Text)
    else
      objConta.codConta  := 0;

    if(edtSaldoInicial.Text <> EmptyStr) then
      objConta.saldoInicial := StrToFloat(edtSaldoInicial.Text)
    else
      objConta.saldoInicial := 0;

    objConta.codBanco    := StrToInt(edtBanco.Text);
    objConta.codCliente  := StrToInt(edtCliente.Text);
    objConta.numConta    := StrToInt(edtNumConta.Text);
    ativo                := ckSituacao.Checked;
    objConta.situacao    := BoolToStr(ativo, true);

    if (EstadoTela = etNovo) then
    begin
      Result    := objConta.InserirRegistro;
      ShowMessage('Cadastrado com Sucesso!')
    end
    else if (EstadoTela = etAlterar) then
    begin
      Result    := objConta.AtualizarRegistro;
      ShowMessage('Altera��o realizada com sucesso')
    end;
end;



procedure TfrmCadContas.LimparCampos;
begin
  inherited;
  edtNomeBanco.Clear;
  edtNomeCliente.Clear;
end;

procedure TfrmCadContas.mskEditChange(Sender: TObject);
begin
  inherited;
  with QryListagemGrid do
  begin
    Close;
    SQL.Clear;
    // SQL ta dando errado... arrumar depois
    SQL.Add('SELECT ct.IdConta, '
                + ' bc.nome AS Banco, '
                + ' cl.nome AS Cliente, '
                + ' ct.numConta, '
                + ' ct.saldoInicial, '
                + ' ct.situacao '
           + ' FROM contas AS ct, '
                + ' bancos AS bc, '
                + ' clientes AS cl '
          + ' WHERE ct.IdCliente = cl.IdCliente '
            + ' AND ct.IdBanco = bc.IdBanco '
            + ' AND (ct.' + IndiceAtual
            + ' like :codigo OR ct.' + IndiceAtual + ' like :codigo' );
    ParamByName('codigo').AsString :=  '%'+mskEdit.Text+'%';
    open;
  end;
end;



function TfrmCadContas.PossuiMovimento(campo : String): Boolean;
begin

end;



end.
