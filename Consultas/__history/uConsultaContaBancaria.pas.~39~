unit uConsultaContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, uHerancaConsulta, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmConsultaContaBancaria = class(TfrmHerancaConsulta)
    QryConsultaContaBancariaIdConta: TLargeintField;
    QryConsultaContaBancariaIdCliente: TLargeintField;
    QryConsultaContaBancariacliente: TWideStringField;
    QryConsultaContaBancariaIdBanco: TLargeintField;
    QryConsultaContaBancariabanco: TWideStringField;
    QryConsultaContaBancarianumConta: TLargeintField;
    QryConsultaContaBancariasituacao: TWideStringField;
    procedure FormShow(Sender: TObject);
    procedure grdListagemConsultaDblClick(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }

  end;

var
  frmConsultaContaBancaria: TfrmConsultaContaBancaria;

implementation

{$R *.dfm}

uses uCadMovBancario;



procedure TfrmConsultaContaBancaria.FormShow(Sender: TObject);
begin
  inherited;
  grdListagemConsulta.OnTitleClick(grdListagemConsulta.Columns[5]);
end;

procedure TfrmConsultaContaBancaria.grdListagemConsultaDblClick(
  Sender: TObject);
begin
  iCampoIdConta         :=  grdListagemConsulta.Fields[0].AsInteger;
  iCampoIdCliente       :=  grdListagemConsulta.Fields[1].AsInteger;
  sCampoCliente         :=  grdListagemConsulta.Fields[2].AsString;
  iCampoIdBanco         :=  grdListagemConsulta.Fields[3].AsInteger;
  sCampoBanco           :=  grdListagemConsulta.Fields[4].AsString;
  iCampoNumConta        :=  grdListagemConsulta.Fields[5].AsInteger;
  inherited;
//
end;

end.
