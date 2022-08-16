unit uDM;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes, Vcl.Forms, Vcl.Dialogs,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS,FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Stan.Intf, FireDAC.Comp.Client, FireDAC.Comp.UI, StrUtils,
  ClassePedidos, ClasseClientes, ClasseProdutos;

type
  TDM = class(TDataModule)
    qryListData: TFDQuery;
    dtsGeneric: TDataSource;
    fdcInsereProdutos: TFDCommand;
    fdcInsereClientes: TFDCommand;

    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure ConectaBD;
    function ExisteTabela(Tabela: String): Boolean;
    function CriaTabelaClientes: Boolean;
    function CriaTabelaProdutos: Boolean;
    function CriaTabelaPedidosDG: Boolean;
    function CriaTabelaPedidosPR: Boolean;
    function PopulaClientes: Boolean;
    function PopulaProdutos: Boolean;

    { Private declarations }
  public
    { Public declarations }
    Conection : TFDConnection;
    PedidosDadosGerais : TPedidosDadosGerais;
    PedidosProdutos: TPedidosProdutos;
    Cliente : TClientes;
    Produto : TProdutos;
  end;

var
  DriverMySQL: TFDPhysMySQLDriverLink;
  Cursor : TFDGUIxWaitCursor;
  Conection : TFDConnection;
  sDatabaseName : String;
  QrySQL : TFDQuery;
  DM : TDM;

implementation

uses uFuncoes, uFunctions;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Conection := TFDConnection.Create(nil);
  Cursor := TFDGUIxWaitCursor.Create(nil);

  DriverMySQL := TFDPhysMySQLDriverLink.Create(nil);
  DriverMySQL.VendorLib := ExtractFilePath(Application.ExeName) + 'libmysql.dll';

  QrySQL := TFDQuery.Create(nil);

  ConectaBD;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  Conection.Destroy;
  Cursor.Destroy;
  DriverMySQL.Destroy;
  QrySQL.Destroy;
end;

procedure TDM.ConectaBD;
var
  lExiste: Boolean;
  sErro: String;

begin
  Conection.LoginPrompt := False;
  Conection.Params.Clear;
  Conection.Params.Values['DriverID']  := TFunction.LoadIni('BANCO', 'Driver');
  Conection.Params.Values['Port']      := TFunction.LoadIni('BANCO', 'Port');
  Conection.Params.Values['Server']    := TFunction.LoadIni('BANCO', 'Server');
  Conection.Params.Values['User_Name'] := TFunction.LoadIni('BANCO', 'UserName');
  Conection.Params.Values['Password']  := TFunction.LoadIni('BANCO', 'Password');

  sDatabaseName := TFunction.LoadIni('BANCO', 'DataBase');

  // Testando a conexão
  try
    Conection.Connected := True;
  except
    on e:Exception do
      begin
        GeraLOG('Erro ao conectar com o servidor de banco de dados - ' + e.ToString);

        Exit;
      end;
  end;

  // Testar se existe o database
  lExiste := True;

  try
    Conection.Connected := False;
    Conection.Params.Values['Database'] := sDatabaseName;
    Conection.Connected := True;
  except
    lExiste := False;
  end;

  // Criando o Database
  if not lExiste then begin
    Conection.Connected := False;
    Conection.Params.Values['Database'] := '';
    Conection.Connected := True;

    try
      QrySQL.Close;
      QrySQL.Connection := Conection;
      QrySQL.SQL.Clear;
      QrySQL.SQL.Add('create database ' + sDatabaseName);
      QrySQL.SQL.Add(' character set utf8');
      QrySQL.SQL.Add(' collate = utf8_bin');
      QrySQL.Prepare;
      QrySQL.ExecSQL;

      GeraLOG('Database ' + UpperCase(sDatabaseName) + ' criado com sucesso');
    except
      on e:Exception do
        begin
          GeraLOG('Erro ao criar o database ' + sDatabaseName + ' - ' + e.ToString);

          Exit;
        end;
    end;

    if not ExisteTabela('clientes') then
      if CriaTabelaClientes then
        PopulaClientes;

    if not ExisteTabela('produtos') then
      if CriaTabelaProdutos then
        PopulaProdutos;

    if not ExisteTabela('pedidosdadosgerais') then
       CriaTabelaPedidosDG;

    if not ExisteTabela('pedidosprodutos') then
      CriaTabelaPedidosPR;
  end;
end;

