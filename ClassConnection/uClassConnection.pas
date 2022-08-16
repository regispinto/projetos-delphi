unit uClassConnection;

interface

uses
    IniFiles, SysUtils, Forms, Dialogs, StrUtils, Data.DB,

    FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL, FireDAC.Comp.Client, FireDAC.Stan.Intf,


    FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
    FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,

    FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
    FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
    FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.IBWrapper,

    FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet,
    FireDAC.Comp.UI,

    uFunctios;

type
   TConnect = class
   private
      FConnection: TFDConnection;
      FPath: string;
      FFileName: string;
      FServer: string;
      FPort: string;
      FDatabase: string;
      FPass: string;
      FUser: string;
      FDriver: string;
      FDriverID: string;
      FOpenMode: string;
      FSection: string;
      FMsgErr: string;

   public
      property Connection : TFDConnection read FConnection write FConnection;
      property Path: string read FPath write FPath;
      property FileName: string read FFileName write FFileName;
      property Server: string read FServer write FServer;
      property Port: string read FPort write FPort;
      property Database: string read FDatabase write FDatabase;
      property Pass: string read FPass write FPass;
      property User: string read FUser write FUser;
      property Driver: string read FDriver write FDriver;
      property DriverID: string read FDriverID write FDriverID;
      property OpenMode: string read FOpenMode write FOpenMode;
      property Section: string read FSection write FSection;
      property MsgErr: string read FMsgErr write FMsgErr;

      constructor Create (NameConnection: TFDConnection);
      destructor Destroy; Override;

      function getTables(SQLText: string): TDataSet;
      function getDllDriver(Dll: string): Boolean;

      procedure setConnectDatabase;
      function connectionDatabase: Boolean;
      function createDatabase: Boolean;

      procedure createFolderBD;
   end;

implementation

{ TConnect }

constructor TConnect.Create(NameConnection: TFDConnection);
begin
  FConnection := NameConnection;
end;

destructor TConnect.Destroy;
begin
  FConnection.Connected := False;
  inherited;
end;

procedure TConnect.setConnectDatabase;
begin
  //createFolderBD;

  FConnection.Params.Clear;
  FConnection.Params.Add('DriverID='+ DriverID);
  FConnection.Params.Add('Database='+ FDatabase);

  //--FDatabase := loadIni('BANCO', 'Database', 'db_dados');

  case AnsiIndexStr(UpperCase(DriverID), ['SQLITE', 'MYSQL', 'FB']) of
    0: begin
        FConnection.Params.Add('OpenMode='+'ReadWrite');
       end;

    1: begin
        FServer := loadIni('BANCO', 'Server', '127.0.0.1');
        FUser := loadIni('BANCO', 'UserName', 'root');
        FPass := loadIni('BANCO', 'Password', '123456');
        FPort := loadIni('BANCO', 'Port', '3306');

        FConnection.Params.Add('Server='+ FServer);
        FConnection.Params.Add('user_name='+ FUser);
        FConnection.Params.Add('password='+ FPass);
        FConnection.Params.Add('port='+ FPort);
       end;

    2: begin
        FServer := loadIni('BANCO', 'Server', '127.0.0.1');
        FUser := loadIni('BANCO', 'UserName', 'SYSDBA');
        FPass := loadIni('BANCO', 'Password', 'masterkey');
        FPort := loadIni('BANCO', 'Port', '3050');

        FConnection.Params.Add('Server='+ FServer);
        FConnection.Params.Add('user_name='+ FUser);
        FConnection.Params.Add('password='+ FPass);
        FConnection.Params.Add('port='+ FPort);
       end;
  end;

  FConnection.LoginPrompt := False;
end;

function TConnect.connectionDatabase: Boolean;
begin
  try
    Result := True;

    FConnection.Connected := False;
    FConnection.Connected := True;
  Except
    on E:Exception do
    begin
      FMsgErr := e.Message;

      Result := False;
    end;
  end;
end;

function TConnect.createDatabase: Boolean;
var
  QrySQL: TFDQuery;

begin
  try
    Result := True;

    FConnection.Connected := False;
    FConnection.Params.Values['Database'] := '';
    FConnection.Connected := True;

    try
      QrySQL := TFDQuery.Create(nil);
      QrySQL.Connection := FConnection;

      QrySQL.SQL.Clear;
      QrySQL.SQL.Add('create database ' + FDatabase);
      QrySQL.SQL.Add(' character set utf8');
      QrySQL.SQL.Add(' collate = utf8_bin');
      QrySQL.Prepare;
      QrySQL.ExecSQL;

      FMsgErr := '';
    except
      on e:Exception do
        begin
          FMsgErr := e.ToString;

          Result := False;
        end;
    end;

  finally
    FreeAndNil(QrySQL)

  end;
end;

procedure TConnect.createFolderBD;
var
  LPath: String;

begin
  LPath := '\' + FPath;
  CreatePath(LPath);

  LPath := LPath + '\' + FFileName;
  CreateFile(LPath);

  FDatabase := LPath;
end;

function TConnect.getDllDriver(Dll: String): Boolean;
begin
  Result := True;

  if not (FileExists(Dll)) then
    begin
      ShowMessage('Arquivo ' + Dll + ' não foi localizado.' +#13+ 'Verifique!');

      Result := False;
    end;
end;

function TConnect.getTables(SQLText: String): TDataSet;
begin
  try
    Result := TFDQuery.Create(nil);

    TFDQuery(Result).Connection := FConnection;
    TFDQuery(Result).SQL.Add(SQLText);
    TFDQuery(Result).Open;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

end.

//Function FireBirdStarted: Boolean;
//Begin
//Result := ( FindWindow( ´FB_Guard´, Nil ) <> 0 ) ;
//End;
