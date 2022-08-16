unit uDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TDM = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink: TFDPhysFBDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    function ProximoID(Generator: String; Incremento: Integer=1): Integer;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses
  Vcl.Forms, uFuncoes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  try
    FDConnection1.Params.Clear;
    FDConnection1.Params.Values['DriverID']     := 'FB';
    FDConnection1.LoginPrompt                   := False;
    FDConnection1.Params.Values['Port']         := TFuncoes.LerIni('BANCO', 'Porta');
    FDConnection1.Params.Values['CharacterSet'] := 'win1252';
    FDConnection1.Params.Values['Database']     := TFuncoes.LerIni('BANCO', 'Database');
    FDConnection1.Params.Values['Server']       := TFuncoes.LerIni('BANCO', 'Server');
    FDConnection1.Params.Values['User_Name']    := TFuncoes.LerIni('BANCO', 'User');
    FDConnection1.Params.Values['Password']     := TFuncoes.LerIni('BANCO', 'Password');
    FDConnection1.Connected := True;
  except
    on E: Exception do
    begin
        raise Exception.CreateFmt('Erro ao tentar conectar ao banco de dados' +#13+#13+
                                  'Motivo = %s', [E.Message]);

    end;
  end;

end;

function TDM.ProximoID(Generator: String; Incremento: Integer=1): Integer;
begin
  FDQuery1.Close;
  FDQuery1.SQL.Clear;
  FDQuery1.SQL.Add('select gen_id(' + Generator + ', ' + IntToStr(Incremento) + ') as IdAtual from RDB$DATABASE');
  FDQuery1.Open;
  Result := FDQuery1.FieldByName('IdAtual').Value;
  FDQuery1.Close;
end;

end.
