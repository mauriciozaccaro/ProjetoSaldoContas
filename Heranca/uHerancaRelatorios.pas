unit uHerancaRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.ComCtrls,  uConsultaContaBancaria,
  uDTMConexao, uHerancaConsulta;

type
  TfrmHerancaRelatorio = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    grdRelatorio: TDBGrid;
    DBNavigator1: TDBNavigator;
    edtCoBanco: TMaskEdit;
    btnBuscaBanco: TSpeedButton;
    edtNomeBanco: TEdit;
    Label1: TLabel;
    edtC: TEdit;
    Label3: TLabel;
    SpeedButton1: TSpeedButton;
    edtCodConta: TMaskEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
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
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);

    function UmCampoObrigatorio : Integer;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHerancaRelatorio: TfrmHerancaRelatorio;

implementation

{$R *.dfm}



procedure TfrmHerancaRelatorio.Button1Click(Sender: TObject);
var aux : Integer;
begin
  aux := UmCampoObrigatorio;
  if (aux > 0) then
  begin
    MessageDlg('Selecione ao menos um campo para pesquisa: ''Banco, Conta Banc�ria ou Cliente''',
                TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    Abort;
  end;

  if (dtpFim.Date < dtpInicio.Date) then
  begin
    MessageDlg('''Data Fim'' n�o pode ser menor que ''Data In�cio''',
                TMsgDlgType.mtInformation, [mbOk], 0);
    Abort;
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
end;

procedure TfrmHerancaRelatorio.FormShow(Sender: TObject);
begin
// nada por enquanto
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
