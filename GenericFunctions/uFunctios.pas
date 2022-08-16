unit uFunctios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB,
  Vcl.Grids, FireDAC.Comp.Client, IniFiles;

  procedure saveIni(Key1, Key2, aTexto: string; FileName: string='config.ini');
  function loadIni(Key1, Key2, DefaultValue: string; FileName: string='config.ini'): String;

  function TrocaVirgulaPorPonto(Valor: string): string;
  function GeraLOG(Log: String): string;
  function nextID(Connection: TFDConnection; Table, Field: string): integer;

  function checkIniParams(FileName: string): Boolean;
  procedure createIniParams(FileName: string);

  procedure createPath(var Path: string);
  procedure createFile(var Path: string);

implementation

procedure saveIni(Key1, Key2, aTexto: string; FileName: string='config.ini');
var
  ArqIni: TIniFile;

begin
  ArqIni := TIniFile.Create(System.SysUtils.GetCurrentDir + '\' + FileName);

  try
    ArqIni.WriteString(Key1, Key2, aTexto);

  finally

    ArqIni.Free;
  end;
end;

function loadIni(Key1, Key2, DefaultValue: string; FileName: string='config.ini'): String;
var
  ArqIni: TIniFile;
  FilePath: String;

begin
  FilePath := ExtractFilePath(ParamStr(0)) + FileName;

  Result := DefaultValue;

  try
    ArqIni := TIniFile.Create(FilePath);

    if FileExists(FilePath) then
      Result := ArqIni.ReadString(Key1, Key2, DefaultValue)

  finally
    FreeAndNil(ArqIni)

  end;
end;

function checkIniParams(FileName: string): Boolean;
var
  LPath: String;

begin
  Result := True;

  if not (FileExists(FileName)) then
    begin
      LPath := LPath + '\' + FileName;

      createFile(FileName);

      Result := False;
    end;
end;

procedure createIniParams(FileName: string);
begin
  {$IFDEF MYSQL}
  saveIni('BANCO', 'Port', '3306');
  saveIni('BANCO', 'Database', 'db_dados');
  saveIni('BANCO', 'Server', '127.0.0.1');
  saveIni('BANCO', 'User', 'root');
  saveIni('BANCO', 'Pass', '123456');
  {$ENDIF}

  {$IFDEF FIREBIRD}
  saveIni('BANCO', 'Port', '3350');
  saveIni('BANCO', 'Database', 'db_dados.fdb');
  saveIni('BANCO', 'Server', '127.0.0.1');
  saveIni('BANCO', 'User', 'SYSDBA');
  saveIni('BANCO', 'Pass', 'masterkey');
  {$ENDIF}
end;

function TrocaVirgulaPorPonto(Valor: String): String;
begin
  Result := Trim(StringReplace(Valor, ',', '.', [rfReplaceall]));
end;

function nextID(Connection: TFDConnection; Table, Field: string): integer;
var
  QryConsulta: TFDQuery;

begin
  Result := 1;

  Try
    Connection.Connected := False;
    Connection.Connected := True;

    QryConsulta := TFDQuery.Create(nil);
    QryConsulta.Connection := Connection;

    QryConsulta.Close;
    QryConsulta.SQL.Clear;
    QryConsulta.SQL.Add('select max(' + Field + ') as codigo from ' + Table);
    QryConsulta.Open;

    if QryConsulta.FieldByName('CODIGO').AsString <> '' then
      Result := QryConsulta.FieldByName('CODIGO').AsInteger + 1;

  finally
    FreeAndNil(QryConsulta);

  end;
end;

function GeraLOG(Log: String): String;
Var
  NomeLog: String;
  Arquivo: TextFile;

begin
  NomeLog := (ExtractFilePath(Application.ExeName) + 'Log.txt');
  AssignFile(Arquivo, NomeLog);

  if FileExists(NomeLog) then
    Append(Arquivo)
  else
    ReWrite(Arquivo);

  if Not FileExists(ExtractFilePath(Application.ExeName) + 'Log.txt') then
    FileCreate(ExtractFilePath(Application.ExeName) + 'Log.txt');

  try
    WriteLn(Arquivo, ('[' + FormatDateTime('dd/mm/yyyy', now) + ' - ' +
      FormatDateTime('hh:nn:ss', now) + '] - ' + Log));
  finally
    CloseFile(Arquivo);
  end;
end;

procedure createPath(var Path: String);
var
  LPath: String;

begin
  LPath := System.SysUtils.GetCurrentDir;
  Path := LPath + Path;

  ForceDirectories(Path);
end;

procedure createFile(var Path: String);
var
  LFile: TextFile;

begin
  if not (FileExists(Path)) then
    begin
      try
        AssignFile(LFile, Path);
        Rewrite(LFile)
      finally
        CloseFile(LFile)
      end;
    end;
end;

end.
