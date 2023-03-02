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
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
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
    edtDescricao.Text       := objCliente.nome;
    edtDocumento.Text       := IntToStr(objCliente.documento);
    ativo                   := objCliente.situacao;
    ckSituacao.Checked      := StrToBool(ativo);
  end
  else begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmCadClientes.btnCancelarClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmCadClientes.btnExcluirClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmCadClientes.btnGravarClick(Sender: TObject);
begin
  inherited;

end;

procedure TfrmCadClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(objCliente) then
    FreeAndNil(objCliente);
end;

procedure TfrmCadClientes.FormCreate(Sender: TObject);
begin
  inherited;
  objCliente    := TCliente.Create(DtmConexaoPrincipal.ConexaoDB);
end;

procedure TfrmCadClientes.FormShow(Sender: TObject);
begin
  inherited;
end;



function TfrmCadClientes.Excluir: Boolean;
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



function TfrmCadClientes.Gravar(EstadoTela: TEstadoDaTela): Boolean;
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



procedure TfrmCadClientes.mskEditChange(Sender: TObject);
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

end.
