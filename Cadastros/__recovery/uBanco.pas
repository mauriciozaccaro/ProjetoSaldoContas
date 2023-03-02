unit uBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls, uEnum,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, cBanco, uDTMConexao;

type
  TfrmCadBancos = class(TfrmHerancaCadastros)
    edtCodigo: TLabeledEdit;
    ckSituacao: TCheckBox;
    edtNome: TLabeledEdit;
    QryListagemGridIdBanco: TLargeintField;
    QryListagemGridnome: TWideStringField;
    QryListagemGridsituacao: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure mskEditChange(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);

  private
    { Private declarations }
    objBanco : TBanco;
    function Gravar(EstadoTela : TEstadoDaTela)  : Boolean; override;
    function Excluir  : Boolean; override;

    function SituacaoEmTexto(ativo : Boolean) : String;
    function TextoEmSituacao(texto : string)  : boolean;

  public
    { Public declarations }
  end;

var
  frmCadBancos: TfrmCadBancos;

implementation

{$R *.dfm}

{$region 'Eventos da propria tela e botões'}

procedure TfrmCadBancos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(objBanco) then
    FreeAndNil(objBanco);
end;

procedure TfrmCadBancos.FormCreate(Sender: TObject);
begin
  inherited;
  objBanco    := TBanco.Create(DtmConexaoPrincipal.ConexaoDB);
end;

procedure TfrmCadBancos.FormShow(Sender: TObject);
begin
  inherited;
  //QryListagemGrid.Open;
end;



procedure TfrmCadBancos.btnAlterarClick(Sender: TObject);
var ativo : String;
begin
TrueBoolStrs  := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

  if (objBanco.SelecionarRegistro(QryListagemGrid.FieldByName('IdBanco').AsInteger)) then
  begin
    edtCodigo.Text          := IntToStr(objBanco.codigo);
    edtNome.Text            := objBanco.nome;
    ativo                   := objBanco.situacao;
    ckSituacao.Checked      := StrToBool(ativo);
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;



procedure TfrmCadBancos.btnCancelarClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmCadBancos.btnExcluirClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmCadBancos.btnGravarClick(Sender: TObject);
begin
  inherited;

end;

function TfrmCadBancos.Excluir: Boolean;
begin
  objBanco.codigo     := StrToInt(grdListagemGrid.Fields[0].text);
  objBanco.nome       := grdListagemGrid.fields[0].Text;

  if(MessageDlg('Deseja excluir o registro do Banco '''
              + IntToStr(objBanco.codigo)
              + ' - '
              + objBanco.nome
              + ''' ? ', TMsgDlgType.mtInformation, [mbYes, mbNo], 0) = mrYes) then
  begin
    Result  := objBanco.ExcluiRegistro;
  end else
  begin
    Abort;
  end;
end;
{$endregion}



function TfrmCadBancos.Gravar(EstadoTela: TEstadoDaTela): Boolean;
var ativo : Boolean;
begin
TrueBoolStrs := ['S', 's'];
FalseBoolStrs := ['N', 'n'];

    if (edtCodigo.Text <> EmptyStr) then
      objBanco.codigo  := StrToInt(edtCodigo.Text)
    else
      objBanco.codigo  := 0;

    objBanco.nome        := edtNome.Text;
    ativo                := ckSituacao.Checked;
    objBanco.situacao    := BoolToStr(ativo, true);

    if (EstadoTela = etNovo) then
    begin
      Result    := objBanco.InserirRegistro;
      ShowMessage('Cadastrado com Sucesso!')
    end
    else if (EstadoTela = etAlterar) then
    begin
      Result    := objBanco.AtualizarRegistro;
      ShowMessage('Alterado com sucesso')
    end;
end;



procedure TfrmCadBancos.mskEditChange(Sender: TObject);
begin
  inherited;
    with QryListagemGrid do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT IdBanco, nome, situacao FROM bancos WHERE nome like :codigo');
    //ParamByName('indice').AsString :=  ColunaIndiceAtual;
    ParamByName('codigo').AsString :=  '%'+mskEdit.Text+'%';
    open;
  end;
end;



function TfrmCadBancos.SituacaoEmTexto(ativo: Boolean): String;
begin
  inherited
end;



function TfrmCadBancos.TextoEmSituacao(texto: string): boolean;
begin
  inherited
end;



end.
