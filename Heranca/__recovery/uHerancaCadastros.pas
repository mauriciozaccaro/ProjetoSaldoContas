unit uHerancaCadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, uEnum,
  Data.DB, Vcl.DBCtrls, Vcl.Mask, Vcl.Grids, Vcl.DBGrids, uDTMConexao, RxToolEdit, RxCurrEdit,
  ZAbstractRODataset, ZAbstractDataset, ZDataset;

type
  TfrmHerancaCadastros = class(TForm)
    pgcPrincipal: TPageControl;
    Panel1            : TPanel;
    tabListagem       : TTabSheet;
    tabCadastro       : TTabSheet;
    Panel2            : TPanel;
    grdListagemGrid   : TDBGrid;
    lblIndice         : TLabel;
    mskEdit           : TMaskEdit;
    btnCancelar       : TButton;
    btnExcluir        : TButton;
    btnNavigator      : TDBNavigator;
    btnSair           : TButton;
    btnGravar         : TButton;
    btnAlterar        : TButton;
    btnNovo           : TButton;
    QryListagemGrid   : TZQuery;
    DtsListagemGrid   : TDataSource;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure grdListagemGridTitleClick(Column: TColumn);
    procedure grdListagemGridDblClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure mskEditChange(Sender: TObject);

  private
    { Private declarations }
      EstadoTela : TEstadoDaTela;
      function CamposObrigatorios  : Boolean;

      procedure LimparCampos;
      procedure ControlarTab(pgcPrincipal: TPageControl; x: Integer);
      procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir : TButton;
                                btnNavigator : TDBNavigator;
                                pgcPrincipal : TPageControl;
                                Flag         : Boolean);
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    procedure grdListagemConsultaDblClick(Sender: TObject);
    procedure grdListagemConsultaTitleClick(Column: TColumn);
    procedure MaskEdit1Change(Sender: TObject);
    function RetornarCampoFieldTraduzido(Campo: string): string;

  public
    { Public declarations }
    IndiceAtual                              : string; //para guardar o indice da coluna selecionada e realizar a busca
    ColunaIndiceAtual                        : String;
    function Excluir                         : Boolean; virtual;
    function Gravar(EstadoTela:TEstadoDaTela): Boolean; virtual;

    //function SituacaoEmTexto(ativo : Boolean) : String;   //não funcionou como eu queria
    //function TextoEmSituacao(texto : string)  : boolean;
  end;

var
  frmHerancaCadastros : TfrmHerancaCadastros;

implementation

{$R *.dfm}

// Flag 0 -> Utilizando para marcar campos que não podem ser acessados, como o de código.
// Flag 1 -> Utilizando para marcar campos que são de preenchimento obrigatório.

{$region 'Eventos da propria tela, botões e etc..'}

procedure TfrmHerancaCadastros.FormCreate(Sender: TObject);
begin
  QryListagemGrid.Connection          := DtmConexaoPrincipal.ConexaoDB;
  DtsListagemGrid.DataSet             := QryListagemGrid;
  grdListagemGrid.DataSource          := DtsListagemGrid;
end;



procedure TfrmHerancaCadastros.FormShow(Sender: TObject);
begin
  if(QryListagemGrid.sql.Text <> EmptyStr) then
  begin
    QryListagemGrid.Open;
  end;
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir, btnNavigator, pgcPrincipal, true);
  ControlarTab(pgcPrincipal, 0);
end;



procedure TfrmHerancaCadastros.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagemGrid.Close;
end;



// BOTÕES E ETC...
procedure TfrmHerancaCadastros.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir, btnNavigator, pgcPrincipal, false);
  ControlarTab(pgcPrincipal, 0);
  EstadoTela := etAlterar;
end;



procedure TfrmHerancaCadastros.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir, btnNavigator, pgcPrincipal, true);
  ControlarTab(pgcPrincipal, 0);
  EstadoTela := etNenhum;
  LimparCampos;
end;



procedure TfrmHerancaCadastros.btnExcluirClick(Sender: TObject);
begin
  try
    if Excluir = true then

      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir,
                      btnNavigator, pgcPrincipal, true);
      ControlarTab(pgcPrincipal, 0);
  finally
    EstadoTela := etNenhum;
    LimparCampos;
    QryListagemGrid.Refresh;
  end;
end;



procedure TfrmHerancaCadastros.btnGravarClick(Sender: TObject);
begin
  if (CamposObrigatorios) then
    abort;

  try
    if Gravar(EstadoTela) then
    begin
      ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir, btnNavigator, pgcPrincipal, true);
      ControlarTab(pgcPrincipal, 0);
    end
    else begin
      Messagedlg('Erro de Gravação', mtError, [TMsgDlgBtn.mbOK], 0);
    end;
  finally
    EstadoTela    := etNenhum;
    LimparCampos;
    QryListagemGrid.Refresh;
  end;
end;



