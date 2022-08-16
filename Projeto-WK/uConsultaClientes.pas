unit uConsultaClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, classeClientes, Vcl.ComCtrls;

type
  TfmConsultaClientes = class(TForm)
    dbgConsulta: TDBGrid;
    stbConsultaClientes: TStatusBar;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgConsultaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmConsultaClientes: TfmConsultaClientes;

implementation

uses uDM, uPedidos;

{$R *.dfm}

procedure TfmConsultaClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.Cliente.Destroy;
  Action := caFree;
end;

procedure TfmConsultaClientes.FormCreate(Sender: TObject);
begin
  //Dm.Cliente := TClientes.Create(Dm.Conection);
end;

procedure TfmConsultaClientes.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then Self.Close
end;

procedure TfmConsultaClientes.FormShow(Sender: TObject);
begin
  //DM.dtsGeneric.DataSet := dm.Cliente.Consultar('');
end;

procedure TfmConsultaClientes.dbgConsultaDblClick(Sender: TObject);
begin
  fmPedidos.edtCodigoDoCliente.Text := dbgConsulta.Fields[0].AsString;
  fmPedidos.edtNomeDoCliente.Text   := dbgConsulta.Fields[1].AsString;

  fmPedidos.ModalResult := mrRetry;

  Self.Close;
end;

end.
