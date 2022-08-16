object fmConsultaClientes: TfmConsultaClientes
  Left = 0
  Top = 0
  Caption = 'Consulta de Clientes'
  ClientHeight = 297
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPesquisa: TPanel
    Left = 0
    Top = 0
    Width = 562
    Height = 49
    Align = alTop
    TabOrder = 0
  end
  object dbgClientes: TDBGrid
    Left = 0
    Top = 49
    Width = 562
    Height = 248
    Align = alClient
    DataSource = DM.dtsGeneric
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
end