procedure TfrmHerancaCadastros.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar, btnExcluir, btnNavigator, pgcPrincipal, false);
  EstadoTela      := etNovo;
  LimparCampos;
end;



procedure TfrmHerancaCadastros.btnSairClick(Sender: TObject);
begin
  Close;
end;



procedure TfrmHerancaCadastros.grdListagemGridDblClick(Sender: TObject);
begin
  btnAlterar.Click;
end;



procedure TfrmHerancaCadastros.grdListagemGridTitleClick(Column: TColumn);
begin
  IndiceAtual                       := Column.FieldName;
  ColunaIndiceAtual                 := Column.FieldName;
  QryListagemGrid.IndexFieldNames   := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

{$endregion}



{$region 'Procedimentos e Funções que serão herdadas'}

procedure TfrmHerancaCadastros.LimparCampos;
var i : integer;
begin
  for i := 0 to ComponentCount -1  do
  begin
    if(Components[i] is TLabeledEdit) then
      TLabeledEdit(Components[i]).Text        := EmptyStr;

    if(Components[i] is TMaskEdit) then
      TMaskEdit(Components[i]).Text           := EmptyStr;

    if(Components[i] is TDateTimePicker) then
      TDateEdit(Components[i]).Text           := EmptyStr;
  end;
end;


 procedure TfrmHerancaCadastros.mskEditChange(Sender: TObject);
begin

end;


{ // não deu certo, to sem tempo para mexer com isso agora, fazer direto na chamada e lembrar de corrigir quando der tempo
function TfrmHerancaCadastros.SituacaoEmTexto(ativo : Boolean): String;
begin
  if (ativo = true) then
    Result  := 'S'
  else
    Result  := 'N';
end;

function TfrmHerancaCadastros.TextoEmSituacao(texto : string): Boolean;
begin
TrueBoolStrs := ['S', 's'];

  if(StrToBool(texto)) then
    Result  := StrToBool(texto)
  else
    Result  := StrToBool(texto)
end;
 }


function TfrmHerancaCadastros.CamposObrigatorios : Boolean;
var i : Integer;
begin
  Result := false;
  for i := 0 to ComponentCount -1 do begin
    if(Components[i] is TLabeledEdit) then begin
      if(TLabeledEdit(Components[i]).Tag = 2) and (TLabeledEdit(Components[i]).text = EmptyStr) then begin
        MessageDlg(TLabeledEdit(Components[i]).EditLabel.Caption
                  + ' é um campo obrigatório!', TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
        TLabeledEdit(Components[i]).SetFocus;
        Result := true;
        Break;
      end;
      end;
    end;
end;



procedure TfrmHerancaCadastros.ControlarBotoes(btnNovo, btnAlterar, btnCancelar, btnGravar,
                                               btnExcluir : TButton; btnNavigator : TDBNavigator;
                                               pgcPrincipal : TPageControl; Flag : Boolean);
begin
  btnNovo.Enabled                   := Flag;
  btnAlterar.Enabled                := Flag;
  btnExcluir.Enabled                := Flag;
  btnNavigator.Enabled              := Flag;
  pgcPrincipal.Pages[0].TabVisible  := Flag;

  btnCancelar.Enabled               := not(Flag);
  btnGravar.Enabled                 := not(Flag);
end;



procedure TfrmHerancaCadastros.ControlarTab(pgcPrincipal: TPageControl;  x: Integer);
begin
  if(pgcPrincipal.Pages[x].TabVisible) then
     pgcPrincipal.TabIndex := x;
end;


{$endregion}

// métodos virtuais para reescrita
function TfrmHerancaCadastros.Gravar(EstadoTela: TEstadoDaTela): Boolean;
begin

end;



function TfrmHerancaCadastros.Excluir: Boolean;
begin

end;

{$region 'Função e procedimento para pegar a coluna selecionada e passar para a label'} // também utilizado para consulta

function TfrmHerancaCadastros.RetornarCampoFieldTraduzido(Campo : string) : string;
VAR i : integer;
begin
  for i := 0 to QryListagemGrid.fields.Count -1 do
  begin
    if(QryListagemGrid.Fields[i].FieldName = Campo) then
    begin
      Result := QryListagemGrid.Fields[i].DisplayLabel;
      break;
    end;
  end;
end;



 procedure TfrmHerancaCadastros.ExibirLabelIndice(Campo : string; aLabel : TLabel);
begin
  aLabel.Caption := RetornarCampoFieldTraduzido(Campo);
end;



procedure TfrmHerancaCadastros.grdListagemConsultaDblClick(Sender: TObject);
begin
  close;
end;



procedure TfrmHerancaCadastros.grdListagemConsultaTitleClick(Column: TColumn);
begin
  IndiceAtual                               := Column.FieldName;
  QryListagemGrid.IndexFieldNames  := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;



procedure TfrmHerancaCadastros.MaskEdit1Change(Sender: TObject);
begin
  QryListagemGrid.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

{$endregion}



end.
