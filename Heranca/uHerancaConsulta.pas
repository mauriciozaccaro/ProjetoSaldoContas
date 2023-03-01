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
  private
    { Private declarations }
  public
    { Public declarations }
    aRetornaContaSelecionada : Variant;
    aIniciarPesquisaId       : Variant;
    aCampoId                 : String;

  end;

var
  frmHerancaConsulta: TfrmHerancaConsulta;

implementation

{$R *.dfm}

procedure TfrmHerancaConsulta.btnFecharClick(Sender: TObject);
begin
  close;
end;

procedure TfrmHerancaConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
   if QryConsultaContaBancaria.Active then
    QryConsultaContaBancaria.Close;

  QryConsultaContaBancaria.Close;
end;

procedure TfrmHerancaConsulta.FormCreate(Sender: TObject);
begin
   if QryConsultaContaBancaria.Active then
    QryConsultaContaBancaria.Close;

  QryConsultaContaBancaria.Close;
end;

end.
