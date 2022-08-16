object fmConsultaClientes: TfmConsultaClientes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Consulta de Clientes'
  ClientHeight = 297
  ClientWidth = 544
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgConsulta: TDBGrid
    Left = 0
    Top = 0
    Width = 544
    Height = 278
    Align = alClient
    DrawingStyle = gdsGradient
    GradientStartColor = clSkyBlue
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = dbgConsultaDblClick
  end
  object stbConsultaClientes: TStatusBar
    Left = 0
    Top = 278
    Width = 544
    Height = 19
    Panels = <
      item
        Text = 'Utilize duplo clique para selecionar um cliente da lista'
        Width = 300
      end
      item
        Alignment = taRightJustify
        Text = 'Tecle ESC para retornar     '
        Width = 50
      end>
  end
end
