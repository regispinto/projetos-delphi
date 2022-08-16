unit uFuncoes;

interface

type

  TDadosUsuario = record
    IdUsuario:Integer;
    NomeUsuario:string;
  end;

  TFuncoes = class
  Public
    class function LerIni(Chave1, Chave2: String; ValorPadrao: String = ''): String; static;
  end;

var
  DadosUsuario: TDadosUsuario;

implementation

uses Dialogs, IniFiles, System.SysUtils;

{ TFuncoes }

class function TFuncoes.LerIni(Chave1, Chave2, ValorPadrao: String): String;
var
  Arquivo: String;
  FileIni: TIniFile;
begin
  Arquivo := ExtractFilePath(ParamStr(0)) + 'config.ini';
  result := ValorPadrao;

  try
    FileIni := TIniFile.Create(Arquivo);

    if FileExists(Arquivo) then
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;
end;

end.
