unit cRelatorioMovbancario;

interface

uses System.Classes,
      Vcl.Controls,
      Vcl.ExtCtrls,
      Vcl.Dialogs,
      ZAbstractConnection,
      ZConnection,
      ZAbstractRODataset,
      ZAbstractDataset,
      ZDataset,
      System.SysUtils;

Type
  TRelatorioMovBancario = class

  private

    ConexaoDB       : TZConnection;
    A_IdConta       : Integer;
    A_IdBanco       : Integer;
    A_Banco         : String;
    A_IdCliente     : Integer;
    A_Cliente       : String;
    A_NumConta      : Integer;
    A_SaldoInicial  : Double;
    A_SaldoAtual    : Double;
    A_TotalCredito  : Double;
    A_TotalDebito   : Double;
    A_DataInicial   : String;
    A_DataFinal     : String;
    A_Situacao      : String;

  public

    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    function RealizaPesquisa(codConta, codBanco, codCliente : Integer;
                              dataInicial, dataFinal  : String) : String;
    //procedure RealizaPesquisa;

  published

    property codConta     : Integer         read A_IdConta          write A_IdConta;
    property codBanco     : Integer         read A_IdBanco          write A_IdBanco;
    property banco        : String          read A_Banco            write A_Banco;
    property codCliente   : Integer         read A_IdCliente        write A_IdCliente;
    property cliente      : String          read A_Cliente          write A_Cliente;
    property numConta     : Integer         read A_NumConta         write A_NumConta;
    property saldoInicial : Double          read A_SaldoInicial     write A_SaldoInicial;
    property totalCredito : Double          read A_TotalCredito     write A_TotalCredito;
    property totalDebito  : Double          read A_TotalDebito      write A_TotalDebito;
    property saldoAtual   : Double          read A_SaldoAtual       write A_SaldoAtual;
    property dataInicial  : String          read A_DataInicial      write A_DataInicial;
    property dataFinal    : String          read A_DataFinal        write A_DataFinal;
    property situacao     : string          read A_Situacao         write A_Situacao;

  end;

implementation

{ TRelatorioMovBancario }

constructor TRelatorioMovBancario.Create(aConexao: TZConnection);
begin
  ConexaoDB   := aConexao;
end;

destructor TRelatorioMovBancario.Destroy;
begin
  inherited;
end;

function TRelatorioMovBancario.RealizaPesquisa(codConta, codBanco, codCliente : Integer;
                              dataInicial, dataFinal  : String) : String;
var Qry : TZQuery;
begin
  try
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;


    Qry.SQL.Add('SELECT MC.IdConta, CL.nome AS cliente, BC.nome AS banco, CT.numConta, CAST(CT.saldoInicial AS Float) AS saldoInicial,  ANT.saldoAnterior, '
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

    if((dataInicial <> EmptyStr) AND (dataFinal <> EmptyStr)) then // verifica se a data está preenchida
    begin
      Qry.SQL.Add('AND MCC.dataMov  BETWEEN :dataInicial AND :dataFinal');
      Qry.ParamByName('dataInicial').AsString         :=  dataInicial;
      Qry.ParamByName('dataFinal').AsString           :=  dataFinal;
    end;
      Qry.SQL.Add('     GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT'
              + '  WHERE MC.IdConta = CT.IdConta '
              + '    AND CT.IdCliente = CL.IdCliente '
              + '    AND CT.IdBanco = BC.IdBanco '
              + '    AND CT.IdConta = ANT.IdConta ' );

    if((dataInicial <> EmptyStr) AND (dataFinal <> EmptyStr)) then // verifica se a data está preenchida
    begin
      Qry.SQL.Add('AND MC.dataMov  BETWEEN :dataInicial AND :dataFinal');
      Qry.ParamByName('dataInicial').AsString         :=  dataInicial;
      Qry.ParamByName('dataFinal').AsString           :=  dataFinal;
    end;

    if(codConta <> 0) then // verifica se foi informado a Conta
    begin
      Qry.SQL.Add('AND CT.IdConta = :codConta');
      Qry.ParamByName('codConta').AsInteger           :=  codConta;
    end
    else
    begin
       if(codBanco <> 0)then // Verifica se foi informado o Banco e a Conta está vazia
       begin
        Qry.SQL.Add('AND BC.IdBanco = :codBanco');
        Qry.ParamByName('codBanco').AsInteger         :=  codBanco;
       end;

       if(codCliente <> 0)then // Verifica se foi informado o Banco e a Conta está vazia
       begin
        Qry.SQL.Add('AND CL.IdCliente = :codCliente');
        Qry.ParamByName('codCliente').AsInteger       :=  codCliente;
       end;
    end;

     Qry.SQL.Add('GROUP BY CT.IdConta');

    try
      Qry.Open;
      Self.A_IdConta       := Qry.FieldByName('IdConta').AsInteger;
      Self.A_Banco         := Qry.FieldByName('banco').AsString;
      Self.A_Cliente       := Qry.FieldByName('cliente').AsString;
      Self.A_NumConta      := Qry.FieldByName('numConta').AsInteger;
      Self.A_SaldoInicial  := Qry.FieldByName('saldoInicial').AsFloat;
      Self.A_TotalCredito  := Qry.FieldByName('totalCredito').AsFloat;
      Self.A_TotalDebito   := Qry.FieldByName('totalDebito').AsFloat;
      Self.A_SaldoAtual    := Qry.FieldByName('saldoAtual').AsFloat;

      Result  := Qry.SQL.GetText;
    except
      MessageDlg('Não foi possível realizar a busca, verifique os filtros informados.', TMsgDlgType.mtInformation, [mbOk], 0);
    end;
     if Assigned(Qry) then
        FreeAndNil(Qry);
  except
    MessageDlg('Erro de conexão', TMsgDlgType.mtError, [mbOk], 0);
  end;

end;

end.
