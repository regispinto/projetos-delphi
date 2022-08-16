object fCadUsuario: TfCadUsuario
  Left = 0
  Top = 0
  Caption = 'Cadastro de Usu'#225'rios'
  ClientHeight = 229
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 172
    Width = 721
    Height = 37
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
      Left = 482
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      Enabled = False
      TabOrder = 2
      TabStop = False
      OnClick = btCancelarClick
    end
    object btGravar: TButton
      Left = 399
      Top = 8
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
      Left = 183
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
  end
  object pnDados: TPanel
    Left = 0
    Top = 0
    Width = 721
    Height = 172
    Align = alClient
    BorderStyle = bsSingle
    Enabled = False
    TabOrder = 1
    object Label1: TLabel
      Left = 21
      Top = 21
      Width = 63
      Height = 13
      Caption = 'ID_USUARIO'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 106
      Top = 21
      Width = 29
      Height = 13
      Caption = 'NOME'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 21
      Top = 69
      Width = 31
      Height = 13
      Caption = 'LOGIN'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 229
      Top = 69
      Width = 33
      Height = 13
      Caption = 'SENHA'
      FocusControl = DBEdit4
    end
    object DBEdit1: TDBEdit
      Left = 21
      Top = 37
      Width = 62
      Height = 21
      DataField = 'ID_USUARIO'
      DataSource = DataSource1
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 106
      Top = 37
      Width = 451
      Height = 21
      CharCase = ecUpperCase
      DataField = 'NOME'
      DataSource = DataSource1
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 21
      Top = 85
      Width = 199
      Height = 21
      CharCase = ecUpperCase
      DataField = 'LOGIN'
      DataSource = DataSource1
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 229
      Top = 85
      Width = 134
      Height = 21
      DataField = 'SENHA'
      DataSource = DataSource1
      PasswordChar = '*'
      TabOrder = 3
    end
    object rgStatus: TDBRadioGroup
      Left = 404
      Top = 69
      Width = 153
      Height = 67
      Caption = 'Status'
      Columns = 2
      DataField = 'ATIVO'
      DataSource = DataSource1
      Items.Strings = (
        'Ativo'
        'Inativo')
      TabOrder = 4
      Values.Strings = (
        'A'
        'I')
    end
  end
  object sbRodape: TStatusBar
    Left = 0
    Top = 209
    Width = 721
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
  object FDQuery1: TFDQuery
    AfterScroll = FDQuery1AfterScroll
    SQL.Strings = (
      'SELECT * FROM USUARIOS')
    Left = 34
    Top = 128
    object FDQuery1ID_USUARIO: TLargeintField
      FieldName = 'ID_USUARIO'
      Origin = 'ID_USUARIO'
      Required = True
    end
    object FDQuery1NOME: TStringField
      FieldName = 'NOME'
      Origin = 'NOME'
      Required = True
      Size = 40
    end
    object FDQuery1LOGIN: TStringField
      FieldName = 'LOGIN'
      Origin = 'LOGIN'
      Required = True
      Size = 15
    end
    object FDQuery1SENHA: TStringField
      FieldName = 'SENHA'
      Origin = 'SENHA'
      Required = True
      Size = 10
    end
    object FDQuery1ATIVO: TStringField
      FieldName = 'ATIVO'
      Origin = 'ATIVO'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 98
    Top = 128
  end
end
