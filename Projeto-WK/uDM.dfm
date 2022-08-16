object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 428
  Width = 554
  object FDConnection: TFDConnection
    Left = 64
    Top = 64
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    Left = 64
    Top = 128
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 192
  end
  object dtsGeneric: TDataSource
    Left = 208
    Top = 64
  end
end
