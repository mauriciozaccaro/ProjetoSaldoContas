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
    A_Valor             : double;
    A_TipoMov           : String;

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
    property valor              : Double          read A_Valor              write A_Valor;
    property tipoMovimento      : String          read A_TipoMov            write A_TipoMov;

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
    Qry.SQL.Add('INSERT INTO movContas (IdConta, valor, tipoMov) '
              + 'VALUES (:codConta, :valor, :tipoMovimento)');
    Qry.ParamByName('codConta').AsInteger        := Self.A_IdConta;
    Qry.ParamByName('valor').Value               := Self.A_Valor;
    Qry.ParamByName('tipoMovimento').AsString    := Self.A_TipoMov;
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
    Qry.SQL.Add('SELECT IdMovContas, '
              + '       IdConta,'
              + '       valor, '
              + '       tipoMov'
              + '  FROM movContas'
              + ' WHERE IdMovContas = :codigo');
    Qry.ParamByName('codigo').AsInteger := id;
    try
      Qry.Open;
      Self.A_IdMovContas     := Qry.FieldByName('codigo').AsInteger;
      Self.A_IdConta         := Qry.FieldByName('codConta').AsInteger;
      Self.A_Valor           := Qry.FieldByName('valor').Value;
      Self.A_TipoMov         := Qry.FieldByName('tipoMovimento').AsString;
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
    Qry.sql.Add('UPDATE movcontas SET situacao = :situacao WHERE IdMovContas = :codigo ');
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
    Qry.SQL.Add('UPDATE movcontas'
              + '   SET tipoMov = :tipoMovimento'
              + ' WHERE IdMovContas = :codigo');
    QRY.ParamByName('tipoMovimento').AsString  := A_TipoMov;
    QRY.ParamByName(':codigo').AsInteger       := A_IdMovContas;
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



end.
