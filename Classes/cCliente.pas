unit cCliente;

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
  TCliente = class

  private
    ConexaoDB   : TZConnection;
    A_IdCliente : Integer;
    A_Nome      : string;
    A_Documento : Integer;
    A_Situacao  : string;

  public
    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    function InserirRegistro                  : Boolean;
    function ExcluiRegistro                   : Boolean;
    function AtualizarRegistro                : Boolean;
    function SelecionarRegistro(id : Integer) : Boolean;

  published
    property codigo     : Integer         read A_IdCliente        write A_IdCliente;
    property nome       : string          read A_Nome             write A_Nome;
    property documento  : Integer         read A_Documento        write A_Documento;
    property situacao   : string          read A_Situacao         write A_Situacao;

  end;

implementation


{ TCliente }
constructor TCliente.Create(aConexao: TZConnection);
begin
  ConexaoDB   := aConexao;
end;



destructor TCliente.Destroy;
begin
  inherited;
end;




{$region 'Inserir, Apagar, Atualizar e Selecionar'}

function TCliente.ExcluiRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM clientes WHERE IdCliente = :codigo');
    Qry.ParamByName('codigo').Value  := Self.A_IdCliente;
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



function TCliente.AtualizarRegistro: Boolean;
var QRY : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('UPDATE clientes'
              + '   SET nome =       :nome,'
              + '       documento =  :situacao'
              + '       situacao =   :situacao'
              + ' WHERE IdCliente =  :codigo');
    QRY.ParamByName('codigo').AsInteger     := A_IdCliente;
    QRY.ParamByName('nome').AsString        := A_Nome;
    QRY.ParamByName('documento').AsInteger  := A_Documento;
    QRY.ParamByName('situacao').AsString    := A_Situacao;
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



function TCliente.InserirRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                  := true;
    Qry                     := TZQuery.Create(nil);
    Qry.Connection          := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('INSERT INTO clientes (nome, documento, situacao) '
              + ' VALUES (:nome, :documento, :situacao)');
    Qry.ParamByName('nome').AsString        := Self.A_nome;
    Qry.ParamByName('documento').AsInteger  := Self.A_Documento;
    Qry.ParamByName('situacao').AsString    := Self.A_Situacao;

    try
      Qry.ExecSQL;
    Except
      Result  := false;
    end;
  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;



function TCliente.SelecionarRegistro(id: Integer): Boolean;
var Qry : TZQuery;
begin
  try
    Result            := true;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT IdCliente,'
              + '       nome, '
              + '       situacao'
              + '  FROM clientes'
              + ' WHERE IdCliente = :codigo');
    Qry.ParamByName('codigo').AsInteger := id;
    try
      Qry.Open;
      Self.A_IdCliente  := Qry.FieldByName('IdCliente').AsInteger;
      Self.A_Nome       := Qry.FieldByName('nome').AsString;
      Self.A_Documento  := Qry.FieldByName('documento').AsInteger;
      Self.A_Situacao   := Qry.FieldByName('situacao').AsString;
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
