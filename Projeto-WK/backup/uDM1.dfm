object DM: TDM
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 520
  Width = 878
  object qryListData: TFDQuery
    Left = 172
    Top = 177
  end
  object dtsGeneric: TDataSource
    DataSet = qryListData
    Left = 264
    Top = 176
  end
  object fdcInsereProdutos: TFDCommand
    CommandText.Strings = (
      'INSERT INTO produtos (descricao, preco_venda) VALUES '
      #10'('#39'Produto A'#39', 10.50),'#10'('#39'Produto H'#39', 213.99),'#10
      '('#39'Produto X'#39', 55.21),'#10'('#39'Produto W'#39', 1.20),'#10
      '('#39'Produto B'#39', 22.22),'#10'('#39'Produto C'#39', 56.10), '
      #10'('#39'Produto D'#39', 54.54),'#10'('#39'Produto I'#39', 122),'#10
      '('#39'Produto Y'#39', 1000.01),'#10
      '('#39'Produto J'#39', 220.10),'#10
      '('#39'Produto E'#39', 55.01),'
      #10'('#39'Produto K'#39', 22),'#10
      '('#39'Produto O'#39', 41.11),'#10
      '('#39'Produto Q'#39', 52.11),'#10
      '('#39'Produto P'#39', 51.),'#10
      '('#39'Produto R'#39', 2000),'#10
      '('#39'Produto S'#39', 151.01),'#10
      '('#39'Produto T'#39', 981.69),'#10
      '('#39'Produto U'#39', 21),'#10
      '('#39'Produto V'#39', 11.33);')
    Left = 395
    Top = 102
  end
  object fdcInsereClientes: TFDCommand
    CommandText.Strings = (
      'INSERT INTO clientes (Nome, cidade, uf) VALUES '
      #10'('#39'Cliente A'#39', '#39'Porto Alegre'#39', '#39'RS'#39'),'#10
      '('#39'Cliente H'#39', '#39'Rio de Janeiro'#39', '#39'RJ'#39'),'#10
      '('#39'Cliente X'#39', '#39'S'#227'o Paulo'#39', '#39'RS'#39'),'#10
      '('#39'Cliente W'#39', '#39'Ribeir'#227'o Preto'#39', '#39'SP'#39'),'
      #10'('#39'Cliente B'#39', '#39'Caxias do Sul'#39', '#39'RS'#39'),'#10
      '('#39'Cliente C'#39', '#39'Salvador'#39', '#39'BA'#39'), '
      #10'('#39'Cliente D'#39', '#39'S'#227'o Gon'#231'alo'#39', '#39'RJ'#39'),'#10
      '('#39'Cliente I'#39', '#39'Canoas'#39', '#39'RS'#39'),'#10
      '('#39'Cliente Y'#39', '#39'Viam'#227'o'#39', '#39'RS'#39'),'#10
      '('#39'Cliente J'#39', '#39'Guaiba'#39', '#39'RS'#39'),'#10
      '('#39'Cliente E'#39', '#39'Belo Horizonte'#39', '#39'MG'#39'),'#10
      '('#39'Cliente K'#39', '#39'Florian'#243'polis'#39', '#39'SC'#39'),'#10
      '('#39'Cliente O'#39', '#39'Crici'#250'ma'#39', '#39'SC'#39'),'#10
      '('#39'Cliente Q'#39', '#39'S'#227'o Lu'#237's'#39', '#39'MA'#39'),'#10
      '('#39'Cliente P'#39', '#39'Goi'#226'nia'#39', '#39'GO'#39'),'#10
      '('#39'Cliente R'#39', '#39'Recife'#39', '#39'PE'#39'),'#10
      '('#39'Cliente S'#39', '#39'Viam'#227'o'#39', '#39'RS'#39'),'#10
      '('#39'Cliente T'#39', '#39'Porto Alegre'#39', '#39'RS'#39'),'#10
      '('#39'Cliente U'#39', '#39'Porto Alegre'#39', '#39'RS'#39'),'#10
      '('#39'Cliente V'#39', '#39'S'#227'o Paulo'#39', '#39'SP'#39');')
    Left = 291
    Top = 102
  end
end
