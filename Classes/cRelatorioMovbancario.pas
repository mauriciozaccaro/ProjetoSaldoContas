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
    A_Situacao      : string;

  public
    constructor Create(aConexao : TZConnection);
    destructor  Destroy; override;

    procedure SelecionarRegistro;


  published
    property codConta     : Integer         read A_IdConta          write A_IdConta;
    property codBanco     : Integer         read A_IdBanco          write A_IdBanco;
    property banco        : String          read A_Banco            write A_Banco;
    property codCliente   : Integer         read A_IdCliente        write A_IdCliente;
    property cliente      : String          read A_Cliente          write A_Cliente;
    property numConta     : Integer         read A_NumConta         write A_NumConta;
    property saldoInicial : Double          read A_SaldoInicial     write A_SaldoInicial;
    property situacao     : string          read A_Situacao         write A_Situacao;



    public


    published



  end;

implementation

{ TRelatorioMovBancario }

constructor TRelatorioMovBancario.Create(aConexao: TZConnection);
var Qry : TZQuery;
begin
  Qry                   := TZQuery.Create(nil);
  Qry.Connection        := ConexaoDB;
  Qry.SQL.Clear;
 // Qry.SQL.Add()

end;

destructor TRelatorioMovBancario.Destroy;
begin

  inherited;
end;

procedure TRelatorioMovBancario.SelecionarRegistro;
begin

end;

end.
