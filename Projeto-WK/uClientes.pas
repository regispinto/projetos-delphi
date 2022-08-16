unit uClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, classeClientes;

type
  TfmConsultaClientes = class(TForm)
    pnlPesquisa: TPanel;
    dbgClientes: TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConsultaClientes: TfmConsultaClientes;

implementation

uses uDM;

{$R *.dfm}

procedure TfmConsultaClientes.FormCreate(Sender: TObject);
begin
  Dm.Cliente := TClientes.Create(Dm.Conection);
end;

procedure TfmConsultaClientes.FormShow(Sender: TObject);
begin
  DM.dtsGeneric.DataSet := dm.Cliente.Consulta('');
end;

procedure TfmConsultaClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.Cliente.Destroy;
  Action := caFree;
end;

end.
