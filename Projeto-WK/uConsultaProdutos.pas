unit uConsultaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, classeProdutos, Vcl.ComCtrls;

type
  TfmConsultaProdutos = class(TForm)
    dbgConsulta: TDBGrid;
    stbConsultaProdutos: TStatusBar;
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
  fmConsultaProdutos: TfmConsultaProdutos;

implementation

uses uDM, uPedidos;

{$R *.dfm}

procedure TfmConsultaProdutos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.Produto.Destroy;
  Action := caFree;
end;

procedure TfmConsultaProdutos.FormCreate(Sender: TObject);
begin
  //Dm.Produto := TProdutos.Create(Dm.Conexao);
end;

procedure TfmConsultaProdutos.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then Self.Close;
end;

procedure TfmConsultaProdutos.FormShow(Sender: TObject);
begin
  //DM.dtsGeneric.DataSet := dm.Produto.Consultar('');
end;

procedure TfmConsultaProdutos.dbgConsultaDblClick(Sender: TObject);
begin
  fmPedidos.edtCodigoDoProduto.Text     := dbgConsulta.Fields[0].AsString;
  fmPedidos.edtDescricaoDoProduto.Text  := dbgConsulta.Fields[1].AsString;
  //fmPedidos.edtVlrVenda.Text            := CurrToStrF(Dm.dtsGeneric.DataSet.Fields[2].AsCurrency, ffNumber, 2);

  Self.Close;
end;

end.
