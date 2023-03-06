unit cCadConta;

interface

uses  System.Classes,
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
  TCadConta = class

  private
    ConexaoDB       : TZConnection;
    A_IdConta       : Integer;
    A_IdBanco       : Integer;
    A_Banco         : String;
    A_IdCliente     : Integer;
    A_Cliente       : String;
    A_NumConta      : Integer;
    A_SaldoInicial  : Double;
    A_Situacao      : string;

  public
    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    function InserirRegistro                  : Boolean;
    function ExcluiRegistro                   : Boolean;
    function AtualizarRegistro                : Boolean;
    function PossuiSaldo(id : Integer)        : Boolean;
    function PossuiMovimento(IdConta:Integer) : Boolean;
    function SelecionarRegistro(id : Integer) : Boolean;

  published
    property codConta     : Integer         read A_IdConta          write A_IdConta;
    property codBanco     : Integer         read A_IdBanco          write A_IdBanco;
    property banco        : String          read A_Banco            write A_Banco;
    property codCliente   : Integer         read A_IdCliente        write A_IdCliente;
    property cliente      : String          read A_Cliente          write A_Cliente;
    property numConta     : Integer         read A_NumConta         write A_NumConta;
    property saldoInicial : Double          read A_SaldoInicial     write A_SaldoInicial;
    property situacao     : string          read A_Situacao         write A_Situacao;

  end;

implementation


{$region 'Construtor e destrutor'}

constructor TCadConta.Create(aConexao: TZConnection);
begin
  ConexaoDB   := aConexao;
end;



destructor TCadConta.Destroy;
begin
  inherited;
end;

{$endregion}



{$region 'Inserir, Apagar, Atualizar e Selecionar'}

function TCadConta.ExcluiRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM contas WHERE IdConta = :codigo');
    Qry.ParamByName('codigo').Value  := Self.A_IdConta;
    try
      Qry.ExecSQL;
    Except
      Result                         := false;
    end;
  finally
    if Assigned (Qry) then
      FreeAndnil(Qry);
  end;

end;



function TCadConta.AtualizarRegistro: Boolean;
var QRY : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('UPDATE contas'
              + '   SET IdBanco =       :codBanco,'
              + '       IdCliente =     :codCliente,'
              + '       numConta =      :numConta,'
              + '       saldoInicial =  :saldoInicial,'
              + '       situacao =      :situacao'
              + ' WHERE IdConta = :codConta');
    QRY.ParamByName('codConta').AsInteger     := A_IdConta;
    QRY.ParamByName('codBanco').AsInteger     := A_IdBanco;
    QRY.ParamByName('codCliente').AsInteger   := A_IdCliente;
    QRY.ParamByName('numConta').AsInteger     := A_NumConta;
    QRY.ParamByName('saldoInicial').AsFloat   := A_SaldoInicial;
    QRY.ParamByName('situacao').AsString      := A_Situacao;
    try
      Qry.ExecSQL;
    Except
      Result := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;



function TCadConta.InserirRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                  := true;
    Qry                     := TZQuery.Create(nil);
    Qry.Connection          := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('INSERT INTO contas (IdBanco, IdCliente, numConta, saldoInicial, situacao) '
              + 'VALUES (:codBanco, :codCliente, :numConta, :saldoInicial, :situacao)');
    QRY.ParamByName('codBanco').AsInteger     := A_IdBanco;
    QRY.ParamByName('codCliente').AsInteger   := A_IdCliente;
    QRY.ParamByName('numConta').AsInteger     := A_NumConta;
    QRY.ParamByName('saldoInicial').Value     := A_SaldoInicial;
    QRY.ParamByName('situacao').AsString      := A_Situacao;

    try
      Qry.ExecSQL;
    Except
      Result  := false; // se der BO e n�o executar o SQL, vai cair aqui
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;



function TCadConta.PossuiMovimento(IdConta: Integer): Boolean;
var Qry : TZQuery; aux1, aux2 : Integer;
begin
  try
    Result            := false;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COUNT() AS quantidade FROM movContas WHERE IdConta = :codConta;');
    Qry.ParamByName('codConta').AsInteger := IdConta;
    try
      Qry.Open;
      aux1       := Qry.FieldByName('quantidade').AsInteger;

      if (aux1 = 0) then
        Result  :=  false
      else
        Result  := true;

    except
      Result  :=  true;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;

end;



// N�o esquecer de alterar todo esse SQL... vai precisar buscar o saldo da conta.
function TCadConta.PossuiSaldo(id: Integer): Boolean;
var Qry : TZQuery; aux1 : Float32;
begin
  try
    Result            := false;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT COALESCE(SUM(saldoInicial + CREDITO - DEBITO), 0) AS saldo FROM ('
               +'SELECT IdConta, '
               +'(SELECT SUM(valor) FROM movcontas WHERE tipoMov = ''C'') AS CREDITO, '
               +'(SELECT SUM(valor) FROM movcontas WHERE tipoMov = ''D'') AS DEBITO '
               +'   FROM movcontas '
               +' INNERJOIN  contas ON contas.IdConta = movcontas.Idconta '
               +' WHERE IdConta = :codConta  GROUP BY IdConta)');
    Qry.ParamByName('codConta').AsInteger := id;
    try
      Qry.Open;
      aux1       := Qry.FieldByName('saldo').AsFloat;

       if (aux1 = 0.00) then
        Result  :=  false
      else
        Result  := true;

    except
      Result  :=  true;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

function TCadConta.SelecionarRegistro(id: Integer): Boolean;
var Qry : TZQuery;
begin
  try
    Result            := true;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;

       Qry.SQL.Add('SELECT contas.IdConta,'
              + '          contas.IdBanco, '
              + '          bancos.nome AS banco, '
              + '          contas.IdCliente, '
              + '          clientes.nome AS cliente, '
              + '          contas.numConta, '
              + '          contas.saldoInicial, '
              + '          contas.situacao'
              + '  FROM contas'
              + ' INNER JOIN bancos ON bancos.IdBanco = contas.IdBanco'
              + ' INNER JOIN clientes ON clientes.IdCliente = contas.IdCliente'
              + ' WHERE contas.IdConta = :codConta ');
    Qry.ParamByName('codConta').AsInteger := id;
    try
      Qry.Open;
      Self.A_IdConta       := Qry.FieldByName('IdConta').AsInteger;
      Self.A_IdBanco       := Qry.FieldByName('IdBanco').AsInteger;
      Self.A_Banco         := Qry.FieldByName('banco').AsString;
      Self.A_IdCliente     := Qry.FieldByName('IdCliente').AsInteger;
      Self.A_Cliente       := Qry.FieldByName('cliente').AsString;
      Self.A_NumConta      := Qry.FieldByName('numConta').AsInteger;
      Self.A_SaldoInicial  := Qry.FieldByName('saldoInicial').AsFloat;
      Self.A_Situacao      := Qry.FieldByName('situacao').AsString;

    except
      Result  :=  false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;

{$endregion}


end.
