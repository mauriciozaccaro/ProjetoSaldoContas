unit uHerancaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset, uCadConta,
  ZDataset;

type
  TfrmHerancaConsulta = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MaskEdit1: TMaskEdit;
    lblPesquisa: TLabel;
    btnFechar: TButton;
    grdListagemConsulta: TDBGrid;
    QryConsultaContaBancaria: TZQuery;
    dtsConsultaContaBancaria: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdListagemConsultaTitleClick(Column: TColumn);
    procedure grdListagemConsultaDblClick(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);

  private

    { Private declarations }
    function RetornarCampoFieldTraduzido(Campo: string): string;
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);

  public

    { Public declarations }
    aIniciarPesquisaId       : Variant;
    aCampoId                 : String;
    aCampoCliente            : String;
    aCampoBanco              : String;
    aCampoNumConta           : String;
    IndiceAtual              : String;
    QryUsada                 : TZQuery;

  end;

var
  frmHerancaConsulta: TfrmHerancaConsulta;

implementation

{$R *.dfm}

uses uCadMovBancario,  uConsultaContaBancaria;



procedure TfrmHerancaConsulta.btnFecharClick(Sender: TObject);
begin
  close;
end;



procedure TfrmHerancaConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if QryConsultaContaBancaria.Active then
    QryConsultaContaBancaria.Close;

  QryConsultaContaBancaria.Open;
end;



procedure TfrmHerancaConsulta.FormCreate(Sender: TObject);
begin
   if QryConsultaContaBancaria.Active then
    QryConsultaContaBancaria.Close;

  QryConsultaContaBancaria.Open;
end;



procedure TfrmHerancaConsulta.FormShow(Sender: TObject);
begin
if(QryConsultaContaBancaria.sql.Text <> EmptyStr) then
  begin
    QryConsultaContaBancaria.Open;
  end;
end;



{$region 'Função e procedimento para pegar a coluna selecionada e passar para a label'} // também utilizado para consulta

function TfrmHerancaConsulta.RetornarCampoFieldTraduzido(Campo : string) : string;
var i : integer;
begin
  for i := 0 to QryUsada.fields.Count -1 do
  begin
    if(QryUsada.Fields[i].FieldName = Campo) then
    begin
      Result := QryUsada.Fields[i].DisplayLabel;
      break;
    end;
  end;
end;



 procedure TfrmHerancaConsulta.ExibirLabelIndice(Campo : string; aLabel : TLabel);
begin
  aLabel.Caption := RetornarCampoFieldTraduzido(Campo);
end;



procedure TfrmHerancaConsulta.grdListagemConsultaDblClick(Sender: TObject);
begin
  try
    if (botaoClicado = 1) then // Banco
    begin
      if (grdListagemConsulta.Fields[2].Text = 'N') then
      Begin
        MessageDlg('Banco Inativo!' + #13 + 'Selecione outro cadastro para continuar!',
                    TMsgDlgType.mtInformation, [mbOk], 0);  Abort;
      End;

      frmCadContas.edtBanco.Text         :=  grdListagemConsulta.Fields[0].Text;
      frmCadContas.edtNomeBanco.Text     :=  grdListagemConsulta.Fields[1].Text;

    end else
    if (botaoClicado = 0) then  // Cliente
    begin

      if (grdListagemConsulta.Fields[3].Text = 'N') then
      Begin
        MessageDlg('Cliente Inativo!' + #13 + 'Selecione outro cadastro para continuar!',
                    TMsgDlgType.mtInformation, [mbOk], 0);  Abort;
      End;

      frmCadContas.edtCliente.Text       :=  grdListagemConsulta.Fields[0].Text;
      frmCadContas.edtNomeCliente.Text   :=  grdListagemConsulta.Fields[1].Text;

    end else
    if (botaoClicado = 2) then   // Conta Bancária
    begin
      MessageDlg('Ainda não implementado', TMsgDlgType.mtInformation, [mbOk], 0);
      Abort;
    end;

  finally
    close;
  end;
end;



procedure TfrmHerancaConsulta.grdListagemConsultaTitleClick(Column: TColumn);
begin
  IndiceAtual          := Column.FieldName;
  ExibirLabelIndice(IndiceAtual, lblPesquisa);
  MaskEdit1.Text       := EmptyStr;
  MaskEdit1.SetFocus;
end;



procedure TfrmHerancaConsulta.MaskEdit1Change(Sender: TObject);
begin
//  QryUsada.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]); // é ruim de busca, por isso fiz por Select
  inherited;
  try

  case botaoClicado of
    0 : begin // Cliente
      with QryUsada do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT IdCliente, nome, numDocumento, situacao FROM clientes WHERE '
              +  IndiceAtual
              + ' like :codigo');
        ParamByName('codigo').AsString :=  '%'+MaskEdit1.Text+'%';
        open;
      end;

    end;

    1 : begin
      with QryUsada do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT IdBanco, nome, situacao FROM bancos WHERE '
              +  IndiceAtual
              + ' like :codigo');
        ParamByName('codigo').AsString :=  '%'+MaskEdit1.Text+'%';
        open;
      end;

    end;

    2 : begin  // Conta Bancária
      with QryUsada do
      begin
        MessageDlg('Ainda não implementado', TMsgDlgType.mtInformation, [mbOk], 0);
      end;

    end;

  end;
  except
    MessageDlg('Não foi possível realizar a Consulta', TMsgDlgType.mtError, [mbOk], 0);
  end;

end;

{$endregion}

end.
