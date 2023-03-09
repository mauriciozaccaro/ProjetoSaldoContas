unit uConsultaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaConsulta, Data.DB,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmConsultaCliente = class(TfrmHerancaConsulta)
    QryConsultaIdCliente: TLargeintField;
    QryConsultanome: TWideStringField;
    QryConsultanumDocumento: TLargeintField;
    QryConsultasituacao: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemConsultaDblClick(Sender: TObject);
    procedure mskEditPesquisaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaCliente: TfrmConsultaCliente;

implementation

{$R *.dfm}



procedure TfrmConsultaCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//
end;



procedure TfrmConsultaCliente.FormCreate(Sender: TObject);
begin
  inherited;
//
end;



procedure TfrmConsultaCliente.FormShow(Sender: TObject);
begin
  inherited;
  grdListagemConsulta.OnTitleClick(grdListagemConsulta.Columns[1]); // coluna "Nome Cliente"
end;



procedure TfrmConsultaCliente.grdListagemConsultaDblClick(Sender: TObject);
begin
  iCampoIdCliente := grdListagemConsulta.Fields[0].AsInteger;
  sCampoCliente   := grdListagemConsulta.Fields[1].AsString;
  inherited;
end;

procedure TfrmConsultaCliente.mskEditPesquisaChange(Sender: TObject);
begin
  inherited;
      with QryConsulta do
      begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT IdCliente, nome, numDocumento, situacao FROM clientes WHERE '
              +  IndiceAtual
              + ' like :codigo AND situacao = ''S''');
        ParamByName('codigo').AsString :=  '%'+mskEditPesquisa.Text+'%';
        open;
      end;
end;

end.
