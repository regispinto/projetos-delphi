unit uPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons,
  Vcl.StdCtrls,Vcl.ExtCtrls, Data.DB, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,
  FireDAC.Stan.Intf,

  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client,

  uFunctios;

type
  TfmPedidos = class(TForm)
    gbxCliente: TGroupBox;
    edtCodigoDoCliente: TEdit;
    lblCodigoDoCliente: TLabel;
    spbConsultaClientes: TSpeedButton;
    edtNomeDoCliente: TEdit;
    gbxProdutos: TGroupBox;
    lblCodigoDoProduto: TLabel;
    spbConsultaProdutos: TSpeedButton;
    edtCodigoDoProduto: TEdit;
    edtDescricaoDoProduto: TEdit;
    gbxItensDoPedido: TGroupBox;
    dbgItensDoPedido: TDBGrid;
    edtQuantidade: TEdit;
    lblDescricaoDoProduto: TLabel;
    lblNomeDoCliente: TLabel;
    lblVlrVenda: TLabel;
    lblQuantidade: TLabel;
    lblValorTotal: TLabel;
    Panel1: TPanel;
    btnGravar: TButton;
    btnCarregar: TButton;
    btnCancelar: TButton;
    btnRetornar: TButton;
    btnConfirmar: TButton;
    edtVlrVenda: TEdit;
    edtValorTotal: TEdit;
    fdmItensDoPedido: TFDMemTable;
    fdmItensDoPedidoCodigoProduto: TIntegerField;
    fdmItensDoPedidoDescricaoProduto: TStringField;
    fdmItensDoPedidoValorUnitario: TFloatField;
    fdmItensDoPedidoQuantidade: TIntegerField;
    fdmItensDoPedidoValorTotal: TFloatField;
    dtsItensDoPedido: TDataSource;
    stbTotal: TStatusBar;

    procedure FormCreate(Sender: TObject);
    procedure edtCodigoDoClienteChange(Sender: TObject);
    procedure btnRetornarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoDoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoDoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure spbConsultaClientesClick(Sender: TObject);
    procedure spbConsultaProdutosClick(Sender: TObject);
    procedure edtCodigoDoProdutoChange(Sender: TObject);
    procedure edtCodigoDoProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoDoProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQuantidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbgItensDoPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    procedure ApagaCamposGrupoProdutos;
    procedure InsereItenNoPedido(Codigo, Descricao, ValorVenda, Quantidade,
      ValorTotal: String);
    Function AtualizaTotalDoPedido: Double;
    procedure MostraTotalDoPedido;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmPedidos: TfmPedidos;
  iPedido: Integer;

implementation

uses uDM, uConsultaClientes, classeClientes, uConsultaProdutos, classeProdutos,
  classePedidos, uPesquisaPedido;

{$R *.dfm}

procedure TfmPedidos.FormCreate(Sender: TObject);
begin
  //Dm.PedidosDadosGerais := TPedidosDadosGerais.Create(Dm.Conection);
  //Dm.PedidosProdutos := TPedidosProdutos.Create(Dm.Conection);
  //Dm.Produto := TProdutos.Create(Dm.Conection);
  //Dm.Cliente := TClientes.Create(Dm.Conection);

  stbTotal.Visible := False;
  btnGravar.Visible := False;

  iPedido := 0;
end;

procedure TfmPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Dm.PedidosDadosGerais.Destroy;
  //Dm.PedidosProdutos.Destroy;
  //Dm.Cliente.Destroy;
  //Dm.Produto.Destroy;

  Action := caFree;
end;

procedure TfmPedidos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    btnRetornarClick(Sender)
end;

procedure TfmPedidos.edtCodigoDoClienteChange(Sender: TObject);
var
  bVisivel: Boolean;

begin
  bVisivel := edtCodigoDoCliente.Text = EmptyStr;

  btnCarregar.Visible := bVisivel;
  btnCancelar.Visible := bVisivel;

  if bVisivel then
  begin
    edtNomeDoCliente.Clear;
  end;
end;

