object fLogin: TfLogin
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Login de acesso'
  ClientHeight = 190
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 356
    Height = 190
    Align = alClient
    BorderStyle = bsSingle
    Color = clMoneyGreen
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 29
      Top = 34
      Width = 30
      Height = 13
      Caption = 'Us'#225'rio'
    end
    object SpeedButton1: TSpeedButton
      Left = 302
      Top = 51
      Width = 23
      Height = 22
      Cursor = crHandPoint
      Hint = 'Visualiza a senha informada'
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object Label2: TLabel
      Left = 169
      Top = 34
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object edUsuario: TEdit
      Left = 29
      Top = 51
      Width = 121
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyPress = edUsuarioKeyPress
    end
    object edSenha: TEdit
      Left = 169
      Top = 51
      Width = 121
      Height = 21
      NumbersOnly = True
      PasswordChar = '*'
      TabOrder = 1
      OnKeyPress = edSenhaKeyPress
    end
    object Button2: TButton
      Left = 224
      Top = 110
      Width = 100
      Height = 36
      Caption = 'Cancelar'
      TabOrder = 3
      OnClick = Button2Click
      OnKeyPress = Button2KeyPress
    end
    object Button1: TButton
      Left = 111
      Top = 110
      Width = 100
      Height = 36
      Caption = 'Acessar'
      TabOrder = 2
      OnClick = Button1Click
      OnKeyPress = Button1KeyPress
    end
  end
  object FDQuery1: TFDQuery
    SQL.Strings = (
      'SELECT * FROM USUARIOS')
    Left = 34
    Top = 120
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
end
