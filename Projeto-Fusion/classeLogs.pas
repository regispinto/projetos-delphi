unit classeLogs;

interface

uses
  System.SysUtils, Vcl.Forms, FireDAC.Comp.Client, uFuncoes;

    TLogs = class
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
        function Consultar(Texto: String=''): TFDQuery;
    end;
var
  QryPedidosDadosGerais: TFDQuery;
  QryPedidosProdutos: TFDQuery;
  QryPedidoExistente: TFDQuery;

implementation

uses uDM;

{ TLogs }

constructor TLogs.Create(Conexao: TFDConnection);
begin
  FConexao                       := Conexao;
  QryPedidosProdutos             := TFDQuery.Create(nil);
  QryPedidosProdutos.Connection  := FConexao;
end;

destructor TLogs.Destroy;
begin
  QryPedidosProdutos.Destroy;

  inherited;
end;

function TLogs.Inserir(Erro: String): Boolean;
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

function TLogs.Consultar(Texto: String): TFDQuery;
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

end.
