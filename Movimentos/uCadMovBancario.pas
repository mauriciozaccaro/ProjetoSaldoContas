unit uCadMovBancario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  RxToolEdit, RxCurrEdit, Vcl.Buttons, ZAbstractRODataset, ZAbstractDataset, DateUtils,
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
    rdgCredDeb: TRadioGroup;
    QryListagemGridIdMovContas: TLargeintField;
    QryListagemGridIdCliente: TLargeintField;
    QryListagemGridcliente: TWideStringField;
    QryListagemGridIdBanco: TLargeintField;
    QryListagemGridbanco: TWideStringField;
    QryListagemGridnumConta: TLargeintField;
    QryListagemGridvalor: TFloatField;
    QryListagemGridtipoMov: TWideStringField;
    Label5: TLabel;
    Label6: TLabel;
    dtpDataMovimento: TDateTimePicker;
    QryListagemGriddataMov: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnverificaDataClick(Sender: TObject);

  private
    { Private declarations }
    objMovConta : TMovBancario;
    function Gravar(EstadoTela : TEstadoDaTela)  : Boolean; override;
    function Excluir  : Boolean; override;
    function RetornaValorTipoMovimento(valor : Integer) : String;
    function SetaValorTipoMovimento(valor : String) : Integer;

  public
    { Public declarations }
  end;

var
  frmCadMovBancario: TfrmCadMovBancario;

implementation

{$R *.dfm}

uses uCadConta;



{$region 'Eventos da propria tela e botões'}

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

  if (objMovConta.SelecionarRegistro(QryListagemGridIdMovContas.AsInteger)) then
  begin
    edtCodigo.Text          := IntToStr(objMovConta.codigo);
    edtBanco.Text           := IntToStr(objMovConta.codConta);
    edtNomeBanco.Text       := objMovConta.banco;
    edtCliente.Text         := IntToStr(objMovConta.codCliente);
    edtNomeCliente.Text     := objMovConta.cliente;
    edtNumConta.Text        := IntToStr(objMovConta.numConta);
    edtValor.Text           := FloatToStr(objMovConta.valor);
    rdgCredDeb.ItemIndex    := SetaValorTipoMovimento(objMovConta.tipoMovimento);
    dtpDataMovimento.Date   := StrToDate(objMovConta.dataMov);
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
  botaoClicado := 2;
  frmConsultaContaBancaria  := TfrmConsultaContaBancaria.Create(Self);
  frmConsultaContaBancaria.ShowModal;
  frmConsultaContaBancaria.Release;
end;



procedure TfrmCadMovBancario.btnBuscaClienteClick(Sender: TObject);
begin
  inherited;
  LimparCampos;
  botaoClicado := 0;
  frmConsultaContaBancaria  :=  TfrmConsultaContaBancaria.Create(Self);
  frms                      :=  frmCadMovBancario;
  frmConsultaContaBancaria.ShowModal;
  frmConsultaContaBancaria.Release;
end;



procedure TfrmCadMovBancario.btnGravarClick(Sender: TObject);
begin

  if (rdgCredDeb.ItemIndex = -1) then
  begin
    MessageDlg('É obrigatório informar o Tipo de Movimento', TMsgDlgType.mtError, [TMsgDlgBtn.mbOK], 0);
    abort;
  end;
  inherited;
end;



procedure TfrmCadMovBancario.btnverificaDataClick(Sender: TObject);
var minhaData : String;
begin
  inherited; // testando
  //minhaData := dtpDATAAA.Text;
  //MessageDlg('data: ' + minhaData, TMsgDlgType.mtInformation, [mbOk], 0);
  //MessageDlg('data 2: ' + DateTimeToStr(dtpDataMovimento.Date), TMsgDlgType.mtInformation, [mbOk], 0);

end;



function TfrmCadMovBancario.Excluir: Boolean;
var numConta : Integer;
begin
  objMovConta.codigo        := StrToInt(grdListagemGrid.Fields[0].text);
  objMovConta.valor         := StrToFloat(grdListagemGrid.Fields[6].Text);

  if(MessageDlg('Deseja excluir o registro do Lançamento '''
              + IntToStr(objMovConta.codigo)
              + ''' -  no valor de R$ '
              + FloatToStr(objMovConta.valor)
              + ''' ? ', TMsgDlgType.mtInformation, [mbYes, mbNo], 0) = mrYes) then
  begin

   Result  := objMovConta.ExcluirRegistro;

  end else
  begin
    Abort;
  end;

end;



function TfrmCadMovBancario.Gravar(EstadoTela: TEstadoDaTela): Boolean;
var ativo : Boolean;
begin
TrueBoolStrs := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

    if (edtCodigo.Text <> EmptyStr) then
      objMovConta.codigo  := StrToInt(edtCodigo.Text)
    else
      objMovConta.codigo  := 0;

    if(edtValor.Text <> EmptyStr) then
      objMovConta.valor := StrToFloat(edtValor.Text)
    else
      objMovConta.valor := 0;

    if(dtpDataMovimento.Date <> EmptyParam) then
      objMovConta.dataMov := DateToStr(dtpDataMovimento.Date)
    else
      objMovConta.dataMov :=  DateToStr(DateOf(now));


    objMovConta.codConta       :=  StrToInt(edtBanco.Text);
    objMovConta.tipoMovimento  :=  RetornaValorTipoMovimento(rdgCredDeb.ItemIndex);

    if (EstadoTela = etNovo) then
    begin
      Result    := objMovConta.InserirRegistro;
      ShowMessage('Cadastrado com Sucesso!')
    end
    else if (EstadoTela = etAlterar) then
    begin
      Result    := objMovConta.AtualizarRegistro;
      ShowMessage('Alteração realizada com sucesso')
    end;

end;

function TfrmCadMovBancario.RetornaValorTipoMovimento(valor: Integer): String;
begin

  if (valor = 0) then
    Result  :=  'C'
  else
    Result  :=  'D';

end;



function TfrmCadMovBancario.SetaValorTipoMovimento(valor: String): Integer;
begin

  if(valor = 'C') then
    Result  := 0
  else if valor = 'D' then
    Result  := 1
  else
    Result  := -1;

end;

end.
