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

  uFunctios, uClassConnection;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure CreateUpedateDB;
    { Private declarations }
  public
    Conexao : TConnect;

    { Public declarations }
  end;

var
  //DriverMySQL: TFDPhysMySQLDriverLink;
  //Cursor: TFDGUIxWaitCursor;
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  //Cursor := TFDGUIxWaitCursor.Create(nil);

  Conexao           := TConnect.Create( FDConnection );
  Conexao.DriverID  := 'SQLite';
  Conexao.FileName  := 'logs.db';
  Conexao.Path      := 'Database';

  Conexao.setConnectDatabase;

  if not Conexao.connectionDatabase then
    Conexao.createDatabase;

  //-- Cria as tabelas relacionadas ao projeto
  CreateUpedateDB;
end;

procedure TDM.CreateUpedateDB;
var
  LDSTables: TDataSet;
  LSQLCreateLogs: String;

begin
  try
    LDSTables := nil;
    LDSTables := Conexao.getTables('select name from sqlite_master where type="table"');

    if not LDSTables.Locate('name', 'logsdownload', []) then
      begin
        LSQLCreateLogs := 'CREATE table logsdownload(' + #13+
                          'CODIGO NUMERIC(22,0) NOT NULL,' + #13+
                          'URL VARCHAR(600) NOT NULL,' + #13+
                          'DATAINICIO DATE NOT NULL,' + #13+
                          'DATAFIM DATE)';

        dm.FDConnection.ExecSQL(LSQLCreateLogs);
      end;
  finally
    FreeAndNil(LDSTables);

  end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  Conexao.Destroy;
  //Cursor.Destroy;
end;

end.
