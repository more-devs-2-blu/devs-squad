object DmDados: TDmDados
  OldCreateOrder = False
  Height = 223
  Width = 279
  object RESTClient1: TRESTClient
    Params = <>
    Left = 32
    Top = 56
  end
  object RESTRequest1: TRESTRequest
    Client = RESTClient1
    Params = <>
    Response = RESTResponse1
    Left = 104
    Top = 56
  end
  object RESTResponse1: TRESTResponse
    Left = 192
    Top = 56
  end
  object RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter
    Dataset = FDMemTable1
    FieldDefs = <>
    Response = RESTResponse1
    Left = 48
    Top = 128
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 176
    Top = 136
  end
end
