unit uConsultaBanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaBanco = class(TfrmHerancaConsulta)
    QryConsultaIdBanco: TLargeintField;
    QryConsultanome: TWideStringField;
    QryConsultasituacao: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure grdListagemConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaBanco: TfrmConsultaBanco;

implementation

{$R *.dfm}

procedure TfrmConsultaBanco.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//
end;



procedure TfrmConsultaBanco.FormCreate(Sender: TObject);
begin
  inherited;
//
end;



procedure TfrmConsultaBanco.FormShow(Sender: TObject);
begin
  inherited;

   with grdListagemConsulta do
   begin
    OnTitleClick(columns[1]);
   end;

// Essa linha funciona igual ao bloco acima
// grdListagemConsulta.OnTitleClick(grdListagemConsulta.Columns[2]);
end;

procedure TfrmConsultaBanco.grdListagemConsultaDblClick(Sender: TObject);
begin
  iCampoIdBanco      := grdListagemConsulta.Fields[0].AsInteger;
  sCampoBanco        := grdListagemConsulta.Fields[1].AsString;
  inherited;
end;

end.
