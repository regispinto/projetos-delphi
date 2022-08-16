program Vendas;

uses
  Vcl.Forms,
  uDM in 'uDM.pas' {DM: TDataModule},
  uPedidos in 'uPedidos.pas' {fmPedidos},
  uConsultaClientes in 'uConsultaClientes.pas' {fmConsultaClientes},
  classePedidos in 'classePedidos.pas',
  classeClientes in 'classeClientes.pas',
  classeProdutos in 'classeProdutos.pas',
  uConsultaProdutos in 'uConsultaProdutos.pas' {fmConsultaProdutos},
  Windows,
  uPesquisaPedido in 'uPesquisaPedido.pas' {fmPesquisaPedido},
  uClassConnection in '..\ClassConnection\uClassConnection.pas',
  uFunctios in '..\GenericFunctions\uFunctios.pas';

{$R *.res}

var
  HprevHist: Thandle;

begin
  Application.Initialize;

  begin
    HprevHist := FindWindow(Nil, 'Pedidos de Vendas');

    if(HprevHist <> 0)then begin
      Application.MessageBox('Aplicativo já se encontra em execução', 'Atenção', MB_OK);
      ShowWindow(HprevHist, SW_NORMAL);
      Application.Terminate;
    end;
  end;

  //ReportMemoryLeaksOnShutdown := True;

  Application.Title := 'Pedidos de Vendas';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfmPedidos, fmPedidos);
  Application.Run;
end.



