unit classeProdutos;

interface

uses
  System.SysUtils, FireDAC.Comp.Client;

  type
    TProdutos = Class
      private
        FConexao    : TFDConnection;
        FCodigo     : Integer;
        FDescricao  : String;
        FPrecoVenda : Double;

      public
        property Conexao    : TFDConnection read FConexao write FConexao;
        property Codigo     : Integer read FCodigo write FCodigo;
        property Descricao  : String read FDescricao write FDescricao;
        property PrecoVenda : Double read FPrecoVenda write FPrecoVenda;

        constructor Create( Conexao: TFDConnection );
        destructor Destroy; Override;

        function Incluir(var Erro: String): Boolean;
        procedure Excluir(Numero: Integer);
        function Consultar(Texto: String=''): TFDQuery;
    end;

var
  QrySQL: TFDQuery;

implementation

{ TProdutos }

constructor TProdutos.Create(Conexao: TFDConnection);
begin
  FConexao := Conexao;
  QrySQL := TFDQuery.Create(nil);
  QrySQL.Connection  := FConexao;
end;

destructor TProdutos.Destroy;
begin
  QrySQL.Destroy;

  inherited;
end;

function TProdutos.Incluir(var Erro: String): Boolean;
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
      QryInserir.SQL.Add('insert into produtos ');
      QryInserir.SQL.Add('(CodigoProduto, Descricao, PrecoVenda) ');
      QryInserir.SQL.Add('values ');
      QryInserir.SQL.Add('(:pCodigo, :pDescricao, :pPreco)');

      QryInserir.ParamByName('pCodigo').AsInteger   := FCodigo;
      QryInserir.ParamByName('pDescricao').AsString := FDescricao;
      QryInserir.ParamByName('pPreco').AsFloat      := FPrecoVenda;
      QryInserir.ExecSQL;

      Result := True;
    Except
      on e: Exception do begin
        Erro := E.Message;

        //GeraLOG('Erro no método incluir da classeProdutos - ' + Erro);

        Result := False;
      end;
    end;
  finally
    QryInserir.Destroy;
  end;
end;

procedure TProdutos.Excluir(Numero: Integer);
begin
  //-- #17
end;

function TProdutos.Consultar(Texto: String=''): TFDQuery;
begin
  try
    FConexao.Connected := False;
    FConexao.Connected := True;

    QrySQL.SQL.Clear;
    QrySQL.SQL.Add('Select CodigoProduto, Descricao, PrecoVenda from PRODUTOS p');

    if not Texto.IsEmpty then begin
      QrySQL.SQL.Add('where p.CodigoProduto = :pCodigo');
      QrySQL.ParamByName('pCodigo').AsString := Texto;
    end;

    QrySQL.Open;
  finally
    Result := QrySQL;
  end;
end;

end.
