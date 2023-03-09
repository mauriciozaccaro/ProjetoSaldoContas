unit uHerancaRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,CommCtrl,
  ZAbstractRODataset, ZAbstractDataset, ZDataset, Vcl.ComCtrls,  uConsultaContaBancaria,
  uDTMConexao, uHerancaConsulta, cRelatorioMovbancario, uConsultaBanco, uConsultaCliente;

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
    edtNumConta: TEdit;
    SpeedButton1: TSpeedButton;
    edtCodConta: TMaskEdit;
    Label7: TLabel;
    Label8: TLabel;
    btnBuscaConta: TSpeedButton;
    Button1: TButton;
    QryRelatorio: TZQuery;
    dtsRelatorio: TDataSource;
    edtCodCliente: TMaskEdit;
    btnBuscaCliente: TSpeedButton;
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
    procedure btnBuscaContaClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnBuscaBancoClick(Sender: TObject);

  private
    { Private declarations }
    objRelatorioMovBancario : TRelatorioMovBancario;

  public
    { Public declarations }
    procedure LimparCampos;

  end;

var
  frmHerancaRelatorio : TfrmHerancaRelatorio;

implementation

{$R *.dfm}



procedure TfrmHerancaRelatorio.btnBuscaBancoClick(Sender: TObject);
begin
  frmConsultaBanco          := TfrmConsultaBanco.Create(Self);
  if (frmConsultaBanco.ShowModal = mrOk) then
  begin
    edtCodBanco.Text        :=  IntToStr(iCampoIdBanco);
    edtNomeBanco.Text       :=  sCampoBanco;
  end;
  frmConsultaBanco.Release;
end;



procedure TfrmHerancaRelatorio.btnBuscaClienteClick(Sender: TObject);
begin
  frmConsultaCliente      :=  TfrmConsultaCliente.Create(Self);
  if  (frmConsultaCliente.ShowModal = mrOk) then
  begin
    frmConsultaCliente.Release;
    edtCodCliente.Text    :=  IntToStr(iCampoIdCliente);
    edtNomeCliente.Text   :=  sCampoCliente;
  end;
  frmConsultaCliente.Release;
end;



procedure TfrmHerancaRelatorio.btnBuscaContaClick(Sender: TObject);
begin
  frmConsultaContaBancaria         :=  TfrmConsultaContaBancaria.Create(Self);
  if (frmConsultaContaBancaria.ShowModal = mrOk) then
  begin
    edtCodConta.Text        :=  IntToStr(iCampoIdConta);
    edtNumConta.Text        :=  IntToStr(iCampoNumConta);
    edtCodBanco.Text        :=  IntToStr(iCampoIdBanco);
    edtCodCliente.Text      :=  IntToStr(iCampoIdCliente);
    edtNomeBanco.Text       :=  sCampoBanco;
    edtNomeCliente.Text     :=  sCampoCliente;
  end;
  frmConsultaContaBancaria.Release;
end;



procedure TfrmHerancaRelatorio.Button1Click(Sender: TObject);
var aux : Integer; testando, codConta, codBanco, codCliente, dataInicial, dataFinal : String;
oParam : TParam;
begin

  if (dtpFim.Date < dtpInicio.Date) then
  begin
    MessageDlg('''Data Fim'' n�o pode ser menor que ''Data In�cio''',
                TMsgDlgType.mtInformation, [mbOk], 0);
    Abort;
  end;

  codConta    :=  edtCodConta.Text;
  codBanco    :=  edtCodBanco.Text;
  codCliente  :=  edtCodCliente.Text;

  if (codConta = EmptyStr) then
    codConta  := IntToStr(0);

  if (codBanco = EmptyStr) then
    codBanco  := IntToStr(0);

  if (codCliente = EmptyStr) then
    codCliente := IntToStr(0);
//
    try
      with QryRelatorio do
      begin

        Close;
        SQl.Clear;
        SQL.Add('SELECT MC.IdConta, CL.nome AS cliente, BC.nome AS banco, CT.numConta, CT.saldoInicial, ');
        SQL.Add('CASE WHEN :dataInicial >= (SELECT MIN(ss.dataMov)  AS dataMov FROM movcontas ss WHERE ss.IdConta = MC.IdConta) THEN ANT.saldoAnterior ELSE CT.saldoInicial END AS saldoAnterior, ');
        SQL.Add('SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) AS totalCredito, ');
        SQL.Add('SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END) AS totalDebito, ');
        SQL.Add('CAST(CASE WHEN :dataInicial >= (SELECT MIN(ss.dataMov)  AS dataMov FROM movcontas ss WHERE ss.IdConta = MC.IdConta) ');
        SQL.Add('THEN ANT.saldoAnterior + SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) - SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END)');
        SQL.Add('ELSE CT.saldoInicial + SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) ');
        SQL.Add('- SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END) ');
        SQL.Add('END AS FLOAT) AS saldoAtual FROM movcontas MC INNER JOIN contas CT ON CT.IdConta = MC.IdConta ');
        SQL.Add('INNER JOIN clientes CL ON CL.IdCliente = CT.IdCliente INNER JOIN bancos BC ON BC.IdBanco = CT.IdBanco ');
        SQL.Add('LEFT JOIN (SELECT CTT.IdConta, (CTT.saldoInicial + COALESCE((SUM(CASE WHEN MCC.tipoMov = ''C'' ');
        SQL.Add('THEN MCC.valor ELSE 0 END) - SUM(CASE WHEN MCC.tipoMov = ''D'' THEN MCC.valor ELSE 0 END)), 0)) AS saldoAnterior ');
        SQL.Add('FROM movcontas MCC LEFT JOIN contas CTT ON CTT.IdConta = MCC.IdConta ');
        SQL.Add('WHERE MCC.IdConta = CTT.IdConta AND MCC.dataMov <= (SELECT MIN(ss.dataMov)  AS dataMov ');
        SQL.Add('FROM movcontas ss WHERE ss.IdConta = MCC.IdConta) ');
        SQL.Add('GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT ON ANT.IdConta = MC.IdConta ');
        SQL.Add('WHERE MC.IdConta = CT.IdConta   AND CT.IdCliente = CL.IdCliente ');
        SQL.Add('AND CT.IdBanco = BC.IdBanco   AND CT.IdConta = ANT.IdConta ');
        SQL.Add('AND MC.dataMov BETWEEN :dataInicial AND :dataFinal ');  //  >= :dataInicial AND MC.dataMov <= :dataFinal ');
        SQL.Add('GROUP BY CT.IdConta ');

      end;

      QryRelatorio.ParamByName('dataInicial').AsString   := FormatDateTime('yyyy-mm-dd', dtpInicio.Date);
      QryRelatorio.ParamByName('dataFinal').AsString     := FormatDateTime('yyyy-mm-dd', dtpFim.Date);

      try
        QryRelatorio.Open;
      except
        MessageDlg('N�o foi poss�vel realizar a busca, verifique os filtros informados.', TMsgDlgType.mtInformation, [mbOk], 0);
      end;
    finally
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

if (QryRelatorio.SQL.Text <> EmptyStr) then
  begin
    //QryRelatorio.Open;
  end;
end;



procedure TfrmHerancaRelatorio.LimparCampos;
var i : integer;
begin
  for i := 0 to Self.ComponentCount -1  do
  begin

    if(Self.components[i] is TEdit) then
      (Self.Components[i] as TEdit).clear;

    if(Self.Components[i] is TLabeledEdit) then
     (Self.Components[i] as TLabeledEdit).clear;

    if(Self.Components[i] is TMaskEdit) then
     (Self.Components[i] as TMaskEdit).clear;

  end;

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