procedure TfmPedidos.edtCodigoDoClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN) and (edtCodigoDoCliente.Text <> EmptyStr) then
  begin
    Dm.dtsGeneric.DataSet := Dm.Cliente.Consultar(edtCodigoDoCliente.Text);

    if Dm.dtsGeneric.DataSet.IsEmpty then
      edtNomeDoCliente.Text := 'Cliente informado não cadastrado'
    else
    begin
      edtNomeDoCliente.Text := Dm.dtsGeneric.DataSet.FieldByName
        ('NOME').AsString;

      perform(WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

procedure TfmPedidos.edtCodigoDoClienteKeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0' .. '9', #08]) then
  begin
    Key := #0;
  end;
end;

procedure TfmPedidos.edtCodigoDoProdutoChange(Sender: TObject);
begin
  if edtCodigoDoProduto.Text = EmptyStr then
    ApagaCamposGrupoProdutos;
end;

procedure TfmPedidos.ApagaCamposGrupoProdutos;
begin
  edtDescricaoDoProduto.Clear;
  edtValorTotal.Clear;
  edtVlrVenda.Clear;
  edtQuantidade.Clear;
  edtValorTotal.Clear;
end;

procedure TfmPedidos.edtCodigoDoProdutoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  sValorTotal: String;

begin
  if (Key = VK_RETURN) and (edtCodigoDoProduto.Text <> EmptyStr) then
  begin
    Dm.dtsGeneric.DataSet := Dm.Produto.Consultar(edtCodigoDoProduto.Text);

    if Dm.dtsGeneric.DataSet.IsEmpty then
      edtDescricaoDoProduto.Text := 'Produto informado não cadastrado'
    else
    begin
      edtDescricaoDoProduto.Text := Dm.dtsGeneric.DataSet.FieldByName
        ('DESCRICAO').AsString;
      fmPedidos.edtVlrVenda.Text :=
        CurrToStrF(Dm.dtsGeneric.DataSet.Fields[2].AsCurrency, ffFixed, 2);

      perform(WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

procedure TfmPedidos.edtCodigoDoProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  If not(Key in ['0'..'9', #08]) then
  begin
    Key := #0;
  end;
end;

procedure TfmPedidos.edtQuantidadeKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  fTotal: Double;

begin
  if (Key = VK_RETURN) and (edtQuantidade.Text <> EmptyStr) and
    (StrToInt(edtQuantidade.Text) > 0) then
  begin
    fTotal := StrToFloat(edtVlrVenda.Text) * StrToInt(edtQuantidade.Text);

    edtValorTotal.Text := FloatToStrF(fTotal, ffNumber, 4, 2);

    perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfmPedidos.edtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  if not(Key in ['0' .. '9', #08]) then
    Key := #0;
end;

procedure TfmPedidos.spbConsultaClientesClick(Sender: TObject);
begin
  try
    fmConsultaClientes := TfmConsultaClientes.Create(Self);
    fmConsultaClientes.ShowModal;

    if fmConsultaClientes.ModalResult = mrRetry then
      perform(WM_NEXTDLGCTL, 0, 0);

  finally
    fmConsultaClientes.Destroy;
  end;
end;

procedure TfmPedidos.spbConsultaProdutosClick(Sender: TObject);
begin
  try
    fmConsultaProdutos := TfmConsultaProdutos.Create(Self);
    fmConsultaProdutos.ShowModal;
  finally
    fmConsultaProdutos.Destroy;
  end;
end;

procedure TfmPedidos.btnConfirmarClick(Sender: TObject);
var
  sErro: String;

begin
  if (edtCodigoDoProduto.Text <> EmptyStr) and
    (edtDescricaoDoProduto.Text <> EmptyStr) and
    (edtQuantidade.Text <> EmptyStr) and (edtValorTotal.Text <> EmptyStr) then
  begin
    // InsereItenNoPedido(edtCodigoDoProduto.Text,
    // edtDescricaoDoProduto.Text,
    // edtVlrVenda.Text,
    // edtQuantidade.Text,
    // edtValorTotal.Text);
    //

    // -- [TESTE] ---------------------------
    if iPedido = 0 then
      iPedido := NextID(DM.FDConnection, 'PedidosDadosGerais', 'NumeroPedido');

    Dm.PedidosDadosGerais.NumeroPedido := iPedido;
    Dm.PedidosDadosGerais.CodigoCliente := StrToInt(edtCodigoDoCliente.Text);
    // dm.PedidosDadosGerais.ValorTotal    := AtualizaTotalDoPedido;

    if Dm.PedidosDadosGerais.Inserir(sErro) then
    begin
      Dm.PedidosProdutos.NumeroPedido  := iPedido;
      Dm.PedidosProdutos.CodigoProduto := StrToInt(edtCodigoDoProduto.Text);
      Dm.PedidosProdutos.Quantidade    := StrToInt(edtQuantidade.Text);
      Dm.PedidosProdutos.ValorUnitario := StrToFloat(edtVlrVenda.Text);
      Dm.PedidosProdutos.ValorTotal    := StrToFloat(edtVlrVenda.Text) * StrToInt(edtQuantidade.Text);

      if Dm.PedidosProdutos.Inserir(sErro) then
        dtsItensDoPedido.DataSet := Dm.PedidosProdutos.Consultar(IntToStr(iPedido))
      else
        Application.MessageBox('Falhar ao inserir item no pedido', 'Pedidos de Vendas',
          MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
    end;
    // -- [TESTE] ---------------------------

    //MostraTotalDoPedido;

    btnGravar.Visible := True;

    edtCodigoDoProduto.Clear;
    edtCodigoDoProduto.SetFocus;
  end
end;

procedure TfmPedidos.btnCarregarClick(Sender: TObject);
var
  sNumeroPedido: String;

begin
  try
    fmPesquisaPedido := TfmPesquisaPedido.Create(Self);
    fmPesquisaPedido.ShowModal;

    if fmPesquisaPedido.edtNumeroPedido.Text <> EmptyStr then
    begin
      sNumeroPedido := Trim(fmPesquisaPedido.edtNumeroPedido.Text);

      Dm.dtsGeneric.DataSet := Dm.PedidosDadosGerais.Consultar(sNumeroPedido);

      if Dm.dtsGeneric.DataSet.RecordCount > 0 then
      begin
        edtCodigoDoCliente.Text := Dm.dtsGeneric.DataSet.FieldByName
          ('CodigoCliente').AsString;
        edtNomeDoCliente.Text := Dm.dtsGeneric.DataSet.FieldByName
          ('Nome').AsString;

        // Carregar os itens do pedido
        Dm.dtsGeneric.DataSet := Dm.PedidosProdutos.Consultar(sNumeroPedido);

        if Dm.dtsGeneric.DataSet.RecordCount > 0 then
        begin

          // Insere os itens do produto do banco na tabela temporária
          Dm.dtsGeneric.DataSet.First;

          while not Dm.dtsGeneric.DataSet.Eof do
          begin
            InsereItenNoPedido(Dm.dtsGeneric.DataSet.FieldByName
              ('CodigoProduto').AsString,
              Dm.dtsGeneric.DataSet.FieldByName('Descricao').AsString,
              Dm.dtsGeneric.DataSet.FieldByName('ValorUnitario').AsString,
              Dm.dtsGeneric.DataSet.FieldByName('Quantidade').AsString,
              Dm.dtsGeneric.DataSet.FieldByName('ValorTotal').AsString);

            Dm.dtsGeneric.DataSet.Next;
          end;

          MostraTotalDoPedido;

          fdmItensDoPedido.First;
          dbgItensDoPedido.SetFocus;
        end
        else
        begin
          Application.MessageBox('Falhar ao carregar os itens do pedido',
            'Pedidos de Vendas', MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
        end;
      end
      else
      begin
        Application.MessageBox('Pedido informado não existe',
          'Pedidos de Vendas', MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
      end;
    end;
  finally
    fmPesquisaPedido.Destroy;
  end;
end;

procedure TfmPedidos.btnCancelarClick(Sender: TObject);
var
  iNumeroPedido: Integer;

begin
  try
    fmPesquisaPedido := TfmPesquisaPedido.Create(Self);
    fmPesquisaPedido.ShowModal;

    if fmPesquisaPedido.edtNumeroPedido.Text <> EmptyStr then
    begin
      if Application.MessageBox('Excluir o pedido?', 'Pedido de Vendas',
        MB_ICONWARNING + MB_YESNO + MB_SYSTEMMODAL) = mrYes then begin

        iNumeroPedido := StrToInt(fmPesquisaPedido.edtNumeroPedido.Text);

        Dm.PedidosProdutos.CancelaPedido(iNumeroPedido);
        Dm.PedidosDadosGerais.CancelaPedido(iNumeroPedido);
      end;
    end else begin
      Application.MessageBox('Pedido informado não existe', 'Pedidos de Vendas',
        MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL);
    end;
  finally
    fmPesquisaPedido.Destroy;
  end;
end;

procedure TfmPedidos.btnGravarClick(Sender: TObject);
var
  bInclusaoOK: Boolean;
  sErro: String;

begin
  bInclusaoOK := False;

  sErro := EmptyStr;

  if iPedido = 0 then
    iPedido := NextID(dm.FDConnection, 'PedidosDadosGerais', 'NumeroPedido');

  Dm.PedidosDadosGerais.NumeroPedido := iPedido;
  Dm.PedidosDadosGerais.CodigoCliente := StrToInt(edtCodigoDoCliente.Text);
  Dm.PedidosDadosGerais.ValorTotal := AtualizaTotalDoPedido;

  if Dm.PedidosDadosGerais.Inserir(sErro) then begin
    fdmItensDoPedido.First;
    while not fdmItensDoPedido.Eof do begin
      Dm.PedidosProdutos.NumeroPedido     := iPedido;
      Dm.PedidosProdutos.CodigoProduto    := fdmItensDoPedidoCodigoProduto.AsInteger;
      Dm.PedidosProdutos.Quantidade       := fdmItensDoPedidoQuantidade.AsInteger;
      Dm.PedidosProdutos.ValorUnitario    := fdmItensDoPedidoValorUnitario.AsFloat;
      Dm.PedidosProdutos.ValorTotal       := fdmItensDoPedidoValorUnitario.AsFloat * fdmItensDoPedidoQuantidade.AsInteger;

      bInclusaoOK := Dm.PedidosProdutos.Inserir(sErro);

      if not bInclusaoOK then
        Break;

      fdmItensDoPedido.Next;
    end;
  end;

  if not bInclusaoOK then
    Application.MessageBox(PChar('Erro ao tentar inserir o item' +#13+#13+ sErro), 'Pedidos de Vendas',
      MB_ICONWARNING + MB_OK + MB_SYSTEMMODAL)
  else begin
    // Re-inicia os campos e os objeto com valor default para próximos lançamentos
    fdmItensDoPedido.EmptyDataSet;
    fdmItensDoPedido.Close;

    stbTotal.Visible := False;
    btnGravar.Visible := False;

    edtCodigoDoCliente.Clear;
    edtCodigoDoCliente.SetFocus;
  end;
end;

procedure TfmPedidos.btnRetornarClick(Sender: TObject);
begin
  Self.Close
end;

procedure TfmPedidos.dbgItensDoPedidoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if not(dbgItensDoPedido.DataSource.DataSet.IsEmpty) then begin
    case Key of
      VK_RETURN:
        begin
          edtCodigoDoProduto.Text    := fdmItensDoPedidoCodigoProduto.AsString;
          edtDescricaoDoProduto.Text := fdmItensDoPedidoDescricaoProduto.AsString;
          edtVlrVenda.Text           := fdmItensDoPedidoValorUnitario.AsString;
          edtQuantidade.Text         := fdmItensDoPedidoQuantidade.AsString;
          edtValorTotal.Text         := fdmItensDoPedidoValorTotal.AsString;

          edtQuantidade.SetFocus;
        end;

      VK_DELETE:
        begin
          if Application.MessageBox('Excluir o item do pedido?', 'Pedidos de Vendas',
            MB_ICONWARNING + MB_YESNO + MB_SYSTEMMODAL) = mrYes then begin
            fdmItensDoPedido.Delete;

            MostraTotalDoPedido;
          end;
        end;
    end;

  end;
end;

procedure TfmPedidos.InsereItenNoPedido(Codigo, Descricao, ValorVenda, Quantidade, ValorTotal: String);
begin
  fdmItensDoPedido.Open;
  fdmItensDoPedido.Append;
  fdmItensDoPedidoCodigoProduto.AsString := Codigo;
  fdmItensDoPedidoDescricaoProduto.AsString := Descricao;
  fdmItensDoPedidoValorUnitario.AsString := ValorVenda;
  fdmItensDoPedidoQuantidade.AsString := Quantidade;
  fdmItensDoPedidoValorTotal.AsString := ValorTotal;
  fdmItensDoPedido.Post;
end;

procedure TfmPedidos.MostraTotalDoPedido;
begin
  stbTotal.Visible := True;

  stbTotal.Panels[1].Text := 'Total do Pedido: ' + FloatToStrF(AtualizaTotalDoPedido, ffNumber, 8, 2);
  stbTotal.Repaint;
end;

Function TfmPedidos.AtualizaTotalDoPedido: Double;
var
  fTotal: Double;

begin
  fTotal := 0;

  fdmItensDoPedido.First;
  while not fdmItensDoPedido.Eof do begin
    fTotal := fTotal + fdmItensDoPedidoValorTotal.AsFloat;

    fdmItensDoPedido.Next;
  end;
  fdmItensDoPedido.First;

  Result := fTotal;
end;

end.
