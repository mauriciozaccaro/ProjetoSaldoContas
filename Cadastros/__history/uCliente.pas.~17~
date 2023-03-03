unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaCadastros, Data.DB, Vcl.DBCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask, Vcl.ExtCtrls, Vcl.ComCtrls,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, uEnum, cCliente, uDTMConexao;

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
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    objCliente : TCliente;
    function Gravar(EstadoTela : TEstadoDaTela)  : Boolean; override;
    function Excluir  : Boolean; override;
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

function TfrmCadClientes.Excluir: Boolean;
begin
  objCliente.codigo     := StrToInt(grdListagemGrid.Fields[0].text);
  objCliente.nome       := grdListagemGrid.fields[0].Text;

  if(MessageDlg('Deseja excluir o registro do Banco '''
              + IntToStr(objCliente.codigo)
              + ' - '
              + objCliente.nome
              + ''' ? ', TMsgDlgType.mtInformation, [mbYes, mbNo], 0) = mrYes) then
  begin
    Result  := objCliente.ExcluiRegistro;
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
      objCliente.codigo    := StrToInt(edtCodigo.Text)
    else
      objCliente.codigo    := 0;

    objCliente.nome        := edtDescricao.Text;
    objCliente.documento   := StrToInt(edtDocumento.Text);
    ativo                  := ckSituacao.Checked;
    objCliente.situacao    := BoolToStr(ativo, true);

    if (EstadoTela = etNovo) then
    begin
      Result    := objCliente.InserirRegistro;
      ShowMessage('Cadastrado com Sucesso!')
    end
    else if (EstadoTela = etAlterar) then
    begin
      Result    := objCliente.AtualizarRegistro;
      ShowMessage('Alterado com sucesso')
    end;
end;

end.
