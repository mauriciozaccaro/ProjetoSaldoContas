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
    A_IdCliente     : Integer;
    A_NumConta      : Integer;
    A_SaldoInicial  : Double;
    A_Situacao      : string;

  public
    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    function InserirRegistro                  : Boolean;
    function ExcluiRegistro                   : Boolean;
    function AtualizarRegistro                : Boolean;
    function SelecionarRegistro(id : Integer) : Boolean;

  published
    property codConta     : Integer         read A_IdConta          write A_IdConta;
    property codBanco     : Integer         read A_IdBanco          write A_IdBanco;
    property codCliente   : Integer         read A_IdCliente        write A_IdCliente;
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
    Qry.ParamByName('codConta').Value  := Self.A_IdConta;
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
      result := false;
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
    Qry.SQL.Add('INSERT INTO bancos (IdBanco, IdCliente,numConta, saldoInicial, situacao) '
              + 'VALUES (:codBanco, :codCliente, :numConta, :saldoInicial, :situacao)');
    QRY.ParamByName('codConta').AsInteger     := A_IdConta;
    QRY.ParamByName('codBanco').AsInteger     := A_IdBanco;
    QRY.ParamByName('codCliente').AsInteger   := A_IdCliente;
    QRY.ParamByName('numConta').AsInteger     := A_NumConta;
    QRY.ParamByName('saldoInicial').AsFloat   := A_SaldoInicial;
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



function TCadConta.SelecionarRegistro(id: Integer): Boolean;
var Qry : TZQuery;
begin
  try
    Result            := true;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT IdConta,'
              + '       IdBanco, '
              + '       IdCliente, '
              + '       numConta, '
              + '       saldoInicial, '
              + '       situacao'
              + '  FROM contas '
              + ' WHERE IdConta = :codigo');
    Qry.ParamByName('codConta').AsInteger := id;
    try
      Qry.Open;
      Self.A_IdConta       := Qry.FieldByName('IdConta').AsInteger;
      Self.A_IdBanco       := Qry.FieldByName('IdBanco').AsInteger;
      Self.A_IdCliente     := Qry.FieldByName('IdCliente').AsInteger;
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
