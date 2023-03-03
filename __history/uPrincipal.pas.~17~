unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uHerancaCadastros, uBanco, uCadConta, uCliente, uCadMovBancario,
  uDTMConexao;

type
  TfrmPrincipal = class(TForm)
    MainMenu1         : TMainMenu;
    Cadastros1        : TMenuItem;
    Movimentos1       : TMenuItem;
    Relatrios1        : TMenuItem;
    Banco1            : TMenuItem;
    ContaBancria1     : TMenuItem;
    Clientes1         : TMenuItem;
    LanarMovimento1   : TMenuItem;
    procedure Banco1Click(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure ContaBancria1Click(Sender: TObject);
    procedure LanarMovimento1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{$region 'Eventos da propria tela'}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

  DtmConexaoPrincipal       := TDtmConexaoPrincipal.Create(Self);
  //DtmConexaoPrincipal.ConexaoDB;
  DtmConexaoPrincipal.ConexaoDB.Connected   := true;
end;



procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmPrincipal);
end;

{$endregion}


{$region 'Eventos do MENU'}

procedure TfrmPrincipal.Banco1Click(Sender: TObject);
begin
  frmCadBancos              := TfrmCadBancos.Create(Self);
  frmCadBancos.ShowModal;
  frmCadBancos.Release;
end;



procedure TfrmPrincipal.Clientes1Click(Sender: TObject);
begin
  frmCadClientes            :=  TfrmCadClientes.Create(Self);
  frmCadClientes.ShowModal;
  frmCadClientes.Release;
end;



procedure TfrmPrincipal.ContaBancria1Click(Sender: TObject);
begin
  frmCadContas              :=  TfrmCadContas.Create(Self);
  frmCadContas.ShowModal;
  frmCadContas.Release;

end;



procedure TfrmPrincipal.LanarMovimento1Click(Sender: TObject);
begin
  frmCadMovBancario         :=  TfrmCadMovBancario.Create(Self);
  frmCadMovBancario.ShowModal;
  frmCadMovBancario.Release;
end;

{$endregion}



end.