Function TDM.ExisteTabela(Tabela: String): Boolean;
begin
  try
    Conection.Connected := False;
    Conection.Params.Values['Database'] := sDatabaseName;
    Conection.Connected := True;

    Result := True;

    QrySQL.Close;
    QrySQL.SQL.Clear;
    QrySQL.SQL.Add('SELECT * FROM ' + Tabela);

    GeraLOG('Consulta tabela ' + UpperCase(Tabela) +#13+ QrySQL.SQL.Text);

    QrySQL.Open;
  except
    on e:Exception do
      begin
        GeraLOG('Erro ao consultar ' + UpperCase(tabela) + ' - ' + e.ToString);

        Result := False;
      end;
  end;
end;

Function TDM.CriaTabelaClientes: Boolean;
begin
  try
    Conection.Connected := False;
    Conection.Params.Values['Database'] := sDatabaseName;
    Conection.Connected := True;

    Result := True;

    QrySQL.Close;
    QrySQL.SQL.Clear;
    QrySQL.SQL.Add('CREATE TABLE clientes (');
    QrySQL.SQL.Add('CodigoCliente int(8) primary key auto_increment, ');
    QrySQL.SQL.Add('Nome varchar(30) not null, ');
    QrySQL.SQL.Add('Cidade varchar (20) not null, ');
    QrySQL.SQL.Add('UF char(2) not null) ');
    QrySQL.SQL.Add('auto_increment = 1, ');
    QrySQL.SQL.Add('default charset = utf8');

    GeraLOG(QrySQL.SQL.Text);

    QrySQL.Prepare;
    QrySQL.ExecSQL;

    GeraLOG('Tabela CLIENTES criada com sucesso');
  except
    on e:Exception do
      begin
        GeraLOG('Erro ao criar CLIENTES - ' + e.ToString);
        Result := False;
      end;
  end;
end;

Function TDM.PopulaClientes: Boolean;
Var
  sErro: String;
  x: Integer;

begin
  try
    Cliente := TClientes.Create(Dm.Conection);

    for x := 1 to 20 do begin
      Cliente.Codigo  := x;
      Cliente.Nome    := 'CLIENTE ' + IntToStr(x);
      Cliente.Cidade  := 'PORTO ALEGRE';
      Cliente.UF      := 'RS';

      if not Cliente.Incluir(sErro) then begin
        Application.MessageBox(PChar('Erro ao tentar inserir o cliente ' + IntToStr(x) +#13+#13 + sErro),
                               'Cadastro de Clientes', MB_ICONWARNING + MB_OK+MB_SYSTEMMODAL);
        break;
      end;
    end;
  finally
    Cliente.Destroy;

  end;
end;

Function TDM.CriaTabelaProdutos: Boolean;
begin
  try
    Conection.Connected := False;
    Conection.Params.Values['Database'] := sDatabaseName;
    Conection.Connected := True;

    Result := True;

    QrySQL.Close;
    QrySQL.SQL.Clear;
    QrySQL.SQL.Add('CREATE TABLE produtos (');
    QrySQL.SQL.Add('CodigoProduto int(8) primary key auto_increment, ');
    QrySQL.SQL.Add('Descricao varchar(45) not null, ');
    QrySQL.SQL.Add('PrecoVenda double not null) ');
    QrySQL.SQL.Add('auto_increment = 1, ');
    QrySQL.SQL.Add('default charset = utf8');

    GeraLOG(QrySQL.SQL.Text);

    QrySQL.Prepare;
    QrySQL.ExecSQL;

    GeraLOG('Tabela PRODUTOS criada com sucesso');
  except
    on e:Exception do
      begin
        GeraLOG('Erro ao criar a tabela PRODUTOS - ' + e.ToString);

        Result := False;
      end;
  end;
end;

Function TDM.PopulaProdutos: Boolean;
Var
  sErro: String;
  x: Integer;

begin
  try
    Produto := TProdutos.Create(Dm.Conection);

    for x := 1 to 20 do begin
      Produto.Codigo     := x;
      Produto.Descricao  := 'PRODUTO ' + IntToStr(x);
      Produto.PrecoVenda := 10.00;

      if not Produto.Incluir(sErro) then begin
        Application.MessageBox(PChar('Erro ao tentar inserir o produto ' + IntToStr(x) +#13+#13 + sErro),
                               'Cadastro de Produtos', MB_ICONWARNING + MB_OK+MB_SYSTEMMODAL);
        break;
      end;
    end;
  finally
    Produto.Destroy;

  end;
end;

Function TDM.CriaTabelaPedidosDG: Boolean;
begin
  try
    Conection.Connected := False;
    Conection.Params.Values['Database'] := sDatabaseName;
    Conection.Connected := True;

    Result := True;

    QrySQL.Close;
    QrySQL.SQL.Clear;
    QrySQL.SQL.Add('CREATE TABLE pedidosdadosgerais (');
    QrySQL.SQL.Add('NumeroPedido int(11) primary key auto_increment, ');
    QrySQL.SQL.Add('DataEmissao datetime not null, ');
    QrySQL.SQL.Add('CodigoCliente int(8) not null, ');
    QrySQL.SQL.Add('ValorTotal double not null) ');
    QrySQL.SQL.Add('auto_increment = 1, ');
    QrySQL.SQL.Add('default charset = utf8; ');

    QrySQL.SQL.Add('ALTER TABLE pedidosdadosgerais ');
    QrySQL.SQL.Add('ADD INDEX fk_cliente_idx (CodigoCliente ASC); ');
    QrySQL.SQL.Add('ALTER TABLE pedidosdadosgerais ');
    QrySQL.SQL.Add('ADD CONSTRAINT fk_cliente ');
    QrySQL.SQL.Add('FOREIGN KEY (CodigoCliente) ');
    QrySQL.SQL.Add('REFERENCES clientes (CodigoCliente) ');
    QrySQL.SQL.Add('ON DELETE NO ACTION ');
    QrySQL.SQL.Add('ON UPDATE NO ACTION; ');

    GeraLOG(QrySQL.SQL.Text);

    QrySQL.Prepare;
    QrySQL.ExecSQL;

    GeraLOG('Tabela PEDIDOSDADOSGERAIS criada com sucesso');
  except
    on e:Exception do
      begin
        GeraLOG('Erro ao criar a tabela PEDIDOSDADOSGERAIS - ' + e.ToString);

        Result := False;
      end;
  end;
end;

Function TDM.CriaTabelaPedidosPR: Boolean;
begin
  try
    Conection.Connected := False;
    Conection.Params.Values['Database'] := sDatabaseName;
    Conection.Connected := True;

    Result := True;

    QrySQL.Close;
    QrySQL.SQL.Clear;
    QrySQL.SQL.Add('CREATE TABLE pedidosprodutos (');
    QrySQL.SQL.Add('Id int(11) primary key auto_increment, ');
    QrySQL.SQL.Add('NumeroPedido int(11) not null, ');
    QrySQL.SQL.Add('CodigoProduto int(8) not null, ');
    QrySQL.SQL.Add('Quantidade int(5) not null, ');
    QrySQL.SQL.Add('ValorUnitario double not null, ');
    QrySQL.SQL.Add('ValorTotal double not null) ');
    QrySQL.SQL.Add('auto_increment = 1, ');
    QrySQL.SQL.Add('default charset = utf8; ');

    QrySQL.SQL.Add('ALTER TABLE pedidosprodutos ');
    QrySQL.SQL.Add('ADD INDEX fk_pedido_idx (NumeroPedido ASC); ');
    QrySQL.SQL.Add('ALTER TABLE pedidosprodutos ');
    QrySQL.SQL.Add('ADD CONSTRAINT fk_pedido ');
    QrySQL.SQL.Add('FOREIGN KEY (NumeroPedido) ');
    QrySQL.SQL.Add('REFERENCES pedidosdadosgerais (NumeroPedido) ');
    QrySQL.SQL.Add('ON DELETE NO ACTION ');
    QrySQL.SQL.Add('ON UPDATE NO ACTION; ');

    QrySQL.SQL.Add('ALTER TABLE pedidosprodutos ');
    QrySQL.SQL.Add('ADD INDEX fk_produto_idx (CodigoProduto ASC); ');
    QrySQL.SQL.Add('ALTER TABLE pedidosprodutos ');
    QrySQL.SQL.Add('ADD CONSTRAINT fk_produto ');
    QrySQL.SQL.Add('FOREIGN KEY (CodigoProduto) ');
    QrySQL.SQL.Add('REFERENCES produtos (CodigoProduto) ');
    QrySQL.SQL.Add('ON DELETE NO ACTION ');
    QrySQL.SQL.Add('ON UPDATE NO ACTION; ');

    GeraLOG(QrySQL.SQL.Text);

    QrySQL.Prepare;
    QrySQL.ExecSQL;

    GeraLOG('Tabela PEDIDOSPRODUTOS criada com sucesso');
  except
    on e:Exception do
      begin
        GeraLOG('Erro ao criar a tabela PEDIDOSPRODUTOS - ' + e.ToString);

        Result := False;
      end;
  end;
end;

end.
