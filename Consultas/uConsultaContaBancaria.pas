unit uConsultaContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uHerancaConsulta, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset;

type
  TfrmConsultaContaBancaria = class(TfrmHerancaConsulta)
    QryConsultaContaBancariaIdConta: TLargeintField;
    QryConsultaContaBancariacliente: TWideStringField;
    QryConsultaContaBancariabanco: TWideStringField;
    QryConsultaContaBancarianumConta: TLargeintField;
    QryConsultaContaBancariasituacao: TWideMemoField;
    QryConsultaContaBancariaIdCliente: TLargeintField;
    procedure FormShow(Sender: TObject);
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
  IndiceAtual := 'NrConta';
end;

end.
