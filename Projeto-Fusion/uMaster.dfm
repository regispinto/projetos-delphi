object fMaster: TfMaster
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Trace downloadas'
  ClientHeight = 507
  ClientWidth = 790
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 464
    Width = 790
    Height = 43
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 272
    Width = 790
    Height = 192
    Align = alBottom
    BorderStyle = bsSingle
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 784
      Height = 186
      Align = alClient
      DataSource = dsLogs
      DrawingStyle = gdsGradient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 241
    Width = 105
    Height = 25
    Caption = 'Open Table'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object dsLogs: TDataSource
    Left = 240
    Top = 352
  end
end
