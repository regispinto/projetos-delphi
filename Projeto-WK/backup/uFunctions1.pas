unit uFunctions;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  FireDAC.Comp.Client, IniFiles;

type
  TDataLogin = record
    UserID: Integer;
    UserName: String;
  end;

  TFunction = class
  Public
    class function LoadIni(Key1, Key2: String; DefaultValue: String = ''): String; Static;
  end;

var
  DataLogin: TDataLogin;

implementation

uses uDM;

{ TFuncoes }

class function TFunction.LoadIni(Key1, Key2, DefaultValue: String): String;
var
  sFile: String;
  FileIni: TIniFile;
begin
  sFile := ExtractFilePath(ParamStr(0)) + 'Config.ini';
  Result := DefaultValue;

  try
    FileIni := TIniFile.Create(sFile);

    if FileExists(sFile) then
      Result := FileIni.ReadString(Key1, Key2, DefaultValue)
    else
      Application.MessageBox('Arquivo CONFIG.INI não localizado', 'Sistema', MB_ICONERROR + MB_OK + MB_SYSTEMMODAL);
  finally
    FreeAndNil(FileIni)
  end;
end;

end.
