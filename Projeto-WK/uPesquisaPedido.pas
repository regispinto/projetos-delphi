unit uPesquisaPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfmPesquisaPedido = class(TForm)
    edtNumeroPedido: TEdit;
    lblCodigoDoCliente: TLabel;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure edtNumeroPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPesquisaPedido: TfmPesquisaPedido;

implementation

uses uPedidos;

{$R *.dfm}

procedure TfmPesquisaPedido.edtNumeroPedidoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (key = VK_RETURN) and (edtNumeroPedido.Text <> EmptyStr) then
    btnConfirmarClick(Sender);
end;

procedure TfmPesquisaPedido.edtNumeroPedidoKeyPress(Sender: TObject; var Key: Char);
begin
  if not( key in['0'..'9', #08] ) then
    key := #0;
end;

procedure TfmPesquisaPedido.btnConfirmarClick(Sender: TObject);
begin
  if edtNumeroPedido.Text <> EmptyStr then
    ModalResult := mrOk;
end;

procedure TfmPesquisaPedido.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = VK_ESCAPE then btnCancelar.Click;
end;

procedure TfmPesquisaPedido.btnCancelarClick(Sender: TObject);
begin
  Self.Close;

  ModalResult := mrCancel;
end;

end.
