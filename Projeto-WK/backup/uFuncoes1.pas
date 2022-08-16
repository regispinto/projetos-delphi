unit uFuncoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  FireDAC.Comp.Client, IniFiles;

  function TrocaVirgulaPorPonto(Valor: String): String;
  function ProximoID(Tabela, Campo: String): Integer;
  function GeraLOG(Log : String) : String;

implementation

uses uDM;

function TrocaVirgulaPorPonto(Valor: String): String;
begin
  Result := Trim(StringReplace(Valor,',','.',[rfReplaceall]));
end;

function ProximoID(Tabela, Campo: String): Integer;
var
  QryConsulta: TFDQuery;

begin
  Result := 1;

  Try
    Dm.Conection.Connected := False;
    Dm.Conection.Connected := True;

    QryConsulta := TFDQuery.Create(nil);
    QryConsulta.Connection := Dm.Conection;

    QryConsulta.Close;
    QryConsulta.SQL.Clear;
    QryConsulta.SQL.Add('select max(' + Campo + ') as codigo from ' + Tabela);
    QryConsulta.Open;

    if QryConsulta.FieldByName('CODIGO').AsString <> '' then
      Result := QryConsulta.FieldByName('CODIGO').AsInteger + 1;

  finally
    QryConsulta.Destroy;

  end;
end;

function GeraLOG(Log : String) : String;
Var
  NomeLog : String;
  Arquivo : TextFile;

begin
  NomeLog := (ExtractFilePath(Application.ExeName)+'Log.txt');
  AssignFile(Arquivo, NomeLog);

  if FileExists (NomeLog) then
    Append(Arquivo)
  else
    ReWrite(Arquivo);

  if Not FileExists (ExtractFilePath(Application.ExeName)+'Log.txt') then
    FileCreate(ExtractFilePath(Application.ExeName)+'Log.txt');

  try
    WriteLn(Arquivo,('['+ FormatDateTime('dd/mm/yyyy', now) + ' - ' + FormatDateTime('hh:nn:ss',now) + '] - ' + Log)); // Grava a informação que eu quero com data e hora
  finally
    CloseFile(Arquivo);
  end;
end;

end.
