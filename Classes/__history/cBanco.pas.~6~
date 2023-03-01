unit cBanco;

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
  TBanco = class

  private
    ConexaoDB   : TZConnection;
    A_IdBanco   : Integer;
    A_Nome      : string;
    A_Situacao  : string;

    {
    function getCodigo  : Integer;
    function getNome    : String;
    function getSituacao: String;

    procedure setCodigo(const Value : Integer);
    procedure setNome  (const Value : String);
    procedure setSituacao(const Value : String);
    }

  public
    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    function InserirRegistro                  : Boolean;
    function ExcluiRegistro                   : Boolean;
    function AtualizarRegistro                : Boolean;
    function SelecionarRegistro(id : Integer) : Boolean;

  published
    property codigo   : Integer         read A_IdBanco          write A_IdBanco;
    property nome     : string          read A_Nome             write A_Nome;
    property situacao : string          read A_Situacao         write A_Situacao;

  end;

implementation

{ TBanco }

{$region 'Construtor e destrutor'}

constructor TBanco.Create(aConexao: TZConnection);
begin
  ConexaoDB   := aConexao;
end;



destructor TBanco.Destroy;
begin
  inherited;
end;

{$endregion}



{$region 'Inserir, Apagar, Atualizar e Selecinar'}


function TBanco.ExcluiRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('DELETE FROM bancos WHERE IdBanco = :codigo');
    Qry.ParamByName('codigo').Value  := Self.A_IdBanco;
    try
      Qry.ExecSQL;
    Except
      Result                         := false;
    end;
  finally
    if Assigned (Qry) then // verifica se o QryApagar foi criado na memória
      FreeAndnil(Qry);  // limpa QryApagar da memória
  end;

end;



function TBanco.AtualizarRegistro: Boolean;
var QRY : TZQuery;
begin
  try
    Result                           := true;
    Qry                              := TZQuery.Create(nil);
    Qry.Connection                   := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('UPDATE bancos'
              + '   SET nome =       :nome,'
              + '       situacao =   :situacao'
              + ' WHERE Idbanco =    :codigo');
    QRY.ParamByName('codigo').AsInteger     := A_IdBanco;
    QRY.ParamByName('nome').AsString        := A_Nome;
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



function TBanco.InserirRegistro: Boolean;
var Qry : TZQuery;
begin
  try
    Result                  := true;
    Qry                     := TZQuery.Create(nil);
    Qry.Connection          := ConexaoDB;
    Qry.sql.Clear;
    Qry.SQL.Add('INSERT INTO bancos (nome, situacao) VALUES (:nome, :situacao)');
    Qry.ParamByName('nome').AsString        := Self.A_nome;
    Qry.ParamByName('situacao').AsString    := Self.A_Situacao;

    try
      Qry.ExecSQL;
    Except
      Result  := false; // se der BO e não executar o SQL, vai cair aqui
    end;

  finally
    if Assigned(Qry) then
      FreeAndNil(Qry);
  end;
end;



function TBanco.SelecionarRegistro(id: Integer): Boolean;
var Qry : TZQuery;
begin
  try
    Result            := true;
    Qry               := TZQuery.Create(nil);
    Qry.Connection    := ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add('SELECT IdBanco,'
              + '       nome, '
              + '       situacao'
              + '  FROM bancos'
              + ' WHERE IdBanco = :codigo');
    Qry.ParamByName('codigo').AsInteger := id;
    try
      Qry.Open;
      Self.A_IdBanco    := Qry.FieldByName('IdBanco').AsInteger;
      Self.A_Nome       := Qry.FieldByName('nome').AsString;
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
