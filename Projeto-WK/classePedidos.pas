unit classePedidos;

interface

uses
  System.SysUtils, Vcl.Forms, FireDAC.Comp.Client;

  type
    TPedidosDadosGerais = Class
      private
        FConexao       : TFDConnection;
        FNumeroPedido  : Integer;
        FDataEmissao   : TDateTime;
        FCodigoCliente : Integer;
        FValorTotal    : Double;

      public
        property Conexao       : TFDConnection read FConexao write FConexao;
        property NumeroPedido  : Integer read FNumeroPedido write FNumeroPedido;
        property DataEmissao   : TDateTime read FDataEmissao write FDataEmissao;
        property CodigoCliente : Integer read FCodigoCliente write FCodigoCliente;
        property ValorTotal    : Double read FValorTotal write FValorTotal;

        constructor Create( Conexao: TFDConnection );
        destructor Destroy; Override;

        function Inserir(Erro: String): Boolean;
        procedure CancelaPedido(Numero: Integer);
        function Consultar(Texto: String=''): TFDQuery;

    end;

    TPedidosProdutos = class
      private
        FConexao       : TFDConnection;
        FNumeroPedido  : Integer;
        FCodigoProduto : Integer;
        FQuantidade    : Integer;
        FValorUnitario : Double;
        FValorTotal    : Double;
      public
        property Conexao       : TFDConnection read FConexao write FConexao;
        property NumeroPedido  : Integer read FNumeroPedido write FNumeroPedido;
        property CodigoProduto : Integer read FCodigoProduto write FCodigoProduto;
        property Quantidade    : Integer read FQuantidade write FQuantidade;
        property ValorUnitario : Double read FValorUnitario write FValorUnitario;
        property ValorTotal    : Double read FValorTotal write FValorTotal;

        constructor Create( Conexao: TFDConnection );
        destructor Destroy; Override;

        function Inserir(Erro: String): Boolean;
        procedure CancelaPedido(Numero: Integer);
        function Consultar(Texto: String=''): TFDQuery;
    end;
var
  QryPedidosDadosGerais: TFDQuery;
  QryPedidosProdutos: TFDQuery;
  QryPedidoExistente: TFDQuery;

implementation

uses uDM;

{ TPedidosDadosGerais }

constructor TPedidosDadosGerais.Create(Conexao: TFDConnection);
begin
  FConexao                          := Conexao;
  QryPedidosDadosGerais             := TFDQuery.Create(nil);
  QryPedidosDadosGerais.Connection  := FConexao;
end;

destructor TPedidosDadosGerais.Destroy;
begin
  QryPedidosDadosGerais.Destroy;
  inherited;
end;

function TPedidosDadosGerais.Inserir(Erro: String): Boolean;
var
  QryInserir: TFDQuery;

begin
  try
    try
      FConexao.Connected := False;
      FConexao.Connected := True;

      QryInserir := TFDQuery.Create(nil);
      QryInserir.Connection := FConexao;

      QryInserir.Close;
      QryInserir.SQL.Clear;
      QryInserir.SQL.Add('insert into PedidosDadosGerais ');
      QryInserir.SQL.Add('(NumeroPedido, DataEmissao, CodigoCliente, ValorTotal) ');
      QryInserir.SQL.Add('values ');
      QryInserir.SQL.Add('(:pPedido, :pEmissao, :pCliente, :pTotal)');

      QryInserir.ParamByName('pPedido').AsInteger   := FNumeroPedido;
      QryInserir.ParamByName('pEmissao').AsDateTime := Now;
      QryInserir.ParamByName('pCliente').AsInteger  := FCodigoCliente;
      QryInserir.ParamByName('pTotal').AsFloat      := FValorTotal;
      QryInserir.ExecSQL;

      Result := True;
    Except
      on e: Exception do begin
        Erro := E.Message;
        Result := False;
      end;
    end;
  finally
    QryInserir.Destroy;
  end;
end;

