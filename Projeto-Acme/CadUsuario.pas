unit CadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TfCadUsuario = class(TForm)
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDQuery1ID_USUARIO: TLargeintField;
    FDQuery1NOME: TStringField;
    FDQuery1LOGIN: TStringField;
    FDQuery1SENHA: TStringField;
    FDQuery1ATIVO: TStringField;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    btCancelar: TButton;
    btGravar: TButton;
    btIncluir: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    pnDados: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    rgStatus: TDBRadioGroup;
    sbRodape: TStatusBar;
    procedure btIncluirClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btGravarClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FDQuery1AfterScroll(DataSet: TDataSet);
  private
    procedure SetaComponentesDoRodape;
    function ValidaCampos: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCadUsuario: TfCadUsuario;

implementation

{$R *.dfm}

uses
  Main, uDM;

procedure TfCadUsuario.FDQuery1AfterScroll(DataSet: TDataSet);
begin
  sbRodape.Panels[1].Text := 'Registro ' + IntToStr(FDQuery1.RecNo) + ' de ' + IntToStr(FDQuery1.RecordCount);
  sbRodape.Repaint;
end;

procedure TfCadUsuario.FormCreate(Sender: TObject);
begin
  Self.FDQuery1.Open;

  // Bloqueia o acesso aos dados enquanto usuário não selecionar uma operação
  pnDados.Enabled := False;
end;

procedure TfCadUsuario.btIncluirClick(Sender: TObject);
begin
  Self.FDQuery1.Append;
  //Self.FDQuery1ID_USUARIO.Value := dm.ProximoID('ID_USUARIO');
  SetaComponentesDoRodape;
  DBEdit2.SetFocus;
end;

procedure TfCadUsuario.btEditarClick(Sender: TObject);
begin
  Self.FDQuery1.Edit;
  SetaComponentesDoRodape;
  DBEdit1.SetFocus;
end;

procedure TfCadUsuario.btExcluirClick(Sender: TObject);
begin
  if MessageBox(Application.Handle,
                Pchar ('Excluir o usuário ' +#13+#13+ FDQuery1NOME.AsString),
                'Cadastro de Usuários', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
    Self.FDQuery1.Delete;
end;

procedure TfCadUsuario.btGravarClick(Sender: TObject);
begin
  if ValidaCampos then
  begin
    Self.FDQuery1.Post;

    SetaComponentesDoRodape;
  end;
end;

procedure TfCadUsuario.btCancelarClick(Sender: TObject);
begin
  //Self.FDQuery1ID_USUARIO.Value := dm.ProximoID('ID_USUARIO', -1);
  Self.FDQuery1.Cancel;
  SetaComponentesDoRodape;
end;

function TfCadUsuario.ValidaCampos: Boolean;
Var
  campo: TDBEdit;
  mensagem: string;

begin
  if FDQuery1NOME.IsNull then
  begin
    campo := DBEdit2;
    mensagem := 'Campo nome obrigatório';
    Result := False;

  end else if FDQuery1LOGIN.IsNull then
  begin
    campo := DBEdit3;
    mensagem := 'Campo login obrigatório';
    Result := False;
  end else if FDQuery1SENHA.IsNull then
  begin
    campo := DBEdit4;
    mensagem := 'Campo senha obrigatório';
    Result := False;
  end;

  if NOT Result then
  begin
    MessageBox(Application.Handle, Pchar (Mensagem), 'Cadastro de Usuários', MB_OK);
    campo.SetFocus
  end;
end;

procedure TfCadUsuario.SetaComponentesDoRodape;
begin
  case Self.DataSource1.State of
    dsInsert, dsEdit: begin
      fMain.Panel3.Enabled := False;

      DBNavigator1.Enabled := False;

      pnDados.Enabled := True;

      btIncluir.Enabled := False;
      btEditar.Enabled := False;
      btExcluir.Enabled := False;
      btGravar.Enabled := True;
      btCancelar.Enabled := True;
    end;
    dsBrowse: begin
      fMain.Panel3.Enabled := True;

      DBNavigator1.Enabled := True;

      pnDados.Enabled := False;

      btIncluir.Enabled := True;
      btEditar.Enabled := FDQuery1.RecordCount > 0;
      btExcluir.Enabled := FDQuery1.RecordCount > 0;
      btGravar.Enabled := False;
      btCancelar.Enabled := False;
    end;
  end;
end;


end.
