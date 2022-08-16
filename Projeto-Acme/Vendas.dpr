program Vendas;

uses
  Vcl.Forms,
  SysUtils,
  Main in 'Main.pas' {fMain},
  CadCliente in 'CadCliente.pas' {fCadCliente},
  CadVenda in 'CadVenda.pas' {fCadVenda},
  InscricaoFiscal in 'InscricaoFiscal.pas',
  ListagemArquivos in 'ListagemArquivos.pas' {fListarArquivos},
  SplasScreen in 'SplasScreen.pas' {fSplash},
  uConexao in 'uConexao.pas',
  Vcl.Styles,
  CadUsuario in 'CadUsuario.pas' {fCadUsuario},
  Login in 'Login.pas' {fLogin},
  Windows,
  uDM in 'uDM.pas' {DM: TDataModule},
  uClassConnection in '..\ClassConnection\uClassConnection.pas',
  uFunctios in '..\GenericFunctions\uFunctios.pas';

{$R *.res}

var
  HprevHist: Thandle;

begin
  Application.Initialize;
  begin
    HprevHist := FindWindow(Nil, PChar('Corretora ACME'));
    if(HprevHist <> 0)then
    begin
      Application.MessageBox('Aplicativo já se encontra em execução','Atenção',MB_OK);
      ShowWindow(HprevHist, SW_NORMAL);
      Application.Terminate;
    end;
  end;

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := 'Corretora ACME';
  Application.CreateForm(TfSplash, fSplash);
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(TDM, DM);
  //if DM.FDConnection1.Connected then
  //begin
    fSplash.Show;
    fSplash.Refresh;
    Sleep (4000);
    fSplash.Free;
    fSplash := Nil;

    Application.Initialize;

    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TfLogin, fLogin);
    Application.CreateForm(TfMain, fMain);
    Application.CreateForm(TfListarArquivos, fListarArquivos);

    Application.Run;
  //end
end;

end.
