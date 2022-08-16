unit uDM;

interface

uses
  System.SysUtils, System.Classes, StrUtils, Dialogs, Data.DB,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.UI, FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL,

  uFunctios, uClassConnection,

  ClassePedidos, ClasseClientes, ClasseProdutos;

type
  TDM = class(TDataModule)
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDConnection: TFDConnection;
    dtsGeneric: TDataSource;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure CreateUpedateDB;
   { Private declarations }
  public
    PedidosDadosGerais : TPedidosDadosGerais;
    PedidosProdutos: TPedidosProdutos;
    Cliente: TClientes;
    Produto: TProdutos;

    Conexao: TConnect;

    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  LFile: string;
  LDll: string;

begin
  LDll := System.SysUtils.GetCurrentDir + '\libmysql.dll';

  // Valida a existência da libmysql.dll na pasta do executável
  if Conexao.getDllDriver(LDll) then
    begin
      FDPhysMySQLDriverLink.VendorLib := LDll;

      lFile := 'config.ini';

      if not checkIniParams(lFile) then
        createIniParams(LFile);

      Conexao           := TConnect.Create( FDConnection );
      Conexao.DriverID  := 'MYSQL';

      Conexao.setConnectDatabase;

      if not Conexao.connectionDatabase then
        Conexao.createDatabase;

      //-- Cria as tabelas relacionadas ao projeto
      CreateUpedateDB;
    end;
end;

procedure TDM.CreateUpedateDB;
var
  LSQLCreateLogs: String;
  LDSTables: TDataSet;

begin
  try
    LDSTables := nil;

    LDSTables := Conexao.getTables('SELECT * FROM information_schema.tables where table_schema = "'+ Conexao.Database + '"');

    if not LDSTables.Locate('table_name', 'Clientes', []) then
      begin
        try
          Cliente := TClientes.Create(FDConnection, Conexao.Database);

          if Cliente.createTableCustomers = EmptyStr then
            Cliente.insertCustomersRecords(Cliente, 50);

        finally
          FreeAndNil(Cliente)

        end;
      end;
    {
    if not LDSTables.Locate('table_name', 'Produtos', []) then
      begin
       //
      end;

    if not LDSTables.Locate('table_name', 'PedidosDadosGerais', []) then
      begin
       //
      end;

    if not LDSTables.Locate('table_name', 'PedidosProdutos', []) then
      begin
       //
      end;
    }

  finally
    FreeAndNil(LDSTables);

  end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  Conexao.Destroy;
end;

end.
