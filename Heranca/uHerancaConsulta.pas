unit uHerancaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, uDTMConexao;

type
  TfrmHerancaConsulta = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    MaskEdit1: TMaskEdit;
    lblPesquisa: TLabel;
    btnFechar: TButton;
    grdListagemConsulta: TDBGrid;
    QryConsulta: TZQuery;
    dtsConsulta: TDataSource;
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

    QryUsada                 : TZQuery;

  end;

var
    frmHerancaConsulta  : TfrmHerancaConsulta;
    sIniciarPesquisaId  : Variant;
    iCampoIdCliente     : Integer;
    sCampoCliente       : String;
    iCampoIdBanco       : Integer;
    sCampoBanco         : String;
    iCampoIdConta       : Integer;
    iCampoNumConta      : Integer;
    IndiceAtual         : String;

implementation

{$R *.dfm}

uses uCadMovBancario,  uConsultaContaBancaria;



procedure TfrmHerancaConsulta.btnFecharClick(Sender: TObject);
begin
  close;
end;



procedure TfrmHerancaConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   QryConsulta.Close;
end;



procedure TfrmHerancaConsulta.FormCreate(Sender: TObject);
begin
   QryConsulta.Connection                 := DtmConexaoPrincipal.ConexaoDB;
   dtsConsulta.DataSet                    := QryConsulta;
   grdListagemConsulta.DataSource         := dtsConsulta;
end;



procedure TfrmHerancaConsulta.FormShow(Sender: TObject);
begin

  if(QryConsulta.sql.Text <> EmptyStr) then
  begin
    QryConsulta.Open;
  end;

end;



procedure TfrmHerancaConsulta.grdListagemConsultaDblClick(Sender: TObject);
begin
  close;
  ModalResult     := mrOk;
end;



{$region 'Fun��o e procedimento para pegar a coluna selecionada e passar para a label'} // tamb�m utilizado para consulta

function TfrmHerancaConsulta.RetornarCampoFieldTraduzido(Campo : string) : string;
var i : integer;
begin
  for i := 0 to QryConsulta.fields.Count -1 do
  begin
    if(QryConsulta.Fields[i].FieldName = Campo) then
    begin
      Result := QryConsulta.Fields[i].DisplayLabel;
      break;
    end;
  end;
end;



 procedure TfrmHerancaConsulta.ExibirLabelIndice(Campo : string; aLabel : TLabel);
begin
  aLabel.Caption := RetornarCampoFieldTraduzido(Campo);
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
//  QryUsada.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]); // � ruim de busca, por isso fiz por Select
//
//  try
//
//  case botaoClicado of
//    0 : begin // Cliente
//      with QryConsulta do
//      begin
//        Close;
//        SQL.Clear;
//        SQL.Add('SELECT IdCliente, nome, numDocumento, situacao FROM clientes WHERE '
//              +  IndiceAtual
//              + ' like :codigo');
//        ParamByName('codigo').AsString :=  '%'+MaskEdit1.Text+'%';
//        open;
//      end;
//
//    end;
//
//    1 : begin
//      with QryConsulta do
//      begin
//        Close;
//        SQL.Clear;
//        SQL.Add('SELECT IdBanco, nome, situacao FROM bancos WHERE '
//              +  IndiceAtual
//              + ' like :codigo');
//        ParamByName('codigo').AsString :=  '%'+MaskEdit1.Text+'%';
//        open;
//      end;
//
//    end;
//
//    2 : begin  // Conta Banc�ria
//      with QryConsulta do
//      begin
//        MessageDlg('Ainda n�o implementado', TMsgDlgType.mtInformation, [mbOk], 0);
//      end;
//
//    end;
//
//  end;
//  except
//    MessageDlg('N�o foi poss�vel realizar a Consulta', TMsgDlgType.mtError, [mbOk], 0);
//  end;

end;

{$endregion}

end.
