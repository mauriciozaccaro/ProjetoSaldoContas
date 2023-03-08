unit uHerancaRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask,
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
  frmConsultaBanco    := TfrmConsultaBanco.Create(Self);
  if (frmConsultaBanco.ShowModal = mrOk) then
  begin

  end;
  frmConsultaBanco.Release;
end;



procedure TfrmHerancaRelatorio.btnBuscaClienteClick(Sender: TObject);
begin
  frmConsultaCliente    :=  TfrmConsultaCliente.Create(Self);

  if  (frmConsultaContaBancaria.ShowModal = mrOk) then
  begin
    if (True) then

    edtCodCliente.Text         := frmConsultaCliente.QryConsulta.ParamByName('IdCliente').Text;
    edtNomeCliente.Text        := frmConsultaCliente.QryConsulta.ParamByName('nome').Text;

    edtCodBanco.Text      := EmptyStr;
    edtNomeBanco.Text     := EmptyStr;
    edtCodConta.Text      := EmptyStr;

  end;


  frmConsultaCliente.Release;
end;



procedure TfrmHerancaRelatorio.btnBuscaContaClick(Sender: TObject);
begin
  frmConsultaContaBancaria         :=  TfrmConsultaContaBancaria.Create(Self);
  if (frmConsultaContaBancaria.ShowModal = mrOk) then
  begin

  end;
  frmConsultaContaBancaria.Release;
end;



procedure TfrmHerancaRelatorio.Button1Click(Sender: TObject);
var aux, codConta, codBanco, codCliente : Integer; dataInicial, dataFinal : String;
begin
   {
  aux := UmCampoObrigatorio;
  if (aux > 0) then
  begin
    MessageDlg('Selecione ao menos um campo para pesquisa: ''Banco, Conta Bancária ou Cliente''',
                TMsgDlgType.mtInformation, [TMsgDlgBtn.mbOK], 0);
    Abort;
  end;
   }

  if (dtpFim.Date < dtpInicio.Date) then
  begin
    MessageDlg('''Data Fim'' não pode ser menor que ''Data Início''',
                TMsgDlgType.mtInformation, [mbOk], 0);
    Abort;
  end;

  codConta

  if (edtCodConta.Text = EmptyStr) then
    edtCodConta.Text  := IntToStr(0);

  if (edtCodBanco.Text = EmptyStr) then
    edtCodBanco.Text  := IntToStr(0);

  if (edtCodCliente.Text = EmptyStr) then
    edtCodCliente.Text := IntToStr(0);

    try
      QryRelatorio.Close;
      QryRelatorio.SQL.Clear;
      QryRelatorio.SQL.Add('SELECT MC.IdConta, CL.nome AS cliente, BC.nome AS banco, CT.numConta, CAST(CT.saldoInicial AS Float) AS saldoInicial,  ANT.saldoAnterior, '
                + '      SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) AS totalCredito, '
                + '      SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END) AS totalDebito, '
                + '     (SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) '
                + '    - SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END)) AS saldoAtual '
                + '    FROM movcontas MC, '
                + '         contas CT, '
                + '         clientes CL, '
                + '         bancos BC, '

                + '               (SELECT CTT.IdConta, COALESCE(CTT.saldoInicial '
                + '           +(SUM(CASE WHEN MCC.tipoMov = ''C'' THEN MCC.valor ELSE 0 END) '
                + '           - SUM(CASE WHEN MCC.tipoMov = ''D'' THEN MCC.valor ELSE 0 END)), 0) AS saldoAnterior '
                + '            FROM movcontas MCC, '
                + '                 contas CTT,  '
                + '                 clientes CLL, '
                + '                bancos BCC '
                + '           WHERE MCC.IdConta = CTT.IdConta '
                + '             AND CTT.IdCliente = CLL.IdCliente '
                + '             AND CTT.IdBanco = BCC.IdBanco ');

      if((FormatDateTime('yyyy-mm-dd',dtpInicio.Date) <> EmptyStr) AND (FormatDateTime('yyyy-mm-dd', dtpFim.Date) <> EmptyStr)) then // verifica se a data está preenchida
      begin
        QryRelatorio.SQL.Add('AND MCC.dataMov  BETWEEN :dataInicial AND :dataFinal');
        QryRelatorio.ParamByName('dataInicial').AsString         :=  FormatDateTime('yyyy-mm-dd',dtpInicio.Date);
        QryRelatorio.ParamByName('dataFinal').AsString           :=  FormatDateTime('yyyy-mm-dd', dtpFim.Date);
      end;
        QryRelatorio.SQL.Add('     GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT'
                + '  WHERE MC.IdConta = CT.IdConta '
                + '    AND CT.IdCliente = CL.IdCliente '
                + '    AND CT.IdBanco = BC.IdBanco '
                + '    AND CT.IdConta = ANT.IdConta ' );

      if((FormatDateTime('yyyy-mm-dd',dtpInicio.Date) <> EmptyStr) AND (FormatDateTime('yyyy-mm-dd', dtpFim.Date) <> EmptyStr)) then // verifica se a data está preenchida
      begin
        QryRelatorio.SQL.Add('AND MC.dataMov  BETWEEN :dataInicial AND :dataFinal');
        QryRelatorio.ParamByName('dataInicial').AsString         :=  FormatDateTime('yyyy-mm-dd',dtpInicio.Date);
        QryRelatorio.ParamByName('dataFinal').AsString           :=  FormatDateTime('yyyy-mm-dd', dtpFim.Date);
      end;

      if(edtCodConta.Text <> IntToStr(0)) then // verifica se foi informado a Conta
      begin
        QryRelatorio.SQL.Add('AND CT.IdConta = :codConta');
        QryRelatorio.ParamByName('codConta').AsInteger           := StrToInt(edtCodConta.Text);
      end
      else
      begin
         if(edtCodBanco.Text <> IntToStr(0))then // Verifica se foi informado o Banco e a Conta está vazia
         begin
          QryRelatorio.SQL.Add('AND BC.IdBanco = :codBanco');
          QryRelatorio.ParamByName('codBanco').AsInteger         :=  StrToInt(edtCodbanco.Text);
         end;

         if(edtCodCliente.Text <> IntToStr(0))then // Verifica se foi informado o Banco e a Conta está vazia
         begin
          QryRelatorio.SQL.Add('AND CL.IdCliente = :codCliente');
          QryRelatorio.ParamByName('codCliente').AsInteger       :=  StrToInt(edtCodCliente.Text);
         end;
      end;

       QryRelatorio.SQL.Add('GROUP BY CT.IdConta');

      try
        QryRelatorio.Open;
      except
        MessageDlg('Não foi possível realizar a busca, verifique os filtros informados.', TMsgDlgType.mtInformation, [mbOk], 0);
      end;
    finally
       // nada ainda
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
