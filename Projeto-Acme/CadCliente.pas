unit CadCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Menus, Vcl.ComCtrls;

type
  TfCadCliente = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    btCancelar: TButton;
    btGravar: TButton;
    btIncluir: TButton;
    btEditar: TButton;
    btExcluir: TButton;
    FDQuery1: TFDQuery;
    FDQuery1ID_CLIENTE: TLargeintField;
    FDQuery1NOME: TStringField;
    FDQuery1NASCIMENTO: TDateField;
    FDQuery1TELEFONE: TStringField;
    FDQuery1EMAIL: TStringField;
    FDQuery1END_TIPO_LOGRADOURO: TStringField;
    FDQuery1END_NOME_LOGRADOURO: TStringField;
    FDQuery1END_NUMERO: TStringField;
    FDQuery1END_COMPLEMENTO: TStringField;
    FDQuery1END_BAIRRO: TStringField;
    FDQuery1END_CIDADE: TStringField;
    FDQuery1END_UF: TStringField;
    FDQuery1END_CEP: TStringField;
    FDQuery1PESSOA: TStringField;
    FDQuery1INSCRICAO_FISCAL: TStringField;
    btExporta: TButton;
    SaveDialog1: TSaveDialog;
    FDQuery1ID_USARIO: TLargeintField;
    FDQuery1NOME_1: TStringField;
    pnDados: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit12: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit14: TDBEdit;
    lbResponsavel: TLabel;
    sbRodape: TStatusBar;
    procedure btGravarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btIncluirClick(Sender: TObject);
    procedure btEditarClick(Sender: TObject);
    procedure btExcluirClick(Sender: TObject);
    procedure btCancelarClick(Sender: TObject);
    procedure DBEdit14Enter(Sender: TObject);
    procedure FDQuery1AfterScroll(DataSet: TDataSet);
    procedure FDQuery1AfterOpen(DataSet: TDataSet);
    procedure btExportaClick(Sender: TObject);
    procedure FDQuery1INSCRICAO_FISCALValidate(Sender: TField);
    procedure FDQuery1EMAILValidate(Sender: TField);

  private
    procedure SetaComponentesDoRodape;
    procedure FormataCampoInscricaoFiscal;
    procedure ExportarClientes;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCadCliente: TfCadCliente;

implementation

{$R *.dfm}

uses
  Main,
  System.RegularExpressions,
  InscricaoFiscal,
  uDM;

procedure TfCadCliente.FormCreate(Sender: TObject);
begin
  Self.FDQuery1.Open;

  // Bloqueia o acesso aos dados enquanto usuário não selecionar uma operação
  pnDados.Enabled := False;

  lbResponsavel.Caption := '';

  SetaComponentesDoRodape;
end;

procedure TfCadCliente.btIncluirClick(Sender: TObject);
begin
  Self.FDQuery1.Append;
  //Self.FDQuery1ID_CLIENTE.Value := dm.ProximoID('ID_CLIENTE');
  SetaComponentesDoRodape;
  DBEdit1.SetFocus;
end;

procedure TfCadCliente.DBEdit14Enter(Sender: TObject);
begin
  // Caso o usuário não tenha selecionado um tipo de pessoa, por default, será Pessoa Física
  if (Self.DataSource1.State = dsInsert) and (DBRadioGroup1.ItemIndex < 0) then
    FDQuery1PESSOA.AsString := 'F';

  FormataCampoInscricaoFiscal;
end;

procedure TfCadCliente.btEditarClick(Sender: TObject);
begin
  Self.FDQuery1.Edit;
  SetaComponentesDoRodape;
  DBEdit1.SetFocus;
end;

