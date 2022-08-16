unit Main;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions,
  Vcl.ActnList,
  System.ImageList,
  Vcl.ImgList,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  Data.DB,
  FireDAC.Comp.Client, Vcl.ComCtrls, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage;

type
  TfMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PanelWorkArea: TPanel;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActionCadCliente: TAction;
    ActionCadVenda: TAction;
    Button3: TButton;
    Button4: TButton;
    ActionListarArquivos: TAction;
    sbRodape: TStatusBar;
    ActionCadUsuario: TAction;
    Image1: TImage;
    Button5: TButton;
    ActionEncerraSistema: TAction;
    Timer1: TTimer;
    procedure ActionCadClienteExecute(Sender: TObject);
    procedure ActionListarArquivosExecute(Sender: TObject);
    procedure sbRodapeDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure FormShow(Sender: TObject);
    procedure ActionCadUsuarioExecute(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    FFormActive: TForm;
    procedure LoadForm(AClass: TFormClass);
  public
    { Public declarations }
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
  uDM, CadCliente, ListagemArquivos, CadUsuario;

procedure TfMain.ActionCadClienteExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadCliente);
end;

procedure TfMain.ActionListarArquivosExecute(Sender: TObject);
begin
  Self.LoadForm(TfListarArquivos);
end;


procedure TfMain.Button5Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfMain.ActionCadUsuarioExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadUsuario);
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  //sbRodape.Panels[0].Text := 'Usuário: [' + DadosUsuario.NomeUsuario + ']';
  //sbRodape.Repaint;
end;

procedure TfMain.LoadForm(AClass: TFormClass);
var
  slQuery: TStringList;
begin
  slQuery := TStringList.Create;

  if Assigned(Self.FFormActive) then
  begin
    Self.FFormActive.Close;
    Self.FFormActive.Free;
    Self.FFormActive := nil;
  end;

  Self.FFormActive             := AClass.Create(nil);
  Self.FFormActive.Parent      := Self.PanelWorkArea;
  Self.FFormActive.BorderStyle := TFormBorderStyle.bsNone;

  Self.FFormActive.Top   := 0;
  Self.FFormActive.Left  := 0;
  Self.FFormActive.Align := TAlign.alClient;

  Self.FFormActive.Show;

  slQuery.Free;
end;

procedure TfMain.sbRodapeDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
  if panel = StatusBar.Panels[1] then
  begin
      StatusBar.Canvas.Font.Color := clWindow;
      StatusBar.Canvas.Brush.Color := clTeal;
      StatusBar.Canvas.TextOut(Rect.Left,Rect.Top,Panel.Text);
  end;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  sbRodape.Panels[1].Text := DateTimeToStr(Now);
  sbRodape.Repaint;
end;

end.
