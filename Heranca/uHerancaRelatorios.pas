unit uHerancaRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.ComCtrls,  uConsultaContaBancaria,
  uDTMConexao, uHerancaConsulta, cRelatorioMovbancario;

type
  TfrmHerancaRelatorio = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    grdRelatorio: TDBGrid;
    DBNavigator1: TDBNavigator;
    edtCodBanco: TMaskEdit;
    btnBuscaBanco: TSpeedButton;
    edtNomeBanco: TEdit;
    Label1: TLabel;
    edtC: TEdit;
    SpeedButton1: TSpeedButton;
    edtCodConta: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    SpeedButton2: TSpeedButton;
    Button1: TButton;
    QryRelatorio: TZQuery;
    dtsRelatorio: TDataSource;
    edtCodCliente: TMaskEdit;
    SpeedButton3: TSpeedButton;
    edtNomeCliente: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    dtpInicio: TDateTimePicker;
    Label11: TLabel;
    dtpFim: TDateTimePicker;
    Label13: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    function UmCampoObrigatorio : Integer;

  private
    { Private declarations }
    objRelatorioMovBancario : TRelatorioMovBancario;

  public
    { Public declarations }
  end;

var
  frmHerancaRelatorio: TfrmHerancaRelatorio;

implementation

{$R *.dfm}



procedure TfrmHerancaRelatorio.Button1Click(Sender: TObject);
var aux, codConta, codBanco, codCliente : Integer; dataInicial, dataFinal, textoSQL : String;
begin
   {
  aux := UmCampoObrigatorio;
  if (aux > 0) then
  begin
    MessageDlg('Selecione ao menos um campo para pesquisa: ''Banco, Conta Banc�ria ou Cliente''',
                TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    Abort;
  end;
   }
  if (dtpFim.Date < dtpInicio.Date) then
  begin
    MessageDlg('''Data Fim'' n�o pode ser menor que ''Data In�cio''',
                TMsgDlgType.mtInformation, [mbOk], 0);
    Abort;
  end;

  try

  if (edtCodConta.Text = EmptyStr) then
    edtCodConta.Text  := IntToStr(0);

  if (edtCodBanco.Text = EmptyStr) then
    edtCodBanco.Text  := IntToStr(0);

  if (edtCodCliente.Text = EmptyStr) then
    edtCodCliente.Text := IntToStr(0);


    codConta      := StrToInt(edtCodConta.Text);
    codBanco      := StrToInt(edtCodBanco.Text);
    codCliente    := StrToInt(edtCodCliente.Text);
    dataInicial   := FormatDateTime('yyyy-mm-dd', dtpInicio.Date);
    dataFinal     := FormatDateTime('yyyy-mm-dd', dtpFim.Date);

    textoSQL  := objRelatorioMovBancario.RealizaPesquisa(codConta, codBanco, codCliente,
                                                                  dataInicial, dataFinal);


    with QryRelatorio do
    begin
      close;
      sql.Clear;
      sql.Add(textoSQL);
      open;
    end;

  Finally

    MessageDlg('Erro ao buscar', TMsgDlgType.mtInformation, [mbOk], 0);
  end;
end;



procedure TfrmHerancaRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryRelatorio.Close;
end;



procedure TfrmHerancaRelatorio.FormCreate(Sender: TObject);
begin
  QryRelatorio.Connection   := DtmConexaoPrincipal.ConexaoDB;
  dtsRelatorio.DataSet      := QryRelatorio;
  grdRelatorio.DataSource   := dtsRelatorio;
  objRelatorioMovBancario   := TRelatorioMovBancario.Create(DtmConexaoPrincipal.ConexaoDB);
end;



procedure TfrmHerancaRelatorio.FormShow(Sender: TObject);
begin
// nada por enquanto
if (QryRelatorio.SQL.Text <> EmptyStr) then
  QryRelatorio.Open;

end;



function TfrmHerancaRelatorio.UmCampoObrigatorio: Integer;
var i, aux : integer;
begin
  aux :=  0;
  for i := 0 to ComponentCount -1 do
  begin
      if (Components[i] is TMaskEdit) then
      begin
        if((TMaskEdit(Components[i]).Tag = 2) and (TMaskEdit(Components[i]).Text = EmptyStr)) then
        begin
        aux := aux + 1;
        end;
      end;
  end;

  Result  := aux;

end;

end.
