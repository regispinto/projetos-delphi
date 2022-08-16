object fCadCliente: TfCadCliente
  Left = 0
  Top = 0
  Caption = 'fCadCliente'
  ClientHeight = 542
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 481
    Width = 754
    Height = 41
    Align = alBottom
    BevelInner = bvLowered
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object DBNavigator1: TDBNavigator
      Left = 8
      Top = 8
      Width = 88
      Height = 25
      DataSource = DataSource1
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      TabOrder = 0
    end
    object btCancelar: TButton
      Left = 551
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 2
      TabStop = False
      OnClick = btCancelarClick
    end
    object btGravar: TButton
      Left = 470
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Gravar'
      Enabled = False
      TabOrder = 1
      TabStop = False
      OnClick = btGravarClick
    end
    object btIncluir: TButton
      Left = 102
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Novo'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 3
      OnClick = btIncluirClick
    end
    object btEditar: TButton
      Left = 181
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Edita'
      TabOrder = 4
      OnClick = btEditarClick
    end
    object btExcluir: TButton
      Left = 262
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Exclui'
      TabOrder = 5
      OnClick = btExcluirClick
    end
    object btExporta: TButton
      Left = 343
      Top = 6
      Width = 75
      Height = 25
      Caption = 'CSV'
      TabOrder = 6
      OnClick = btExportaClick
    end
  end
  object pnDados: TPanel
    Left = 0
    Top = 0
    Width = 754
    Height = 481
    Align = alClient
    BorderStyle = bsSingle
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 56
      Width = 29
      Height = 13
      Caption = 'NOME'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 8
      Top = 104
      Width = 66
      Height = 13
      Caption = 'NASCIMENTO'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 148
      Top = 104
      Width = 50
      Height = 13
      Caption = 'TELEFONE'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 301
      Top = 101
      Width = 30
      Height = 13
      Caption = 'EMAIL'
      FocusControl = DBEdit4
    end
    object Label12: TLabel
      Left = 8
      Top = 13
      Width = 58
      Height = 13
      Caption = 'ID_CLIENTE'
      FocusControl = DBEdit12
    end
    object Label14: TLabel
      Left = 301
      Top = 168
      Width = 98
      Height = 13
      Caption = 'INSCRICAO_FISCAL'
      FocusControl = DBEdit14
    end
    object lbResponsavel: TLabel
      Left = 8
      Top = 451
      Width = 82
      Height = 13
      Caption = 'lbResponsavel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBEdit1: TDBEdit
      Left = 9
      Top = 74
      Width = 617
      Height = 21
      DataField = 'NOME'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit2: TDBEdit
      Left = 8
      Top = 120
      Width = 134
      Height = 21
      DataField = 'NASCIMENTO'
      DataSource = DataSource1
      MaxLength = 8
      TabOrder = 2
    end
    object DBEdit3: TDBEdit
      Left = 148
      Top = 120
      Width = 147
      Height = 21
      DataField = 'TELEFONE'
      DataSource = DataSource1
      TabOrder = 3
    end
    object DBEdit4: TDBEdit
      Left = 302
      Top = 120
      Width = 324
      Height = 21
      DataField = 'EMAIL'
      DataSource = DataSource1
      TabOrder = 4
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 239
      Width = 617
      Height = 206
      Caption = 'Endere'#231'o'
      TabOrder = 7
      object Label5: TLabel
        Left = 131
        Top = 24
        Width = 127
        Height = 13
        Caption = 'END_TIPO_LOGRADOURO'
        FocusControl = DBEdit5
      end
      object Label6: TLabel
        Left = 16
        Top = 64
        Width = 132
        Height = 13
        Caption = 'END_NOME_LOGRADOURO'
        FocusControl = DBEdit6
      end
      object Label7: TLabel
        Left = 520
        Top = 64
        Width = 69
        Height = 13
        Caption = 'END_NUMERO'
        FocusControl = DBEdit7
      end
      object Label8: TLabel
        Left = 16
        Top = 104
        Width = 101
        Height = 13
        Caption = 'END_COMPLEMENTO'
        FocusControl = DBEdit8
      end
      object Label9: TLabel
        Left = 273
        Top = 144
        Width = 64
        Height = 13
        Caption = 'END_CIDADE'
        FocusControl = DBEdit9
      end
      object Label10: TLabel
        Left = 429
        Top = 144
        Width = 39
        Height = 13
        Caption = 'END_UF'
        FocusControl = DBEdit10
      end
      object Label11: TLabel
        Left = 16
        Top = 24
        Width = 45
        Height = 13
        Caption = 'END_CEP'
        FocusControl = DBEdit11
      end
      object Label13: TLabel
        Left = 16
        Top = 144
        Width = 65
        Height = 13
        Caption = 'END_BAIRRO'
        FocusControl = DBEdit13
      end
      object DBEdit5: TDBEdit
        Left = 131
        Top = 40
        Width = 48
        Height = 21
        DataField = 'END_TIPO_LOGRADOURO'
        DataSource = DataSource1
        TabOrder = 1
      end
      object DBEdit6: TDBEdit
        Left = 16
        Top = 80
        Width = 498
        Height = 21
        DataField = 'END_NOME_LOGRADOURO'
        DataSource = DataSource1
        TabOrder = 2
      end
      object DBEdit7: TDBEdit
        Left = 520
        Top = 80
        Width = 69
        Height = 21
        DataField = 'END_NUMERO'
        DataSource = DataSource1
        TabOrder = 3
      end
      object DBEdit8: TDBEdit
        Left = 16
        Top = 120
        Width = 573
        Height = 21
        DataField = 'END_COMPLEMENTO'
        DataSource = DataSource1
        TabOrder = 4
      end
      object DBEdit9: TDBEdit
        Left = 273
        Top = 160
        Width = 150
        Height = 21
        DataField = 'END_CIDADE'
        DataSource = DataSource1
        TabOrder = 6
      end
      object DBEdit10: TDBEdit
        Left = 429
        Top = 160
        Width = 30
        Height = 21
        DataField = 'END_UF'
        DataSource = DataSource1
        TabOrder = 7
      end
      object DBEdit11: TDBEdit
        Left = 17
        Top = 43
        Width = 108
        Height = 21
        DataField = 'END_CEP'
        DataSource = DataSource1
        TabOrder = 0
      end
      object DBEdit13: TDBEdit
        Left = 16
        Top = 160
        Width = 251
        Height = 21
        DataField = 'END_BAIRRO'
        DataSource = DataSource1
        TabOrder = 5
      end
      object DBEdit15: TDBEdit
        Left = 120
        Top = 216
        Width = 199
        Height = 21
        DataField = 'ID_USARIO'
        DataSource = DataSource1
        TabOrder = 8
      end
    end
    object DBEdit12: TDBEdit
      Left = 8
      Top = 29
      Width = 58
      Height = 21
      TabStop = False
      DataField = 'ID_CLIENTE'
      DataSource = DataSource1
      Enabled = False
      TabOrder = 0
    end
    object DBRadioGroup1: TDBRadioGroup
      Left = 8
      Top = 168
      Width = 287
      Height = 65
      Caption = 'Tipo Pessoa'
      Columns = 2
      DataField = 'PESSOA'
      DataSource = DataSource1
      Items.Strings = (
        'F'#237'sica'
        'Jur'#237'dica')
      TabOrder = 5
      Values.Strings = (
        'F'
        'J')
    end
    object DBEdit14: TDBEdit
      Left = 301
      Top = 187
      Width = 186
      Height = 21
      DataField = 'INSCRICAO_FISCAL'
      DataSource = DataSource1
      TabOrder = 6
      OnEnter = DBEdit14Enter
    end
  end
  object sbRodape: TStatusBar
    Left = 0
    Top = 522
    Width = 754
    Height = 20
    Panels = <
      item
        Style = psOwnerDraw
        Width = 500
      end
      item
        Width = 100
      end>
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 320
    Top = 16
  end
  object FDQuery1: TFDQuery
    AfterOpen = FDQuery1AfterOpen
    AfterScroll = FDQuery1AfterScroll
    SQL.Strings = (
      'SELECT CLIENTES.*, USUARIOS.nome'
      'FROM CLIENTES'
      'LEFT JOIN USUARIOS ON (USUARIOS.id_usuario = CLIENTES.id_usario)')
    Left = 240
    Top = 16
    object FDQuery1ID_CLIENTE: TLargeintField
      FieldName = 'ID_CLIENTE'
      Origin = 'ID_CLIENTE'
      ProviderFlags = [pfInWhere, pfInKey]
      Required = True
    end
    object FDQuery1NOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 100
    end
    object FDQuery1NASCIMENTO: TDateField
      FieldName = 'NASCIMENTO'
      Origin = 'NASCIMENTO'
      Required = True
    end
    object FDQuery1TELEFONE: TStringField
      FieldName = 'TELEFONE'
      Origin = 'TELEFONE'
      Required = True
      FixedChar = True
      Size = 11
    end
    object FDQuery1EMAIL: TStringField
      FieldName = 'EMAIL'
      Origin = 'EMAIL'
      Required = True
      OnValidate = FDQuery1EMAILValidate
      Size = 150
    end
    object FDQuery1END_TIPO_LOGRADOURO: TStringField
      FieldName = 'END_TIPO_LOGRADOURO'
      Origin = 'END_TIPO_LOGRADOURO'
      Required = True
    end
    object FDQuery1END_NOME_LOGRADOURO: TStringField
      FieldName = 'END_NOME_LOGRADOURO'
      Origin = 'END_NOME_LOGRADOURO'
      Required = True
      Size = 150
    end
    object FDQuery1END_NUMERO: TStringField
      FieldName = 'END_NUMERO'
      Origin = 'END_NUMERO'
      Required = True
      Size = 10
    end
    object FDQuery1END_COMPLEMENTO: TStringField
      FieldName = 'END_COMPLEMENTO'
      Origin = 'END_COMPLEMENTO'
      Size = 50
    end
    object FDQuery1END_BAIRRO: TStringField
      FieldName = 'END_BAIRRO'
      Origin = 'END_BAIRRO'
      Required = True
      Size = 150
    end
    object FDQuery1END_CIDADE: TStringField
      FieldName = 'END_CIDADE'
      Origin = 'END_CIDADE'
      Required = True
      Size = 150
    end
    object FDQuery1END_UF: TStringField
      FieldName = 'END_UF'
      Origin = 'END_UF'
      Required = True
      FixedChar = True
      Size = 2
    end
    object FDQuery1END_CEP: TStringField
      FieldName = 'END_CEP'
      Origin = 'END_CEP'
      Required = True
      FixedChar = True
      Size = 8
    end
    object FDQuery1PESSOA: TStringField
      FieldName = 'PESSOA'
      Origin = 'PESSOA'
      Required = True
      FixedChar = True
      Size = 1
    end
    object FDQuery1INSCRICAO_FISCAL: TStringField
      FieldName = 'INSCRICAO_FISCAL'
      Origin = 'INSCRICAO_FISCAL'
      Required = True
      OnValidate = FDQuery1INSCRICAO_FISCALValidate
      Size = 14
    end
    object FDQuery1ID_USARIO: TLargeintField
      FieldName = 'ID_USARIO'
      Origin = 'ID_USARIO'
      Required = True
    end
    object FDQuery1NOME_1: TStringField
      AutoGenerateValue = arDefault
      FieldName = 'NOME_1'
      Origin = 'NOME'
      ProviderFlags = []
      ReadOnly = True
      Size = 40
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'Arquivos Texto|*.txt'
    Title = 'Selecione a pasta destino do arquivo'
    Left = 160
    Top = 16
  end
end
