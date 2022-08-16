object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 368
  Width = 614
  object FDConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=C:\Vendas\VENDAS.FDB'
      'Port=3080'
      'DriverID=FB')
    LoginPrompt = False
    Left = 81
    Top = 33
  end
  object FDPhysFBDriverLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files\Firebird\Firebird_2_5\WOW64\fbclient.dll'
    Left = 80
    Top = 96
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 75
    Top = 160
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection
    Left = 184
    Top = 120
  end
end
