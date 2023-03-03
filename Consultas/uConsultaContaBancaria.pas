unit uConsultaContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, uHerancaConsulta, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uCadConta;

type
  TfrmConsultaContaBancaria = class(TfrmHerancaConsulta)
    QryConsultaContaBancariaIdConta: TLargeintField;
    QryConsultaContaBancariacliente: TWideStringField;
    QryConsultaContaBancariabanco: TWideStringField;
    QryConsultaContaBancarianumConta: TLargeintField;
    QryConsultaContaBancariasituacao: TWideMemoField;
    QryConsultaContaBancariaIdCliente: TLargeintField;
    QryConsultaCliente: TZQuery;
    dtsConsultaCliente: TDataSource;
    QryConsultaClienteIdCliente: TLargeintField;
    QryConsultaClientenome: TWideStringField;
    QryConsultaClientenumDocumento: TLargeintField;
    QryConsultaClientesituacao: TWideStringField;
    QryConsultaBanco: TZQuery;
    dtsConsultaBanco: TDataSource;
    QryConsultaBancoIdBanco: TLargeintField;
    QryConsultaBanconome: TWideStringField;
    QryConsultaBancosituacao: TWideStringField;
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

  case botaoClicado of
    0 : begin // Cliente
        MessageDlg('Buscando Cliente', TMsgDlgType.mtInformation, [mbOk], 0);
        QryConsultaCliente.Open;
        grdListagemConsulta.DataSource := dtsConsultaCliente;

        with grdListagemConsulta do
        begin
          Columns[0].Width := 50;   // Codigo
          Columns[1].Width := 150;  // Nome
          Columns[2].Width := 70;   // Documento
          Columns[3].Width := 50;   // Situacao
        end;
    end;

    1 : begin // Banco
        MessageDlg('Buscando Banco', TMsgDlgType.mtInformation, [mbOk], 0);
        QryConsultaBanco.Open;
        grdListagemConsulta.DataSource := dtsConsultaBanco;

        with grdListagemConsulta do
        begin
          Columns[0].Width := 50;   // Codigo
          Columns[1].Width := 150;  // Nome
          Columns[2].Width := 50;   // Situacao
        end;
    end;

    2 : begin // Conta Banc�ria
        MessageDlg('Buscando Conta Banc�ria', TMsgDlgType.mtInformation, [mbOk], 0);
        QryConsultaContaBancaria.Open;
        grdListagemConsulta.DataSource := dtsConsultaContaBancaria;

        with grdListagemConsulta do
        begin
          Columns[0].Width := 50;   // Codigo Conta
          Columns[1].Width := 150;  // Nome
          Columns[2].Width := 70;   // Documento
          Columns[3].Width := 50;   // Situacao
        end;
    end;

  end;
end;



end.
