unit uHerancaConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  Data.DB, Vcl.Grids, Vcl.DBGrids, ZAbstractRODataset, ZAbstractDataset,
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

  end;

var
  frmHerancaConsulta: TfrmHerancaConsulta;

implementation

{$R *.dfm}

uses uCadMovBancario;



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
VAR i : integer;
begin
  for i := 0 to QryConsultaContaBancaria.fields.Count -1 do
  begin
    if(QryConsultaContaBancaria.Fields[i].FieldName = Campo) then
    begin
      Result := QryConsultaContaBancaria.Fields[i].DisplayLabel;
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
  close;
end;



procedure TfrmHerancaConsulta.grdListagemConsultaTitleClick(Column: TColumn);
begin
  IndiceAtual                               := Column.FieldName;
  QryConsultaContaBancaria.IndexFieldNames  := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblPesquisa);
end;



procedure TfrmHerancaConsulta.MaskEdit1Change(Sender: TObject);
begin
  QryConsultaContaBancaria.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

{$endregion}

end.
