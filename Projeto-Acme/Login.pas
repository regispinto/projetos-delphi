unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Buttons;

type
  TfLogin = class(TForm)
    Panel1: TPanel;
    FDQuery1: TFDQuery;
    FDQuery1ID_USUARIO: TLargeintField;
    FDQuery1NOME: TStringField;
    FDQuery1LOGIN: TStringField;
    FDQuery1SENHA: TStringField;
    FDQuery1ATIVO: TStringField;
    Label1: TLabel;
    edUsuario: TEdit;
    edSenha: TEdit;
    Button2: TButton;
    Button1: TButton;
    SpeedButton1: TSpeedButton;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure edSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure Button1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2KeyPress(Sender: TObject; var Key: Char);
  private
    procedure ProximoCampo(Sender: TObject; var Key: Char);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogin: TfLogin;

implementation

{$R *.dfm}

uses Main;

procedure TfLogin.Button1Click(Sender: TObject);
Var
  fPrincipal: TfMain;

begin
  if (edUsuario.Text <> EmptyStr) and (edSenha.Text <> EmptyStr) then
  begin
    FDQuery1.Close;
    FDQuery1.SQL.Clear;
    FDQuery1.SQL.Add('SELECT * FROM USUARIOS u');
    FDQuery1.SQL.Add('Where u.LOGIN = ' + QuotedStr(edUsuario.Text) + ' and ');
    FDQuery1.SQL.Add('u.SENHA = ' + QuotedStr(edSenha.Text));
    FDQuery1.Open;

    if FDQuery1.RecNo = 0 then begin
      MessageBox(Application.Handle,
                 'Usuário/senha não cadastrado',
                 'Login de Acesso', MB_OK+MB_ICONINFORMATION);
    end else begin
      try
        //DadosUsuario.IdUsuario := FDQuery1ID_USUARIO.AsInteger;
        //DadosUsuario.NomeUsuario := FDQuery1LOGIN.AsString;

        fPrincipal := TfMain.Create(Self);
        fPrincipal.ShowModal;
      finally
        Application.Terminate
      end;
    end
  end else begin
    MessageBox(Application.Handle,
               'Informe usuário/senha para acesso ao sistema',
               'Login de Acesso', MB_OK+MB_ICONINFORMATION);

    edUsuario.SetFocus;
  end;
end;

procedure TfLogin.edUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  ProximoCampo(Sender, Key);
end;

procedure TfLogin.edSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  ProximoCampo(Sender, Key);
end;

procedure TfLogin.Button1KeyPress(Sender: TObject; var Key: Char);
begin
  ProximoCampo(Sender, Key);
end;

procedure TfLogin.Button2KeyPress(Sender: TObject; var Key: Char);
begin
  ProximoCampo(Sender, Key);
end;

procedure TfLogin.Button2Click(Sender: TObject);
begin
  Application.Terminate
end;

procedure TfLogin.SpeedButton1Click(Sender: TObject);
begin
  if edSenha.Tag = 0 then
  begin
    edSenha.PasswordChar := #0;
    edSenha.Tag := 1
  end else
  begin
    edSenha.PasswordChar := #42;
    edSenha.Tag := 0;
  end;
end;

procedure TfLogin.ProximoCampo(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  Begin
    Key:= #0;
    Perform(Wm_NextDlgCtl,0,0);
  end;
end;

end.