function TPedidosDadosGerais.Consultar(Texto: String): TFDQuery;
begin
  try
    FConexao.Connected := False;
    FConexao.Connected := True;

    QryPedidosDadosGerais.Close;
    QryPedidosDadosGerais.SQL.Clear;
    QryPedidosDadosGerais.SQL.Add('SELECT pg.NumeroPedido, pg.DataEmissao, pg.CodigoCliente, cl.Nome, pg.ValorTotal');
    QryPedidosDadosGerais.SQL.Add('FROM PedidosDadosGerais pg');
    QryPedidosDadosGerais.SQL.Add('LEFT JOIN clientes cl ON pg.CodigoCliente = cl.CodigoCliente ');

    if not Texto.IsEmpty then begin
      QryPedidosDadosGerais.SQL.Add('where pg.NumeroPedido = :pNumero');
      QryPedidosDadosGerais.ParamByName('pNumero').AsString := Texto;
    end;

    //GeraLOG(QryPedidosDadosGerais.SQL.Text);

    QryPedidosDadosGerais.Open;
  finally
    Result := QryPedidosDadosGerais;
  end;
end;

procedure TPedidosDadosGerais.CancelaPedido(Numero: Integer);
begin
  try
    FConexao.Connected := False;
    FConexao.Connected := True;

    FConexao.ExecSQL('delete from pedidosdadosgerais where numeropedido = :pNumeroPedido', [Numero]);
  finally
    FConexao.Connected := False;
  end;
end;

{ TPedidosProdutos }

constructor TPedidosProdutos.Create(Conexao: TFDConnection);
begin
  FConexao                       := Conexao;
  QryPedidosProdutos             := TFDQuery.Create(nil);
  QryPedidosProdutos.Connection  := FConexao;
end;

destructor TPedidosProdutos.Destroy;
begin
  QryPedidosProdutos.Destroy;

  inherited;
end;

function TPedidosProdutos.Inserir(Erro: String): Boolean;
var
  QryInserir: TFDQuery;

begin
  try
    try
      FConexao.Connected := False;
      FConexao.Connected := True;

      QryInserir := TFDQuery.Create(nil);
      QryInserir.Connection := FConexao;

      QryInserir.Close;
      QryInserir.SQL.Clear;
      QryInserir.SQL.Add('insert into PedidosProdutos ');
      QryInserir.SQL.Add('(NumeroPedido, CodigoProduto, Quantidade, ValorUnitario, ValorTotal) ');
      QryInserir.SQL.Add('values ');
      QryInserir.SQL.Add('(:pPedido, :pProduto, :pQuantidade, :pUnitario, :pTotal)');

      QryInserir.ParamByName('pPedido').AsInteger     := FNumeroPedido;
      QryInserir.ParamByName('pProduto').AsInteger    := FCodigoProduto;
      QryInserir.ParamByName('pQuantidade').AsInteger := FQuantidade;
      QryInserir.ParamByName('pUnitario').AsFloat     := FValorUnitario;
      QryInserir.ParamByName('pTotal').AsFloat        := FValorTotal;
      QryInserir.ExecSQL;

      Result := True;
    Except
      on e: Exception do begin
        Erro := E.Message;
        Result := False;
      end;
    end;
  finally
    QryInserir.Destroy;
  end;
end;

function TPedidosProdutos.Consultar(Texto: String): TFDQuery;
begin
  try
    FConexao.Connected := False;
    FConexao.Connected := True;

    QryPedidosProdutos.SQL.Clear;
    QryPedidosProdutos.SQL.Add('SELECT pp.NumeroPedido, pp.CodigoProduto, pr.Descricao, pp.ValorUnitario, pp.Quantidade, pp.ValorTotal ');
    QryPedidosProdutos.SQL.Add('FROM pedidosprodutos pp ');
    QryPedidosProdutos.SQL.Add('left join produtos pr on pp.CodigoProduto = pr.CodigoProduto ');

    if not Texto.IsEmpty then begin
      QryPedidosProdutos.SQL.Add('where pp.NumeroPedido = :pNumero');
      QryPedidosProdutos.ParamByName('pNumero').AsString := Texto;
    end;

    QryPedidosProdutos.Open;
  finally
    Result := QryPedidosProdutos;
  end;
end;

procedure TPedidosProdutos.CancelaPedido(Numero: Integer);
begin
  try
    FConexao.Connected := False;
    FConexao.Connected := True;

    FConexao.ExecSQL('delete from pedidosprodutos where numeropedido = :pNumeroPedido', [Numero]);
  finally
    FConexao.Connected := False;
  end;
end;

end.
