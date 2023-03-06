unit uConsultaContaBancaria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, uHerancaConsulta, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, uCadConta;

type
  TfrmConsultaContaBancaria = class(TfrmHerancaConsulta)
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
    QryConsultaContaBancariaIdConta: TLargeintField;
    QryConsultaContaBancariaIdCliente: TLargeintField;
    QryConsultaContaBancariacliente: TWideStringField;
    QryConsultaContaBancariaIdBanco: TLargeintField;
    QryConsultaContaBancariabanco: TWideStringField;
    QryConsultaContaBancarianumConta: TLargeintField;
    QryConsultaContaBancariasituacao: TWideStringField;
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
        QryConsultaCliente.Open;
        QryUsada                         := QryConsultaCliente;
        grdListagemConsulta.DataSource   := dtsConsultaCliente;

        frmConsultaContaBancaria.Caption := 'Consulta Cliente';

        with grdListagemConsulta do
        begin
          Columns[0].Width := 50;   // Codigo
          Columns[1].Width := 150;  // Nome
          Columns[2].Width := 70;   // Documento
          Columns[3].Width := 50;   // Situacao
          OnTitleClick(columns[1]);
        end;
    end;

    1 : begin // Banco
        QryConsultaBanco.Open;
        QryUsada                         := QryConsultaBanco;
        grdListagemConsulta.DataSource   := dtsConsultaBanco;

        frmConsultaContaBancaria.Caption := 'Consulta Banco';

        with grdListagemConsulta do
        begin
          Columns[0].Width := 50;   // Codigo
          Columns[1].Width := 150;  // Nome
          Columns[2].Width := 50;   // Situacao
          OnTitleClick(columns[1]);
        end;
    end;

    2 : begin // Conta Bancária
        QryConsultaContaBancaria.Open;
        QryUsada                         := QryConsultaContaBancaria;
        grdListagemConsulta.DataSource   := dtsConsultaContaBancaria;

        frmConsultaContaBancaria.Caption := 'Consulta Conta Bancária';

        with grdListagemConsulta do
        begin
          Columns[0].Width := 50;   // Codigo Conta
          Columns[1].Width := 150;  // Nome
          Columns[2].Width := 70;   // Documento
          Columns[3].Width := 50;   // Situacao
          OnTitleClick(columns[1]);
        end;
    end;
  end;
end;



end.
