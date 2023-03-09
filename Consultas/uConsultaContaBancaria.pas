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
    procedure mskEditPesquisaChange(Sender: TObject);

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
  grdListagemConsulta.OnTitleClick(grdListagemConsulta.Columns[2]);
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

procedure TfrmConsultaContaBancaria.mskEditPesquisaChange(Sender: TObject);
begin
  inherited;
   with QryConsulta do
       begin
        Close;
        SQl.Clear;
        SQL.Add('SELECT CC.IdConta, CC.IdCliente, CL.nome AS cliente, '
               + ' CC.IdBanco, BC.nome AS banco, CC.numConta, CC.situacao '
               + '   FROM contas AS CC, '
               + '       clientes AS CL, '
               + '        bancos AS BC '
               + '  WHERE CC.IdCliente = CL.IdCliente '
               + '    AND  CC.IdBanco = BC.IdBanco');

        if (IndiceAtual = 'IdConta') then
        begin
              SQL.Add('AND CC.IdConta LIKE :codigo ');
              ParamByName('codigo').AsString      := '%'+mskEditPesquisa.Text+'%';
        end;

        if (IndiceAtual = 'cliente') then
        begin
              SQL.Add('AND CL.nome LIKE :codigo');
              ParamByName('codigo').AsString      := '%'+mskEditPesquisa.Text+'%';
        end;

        if (IndiceAtual = 'banco') then
        begin
              SQL.Add('AND BC.nome LIKE :codigo');
              ParamByName('codigo').AsString      := '%'+mskEditPesquisa.Text+'%';
        end;

        if (IndiceAtual = 'numConta') then
        begin
              SQL.Add('AND CC.numConta LIKE :codigo');
              ParamByName('codigo').AsString      := '%'+mskEditPesquisa.Text+'%';
        end;

        SQL.Add('AND CC.situacao = ''S''');

        Open;
       end;
end;

end.
