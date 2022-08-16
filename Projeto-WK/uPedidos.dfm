object fmPedidos: TfmPedidos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pedidos de Vendas'
  ClientHeight = 588
  ClientWidth = 829
  Color = clBtnFace
  Constraints.MaxHeight = 617
  Constraints.MaxWidth = 835
  Constraints.MinHeight = 617
  Constraints.MinWidth = 835
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object gbxCliente: TGroupBox
    Left = 0
    Top = 0
    Width = 829
    Height = 90
    Align = alTop
    Caption = 'Cliente'
    Color = clBtnFace
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object lblCodigoDoCliente: TLabel
      Left = 13
      Top = 24
      Width = 43
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object spbConsultaClientes: TSpeedButton
      Left = 100
      Top = 43
      Width = 23
      Height = 23
      Cursor = crHandPoint
      OnClick = spbConsultaClientesClick
    end
    object lblNomeDoCliente: TLabel
      Left = 136
      Top = 24
      Width = 100
      Height = 14
      Caption = 'Nome do Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigoDoCliente: TEdit
      Left = 13
      Top = 44
      Width = 109
      Height = 22
      Alignment = taRightJustify
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnChange = edtCodigoDoClienteChange
      OnKeyDown = edtCodigoDoClienteKeyDown
      OnKeyPress = edtCodigoDoClienteKeyPress
    end
    object edtNomeDoCliente: TEdit
      Left = 136
      Top = 44
      Width = 413
      Height = 23
      TabStop = False
      CharCase = ecUpperCase
      Color = clGradientInactiveCaption
      ReadOnly = True
      TabOrder = 1
    end
  end
  object gbxProdutos: TGroupBox
    Left = 0
    Top = 90
    Width = 829
    Height = 115
    Align = alTop
    Caption = 'Produtos'
    Color = clCream
    ParentBackground = False
    ParentColor = False
    TabOrder = 1
    object lblCodigoDoProduto: TLabel
      Left = 13
      Top = 24
      Width = 43
      Height = 14
      Caption = 'C'#243'digo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object spbConsultaProdutos: TSpeedButton
      Left = 100
      Top = 44
      Width = 23
      Height = 22
      Cursor = crHandPoint
      OnClick = spbConsultaProdutosClick
    end
    object lblDescricaoDoProduto: TLabel
      Left = 136
      Top = 24
      Width = 132
      Height = 14
      Caption = 'Descri'#231#227'o do Produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblVlrVenda: TLabel
      Left = 563
      Top = 24
      Width = 58
      Height = 14
      Caption = 'Vlr.Venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblQuantidade: TLabel
      Left = 652
      Top = 24
      Width = 71
      Height = 14
      Caption = 'Quantidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValorTotal: TLabel
      Left = 741
      Top = 24
      Width = 51
      Height = 14
      Caption = 'Vlr.Total'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodigoDoProduto: TEdit
      Left = 13
      Top = 44
      Width = 109
      Height = 22
      Alignment = taRightJustify
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnChange = edtCodigoDoProdutoChange
      OnKeyDown = edtCodigoDoProdutoKeyDown
      OnKeyPress = edtCodigoDoProdutoKeyPress
    end
    object edtDescricaoDoProduto: TEdit
      Left = 136
      Top = 44
      Width = 413
      Height = 23
      TabStop = False
      CharCase = ecUpperCase
      Color = clGradientInactiveCaption
      ReadOnly = True
      TabOrder = 1
    end
    object edtQuantidade: TEdit
      Left = 652
      Top = 44
      Width = 75
      Height = 23
      Alignment = taRightJustify
      Color = clGradientInactiveCaption
      MaxLength = 4
      NumbersOnly = True
      TabOrder = 2
      OnKeyDown = edtQuantidadeKeyDown
      OnKeyPress = edtQuantidadeKeyPress
    end
    object btnConfirmar: TButton
      Left = 741
      Top = 79
      Width = 73
      Height = 25
      Cursor = crHandPoint
      Hint = 'Insere o item no pedido'
      Caption = 'Confirmar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnConfirmarClick
    end
    object edtVlrVenda: TEdit
      Left = 563
      Top = 44
      Width = 73
      Height = 23
      Alignment = taRightJustify
      Color = clGradientInactiveCaption
      TabOrder = 4
      Text = '0,00'
    end
    object edtValorTotal: TEdit
      Left = 741
      Top = 44
      Width = 73
      Height = 23
      Alignment = taRightJustify
      Color = clGradientInactiveCaption
      TabOrder = 5
      Text = '0,00'
    end
  end
  object gbxItensDoPedido: TGroupBox
    Left = 0
    Top = 205
    Width = 829
    Height = 338
    Align = alTop
    Caption = 'Itens do Pedido'
    TabOrder = 2
    object dbgItensDoPedido: TDBGrid
      Left = 2
      Top = 17
      Width = 825
      Height = 295
      Align = alClient
      DataSource = dtsItensDoPedido
      DrawingStyle = gdsGradient
      GradientEndColor = clMoneyGreen
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Arial'
      TitleFont.Style = []
      OnKeyDown = dbgItensDoPedidoKeyDown
    end
    object stbTotal: TStatusBar
      Left = 2
      Top = 312
      Width = 825
      Height = 24
      Color = clMoneyGreen
      Panels = <
        item
          Width = 400
        end
        item
          Text = 'Total do Pedido:'
          Width = 50
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 543
    Width = 829
    Height = 45
    Hint = 'Cancela um pedido existente'
    Align = alClient
    TabOrder = 3
    object btnGravar: TButton
      Left = 581
      Top = 11
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Hint = 'Grava os dados do pedido'
      Caption = 'Gravar Pedido'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCarregar: TButton
      Left = 13
      Top = 6
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Hint = 'Carrega um pedido existente'
      Caption = 'Carregar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnCarregarClick
    end
    object btnCancelar: TButton
      Left = 119
      Top = 6
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Hint = 'Cancela um pedido existente'
      Caption = 'Cancelar'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object btnRetornar: TButton
      Left = 687
      Top = 11
      Width = 100
      Height = 25
      Cursor = crHandPoint
      Hint = 'Retorna a tela anterior'
      Caption = 'Sair'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnRetornarClick
    end
  end
  object fdmItensDoPedido: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 80
    Top = 253
    object fdmItensDoPedidoCodigoProduto: TIntegerField
      FieldName = 'CodigoProduto'
    end
    object fdmItensDoPedidoDescricaoProduto: TStringField
      FieldName = 'DescricaoProduto'
      Size = 40
    end
    object fdmItensDoPedidoValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
      DisplayFormat = '#,###,##0.00'
      currency = True
    end
    object fdmItensDoPedidoQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object fdmItensDoPedidoValorTotal: TFloatField
      FieldName = 'ValorTotal'
      DisplayFormat = '#,###,##0.00'
      currency = True
    end
  end
  object dtsItensDoPedido: TDataSource
    DataSet = fdmItensDoPedido
    Left = 80
    Top = 304
  end
end