procedure TfCadCliente.btExcluirClick(Sender: TObject);
begin
  if MessageBox(Application.Handle,
                Pchar ('Excluir o cliente ' +#13+#13+ FDQuery1NOME.AsString),
                'Cadastro de Clientes', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
    Self.FDQuery1.Delete;
end;

procedure TfCadCliente.btExportaClick(Sender: TObject);
begin
  if MessageBox(Application.Handle,
                Pchar ('Exportar os dados para o formato CSV'),
                'Cadastro de Clientes', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
  begin
    SaveDialog1.InitialDir := ExtractFilePath(Application.ExeName);
    SaveDialog1.Execute;

    if SaveDialog1.FileName = EmptyStr then
      MessageBox(Application.Handle,
                 'Arquivo destino não foi informado',
                 'Cadastro de Clientes', MB_OK+MB_ICONINFORMATION)
    else
      ExportarClientes;
  end
end;

procedure TfCadCliente.btGravarClick(Sender: TObject);
begin
  //FDQuery1ID_USARIO.AsInteger := DadosUsuario.IdUsuario;

  Self.FDQuery1.Post;

  SetaComponentesDoRodape;
end;

procedure TfCadCliente.btCancelarClick(Sender: TObject);
begin
  //Self.FDQuery1ID_CLIENTE.Value := dm.ProximoID('ID_CLIENTE', -1);
  Self.FDQuery1.Cancel;
  SetaComponentesDoRodape;
end;

procedure TfCadCliente.FDQuery1EMAILValidate(Sender: TField);
var
  rRegex: TRegex;
  bRet  : Boolean;
begin
  bRet := rRegex.IsMatch(Sender.AsString, '^[^@]+@[^.]+\.com\.br');
  if not bRet then
    raise Exception.Create('e-Mail inválido!');
end;

procedure TfCadCliente.FDQuery1INSCRICAO_FISCALValidate(Sender: TField);
var
  oValidador: TInscricaoFiscal;
  DocumentoValido: string;
begin
  oValidador := nil;

  try
    if Self.FDQuery1.FieldByName('PESSOA').Value = 'F' then
      oValidador := TCPF.Create;

    if Self.FDQuery1.FieldByName('PESSOA').Value = 'J' then
      oValidador := TCNPJ.Create;

    if Assigned(oValidador) then
    begin
      DocumentoValido := oValidador.DocumentoValido(Sender.AsString);

      if (DocumentoValido <> EmptyStr) then
      begin
        MessageBox(Application.Handle,
                   PChar(DocumentoValido),
                   'Cadastro de Clientes', MB_OK+MB_ICONINFORMATION);

        DBEdit14.SetFocus;
      end;
    end;
  finally
    if Assigned(oValidador) then
      oValidador.Free;
  end;
end;

procedure TfCadCliente.FDQuery1AfterOpen(DataSet: TDataSet);
begin
  TStringField(Self.FDQuery1TELEFONE).EditMask := '\(00\)00000\.0000;0; ';
  Self.FDQuery1NASCIMENTO.EditMask := '00\/00\/0000;1; ';
  Self.FDQuery1END_CEP.EditMask := '00\.000\.000;0; ';
end;

procedure TfCadCliente.FDQuery1AfterScroll(DataSet: TDataSet);
begin
  FormataCampoInscricaoFiscal;

  if FDQuery1.RecordCount > 0 then
  begin
    sbRodape.Panels[1].Text := 'Registro ' + IntToStr(FDQuery1.RecNo) + ' de ' + IntToStr(FDQuery1.RecordCount);
    sbRodape.Repaint;

    lbResponsavel.Caption := 'Responsável pela inclusão: ' + FDQuery1NOME_1.AsString;
  end;
end;

procedure TfCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fMain.Panel3.Enabled := True;

  Self.FDQuery1.Close;

  lbResponsavel.Caption := '';
end;

procedure TfCadCliente.FormataCampoInscricaoFiscal;
begin
  if Self.FDQuery1PESSOA.AsString = 'J' then
    TStringField(Self.FDQuery1INSCRICAO_FISCAL).EditMask := '00\.000\.000\/0000\-00;0; '
  else begin
    TStringField(Self.FDQuery1INSCRICAO_FISCAL).EditMask := '000\.000\.000\-00;0; ';
  end;
end;

procedure TfCadCliente.SetaComponentesDoRodape;
begin
  case Self.DataSource1.State of
    dsInsert, dsEdit: begin
      fMain.Panel3.Enabled := False;

      DBNavigator1.Enabled := False;

      pnDados.Enabled := True;

      btIncluir.Enabled := False;
      btEditar.Enabled := False;
      btExcluir.Enabled := False;
      btExporta.Enabled := False;
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
      btExporta.Enabled := FDQuery1.RecordCount > 0;
      btGravar.Enabled := False;
      btCancelar.Enabled := False;
    end;
  end;
end;

procedure TfCadCliente.ExportarClientes;
var Arquivo: TextFile;
    nX, nY: SmallInt;
    Cabecalho: TStringLIst;
    LinhaDados: String;
begin
  FDQuery1.Close;
  FDQuery1.Open;

  Cabecalho := TStringList.Create;

  AssignFile(Arquivo, SaveDialog1.FileName);

  ReWrite(Arquivo);

  Cabecalho := FDQuery1.FieldList;

  nY := Cabecalho.Count-1;

  LinhaDados := '';

  For nX := 0 to nY do
  begin
    LinhaDados := LinhaDados + Cabecalho.Strings[nX] + ';';
  end;

  WriteLn(Arquivo, LinhaDados);

  nY := FDQuery1.FieldCount-1;

  while not FDQuery1.Eof do
  begin
    LinhaDados := '';

    For nX := 0 to nY do
    begin
      LinhaDados := LinhaDados + FDQuery1.FieldByName(Cabecalho.Strings[nX]).AsString + ';';
    end;

    WriteLn(Arquivo, LinhaDados);

    FDQuery1.Next;
  end;

  Cabecalho.Free;

  CloseFile(Arquivo);

  MessageBox(Application.Handle,
             'Arquivo gerado com sucesso',
             'Cadastro de Clientes', MB_OK+MB_ICONINFORMATION);
end;

end.
