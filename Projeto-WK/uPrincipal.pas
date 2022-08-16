unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TfPrincipal = class(TForm)
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPrincipal: TfPrincipal;

implementation

uses uDM;

{$R *.dfm}

procedure TfPrincipal.FormShow(Sender: TObject);
begin
  DM.dtsGeneric.DataSet := DM.qryListData;

  DM.qryListData.Connection := DM.Conection;
  DM.qryListData.Active := True
end;

end.
