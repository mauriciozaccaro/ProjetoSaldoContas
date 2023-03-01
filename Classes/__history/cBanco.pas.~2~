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
begin

end;



function TBanco.AtualizarRegistro: Boolean;
begin

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
    Qry.ParamByName('nome').value         := Self.A_Nome;
    Qry.ParamByName('situacao').AsString  := Self.A_Situacao;

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
begin

end;


{$endregion}



end.
