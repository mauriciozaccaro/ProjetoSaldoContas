unit cMovBancario;

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
  TMovBancario = class

  private
    ConexaoDB           : TZConnection;
    A_IdMovContas       : Integer;
    A_IdConta           : Integer;
    A_IdBanco           : Integer;
    A_IdCliente         : Integer;
    A_NumConta          : Integer;
    A_NomeBanco         : String;
    A_NomeCliente       : String;
    A_Valor             : double;
    A_TipoMov           : String;
    A_DataMov           : String;

  public
    constructor Create(aConexao : TZConnection);
    destructor destroy; override;

    function InserirRegistro                  : Boolean;
    function AtualizarRegistro                : Boolean;
    function ExcluirRegistro                  : Boolean;
    function SelecionarRegistro(id : Integer) : Boolean;

  published
    property codigo             : Integer         read A_IdMovContas        write A_IdMovContas;
    property codConta           : Integer         read A_IdConta            write A_IdConta;
    property codBanco           : Integer         read A_IdBanco            write A_IdBanco;
    property codCliente         : Integer         read A_IdCliente          write A_IdCliente;
    property numConta           : Integer         read A_NumConta           write A_NumConta;
    property banco              : String          read A_NomeBanco          write A_NomeBanco;
    property cliente            : String          read A_NomeCliente        write A_NomeCliente;
    property valor              : Double          read A_Valor              write A_Valor;
    property tipoMovimento      : String          read A_TipoMov            write A_TipoMov;
    property dataMov            : String          read A_DataMov            write A_DataMov;

  end;


implementation

  { TMovBancario }
{$region 'Contrutor e Destrutor'}
constructor TMovBancario.Create(aConexao: TZConnection);
begin
  ConexaoDB := aConexao;
end;



destructor TMovBancario.destroy;
begin
  inherited;
end;
{$endregion}



function TMovBancario.InserirRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                  := true;
    Qry                     := TZQuery.Create(nil);
    Qry.Connection          := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('INSERT INTO movContas (IdConta, valor, tipoMov, dataMov) '
              + 'VALUES (:codConta, :valor, :tipoMovimento, :dataMov)');
    Qry.ParamByName('codConta').AsInteger        := Self.A_IdConta;
    Qry.ParamByName('valor').Value               := Self.A_Valor;
    Qry.ParamByName('tipoMovimento').AsString    := Self.A_TipoMov;
    Qry.ParamByName('dataMov').AsString          := Self.A_DataMov;
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



function TMovBancario.SelecionarRegistro(id: Integer): Boolean;
var Qry : TZQuery;
begin
  try
    Result            := true;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT mc.IdMovContas, '
                   + '  mc.IdConta, '
                   + '  ct.numConta, '
                   + '  ct.IdBanco, '
                   + '  ct.IdCliente, '
                   + '  cl.nome AS cliente, '
                   + '  bc.nome AS banco, '
                   + '  mc.valor, '
                   + '  mc.tipoMov, '
                   + '  mc.dataMov '
              + '  FROM movContas mc, '
                 + '    contas ct, '
                 + '    clientes cl, '
                 + '    bancos bc '
             + '  WHERE mc.IdConta = ct.IdConta '
               + '  AND ct.IdCliente = cl.IdCliente '
               + '  AND ct.IdBanco = bc.IdBanco '
               + '  AND mc.IdMovContas = :codigo');
    Qry.ParamByName('codigo').AsInteger := id;
    try
      Qry.Open;
      Self.A_IdMovContas     := Qry.FieldByName('IdMovContas').AsInteger;
      Self.A_IdConta         := Qry.FieldByName('IdConta').AsInteger;
      Self.A_IdBanco         := Qry.FieldByName('IdBanco').AsInteger;
      Self.A_IdCliente       := Qry.FieldByName('IdCliente').AsInteger;
      Self.A_NumConta        := Qry.FieldByName('numConta').AsInteger;
      Self.A_NomeBanco       := Qry.FieldByName('banco').AsString;
      Self.A_NomeCliente     := Qry.FieldByName('cliente').AsString;
      Self.A_Valor           := Qry.FieldByName('valor').Value;
      Self.A_TipoMov         := Qry.FieldByName('tipoMov').AsString;
      Self.A_DataMov         := Qry.FieldByName('dataMov').AsString;
    except
      Result  :=  false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;



// refazer isso aqui, porque dropei a coluna "situacao"
function TMovBancario.ExcluirRegistro: Boolean;
var Qry : TZQuery;
begin
   try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.SQL.Clear;
    Qry.sql.Add('DELETE FROM movcontas WHERE IdMovContas = :codigo ');
    Qry.ParamByName('codigo').value    := IntToStr(Self.A_IdMovContas);
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



function TMovBancario.AtualizarRegistro: Boolean;
var QRY : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('UPDATE movcontas '
              + '   SET tipoMov = :tipoMovimento, '
              + '       valor =   :valor, '
              + '       dataMov = :dataMov '
              + ' WHERE IdMovContas = :codigo');
    QRY.ParamByName('tipoMovimento').AsString  := A_TipoMov;
    QRY.ParamByName('codigo').AsInteger        := A_IdMovContas;
    QRY.ParamByName('valor').AsFloat           := A_Valor;
    QRY.ParamByName('dataMov').AsString        := A_DataMov;
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



end.
