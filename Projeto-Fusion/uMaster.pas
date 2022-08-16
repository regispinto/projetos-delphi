unit uMaster;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.ComCtrls, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.StdCtrls, Vcl.Buttons;

type
  TfMaster = class(TForm)
    dsLogs: TDataSource;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fMaster: TfMaster;

implementation

uses uDM;

{$R *.dfm}

procedure TfMaster.BitBtn1Click(Sender: TObject);
begin
  // fdQueryLogs.SQL.Clear;
  // fdQueryLogs.SQL.Add('select * from logdonwload');
  // fdQueryLogs.Open();
end;

procedure TfMaster.FormCreate(Sender: TObject);
begin
  //
end;

procedure TfMaster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Self.Close;
end;

end.
