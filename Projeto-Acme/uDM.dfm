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
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 64
    Top = 192
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    Left = 64
    Top = 128
  end
end
