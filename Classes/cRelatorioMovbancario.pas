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
    A_SaldoFinal    : Double;
    A_TotalCredito  : Double;
    A_TotalDebito   : Double;
    A_DataInicial   : String;
    A_DataFinal     : String;
    A_Situacao      : String;

  public

    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    procedure RealizaPesquisa;


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
    property saldoFinal   : Double          read A_SaldoFinal       write A_SaldoFinal;
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

procedure TRelatorioMovBancario.RealizaPesquisa;
var Qry : TZQuery;
begin

  Qry                   := TZQuery.Create(nil);
  Qry.Connection        := ConexaoDB;
  Qry.SQL.Clear;
  Qry.SQL.Add('SELECT MC.IdConta, CL.nome AS cliente, BC.nome AS banco, CT.numConta, CT.saldoInicial,  ANT.ANTERIOR, '
            + '      SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) AS CREDITO, '
            + '      SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END) AS DEBITO, '
            + '     (SUM(CASE WHEN MC.tipoMov = ''C'' THEN MC.valor ELSE 0 END) '
            + '    - SUM(CASE WHEN MC.tipoMov = ''D'' THEN MC.valor ELSE 0 END)) AS SALDO '
            + '    FROM movcontas MC, '
            + '         contas CT, '
            + '         clientes CL, '
            + '         bancos BC, '

            + '               (SELECT CTT.IdConta, COALESCE(CTT.saldoInicial '
            + '           +(SUM(CASE WHEN MCC.tipoMov = ''C'' THEN MCC.valor ELSE 0 END) '
            + '           - SUM(CASE WHEN MCC.tipoMov = ''D'' THEN MCC.valor ELSE 0 END)), 0) AS ANTERIOR '
            + '            FROM movcontas MCC, '
            + '                 contas CTT,  '
            + '                 clientes CLL, '
            + '                bancos BCC '
            + '           WHERE MCC.IdConta = CTT.IdConta '
            + '             AND CTT.IdCliente = CLL.IdCliente '
            + '             AND CTT.IdBanco = BCC.IdBanco ');

  if((Self.A_DataInicial <> EmptyStr) AND (Self.A_DataFinal <> EmptyStr)) then // verifica se a data est� preenchida
  begin
    Qry.SQL.Add('AND MCC.dataMov  BETWEEN :dataInicial AND :dataFinal');
    Qry.ParamByName('dataInicial').AsString         :=  Self.A_DataInicial;
    Qry.ParamByName('dataFinal').AsString           :=  Self.A_DataInicial;
  end;
    Qry.SQL.Add('     GROUP BY CTT.IdConta, CTT.saldoInicial) AS ANT'
            + '  WHERE MC.IdConta = CT.IdConta '
            + '    AND CT.IdCliente = CL.IdCliente '
            + '    AND CT.IdBanco = BC.IdBanco '
            + '    AND CT.IdConta = ANT.IdConta ' );

  if((Self.A_DataInicial <> EmptyStr) AND (Self.A_DataFinal <> EmptyStr)) then // verifica se a data est� preenchida
  begin
    Qry.SQL.Add('AND MC.dataMov  BETWEEN :dataInicial AND :dataFinal');
    Qry.ParamByName('dataInicial').AsString         :=  Self.A_DataInicial;
    Qry.ParamByName('dataFinal').AsString           :=  Self.A_DataInicial;
  end;

  if(Self.A_IdConta <> 0) then // verifica se foi informado a Conta
  begin
    Qry.SQL.Add('AND BC.IdConta = :codConta');
    Qry.ParamByName('codConda').AsInteger           :=  Self.A_IdConta;
  end
  else
  begin
     if(Self.A_IdBanco <> 0)then // Verifica se foi informado o Banco e a Conta est� vazia
     begin
      Qry.SQL.Add('AND BC.IdBanco = :codConta');
      Qry.ParamByName('codBanco').AsInteger         :=  Self.A_IdBanco;
     end;

     if(Self.A_IdCliente <> 0)then // Verifica se foi informado o Banco e a Conta est� vazia
     begin
      Qry.SQL.Add('AND BC.IdCliente = :codConta');
      Qry.ParamByName('codCliente').AsInteger       :=  Self.A_IdCliente;
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
    Self.A_SaldoFinal    := Qry.FieldByName('saldoFinal').AsFloat;
  except
    MessageDlg('N�o foi poss�vel realizar a busca, verifique os filtros informados.', TMsgDlgType.mtInformation, [mbOk], 0);
  end;
   if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end.
