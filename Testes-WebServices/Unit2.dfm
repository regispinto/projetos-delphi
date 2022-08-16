object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 297
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WSDLHTMLPublish1: TWSDLHTMLPublish
    WebDispatch.MethodType = mtAny
    WebDispatch.PathInfo = 'wsdl*'
    Left = 408
    Top = 64
  end
  object HTTPSoapPascalInvoker1: THTTPSoapPascalInvoker
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 424
    Top = 149
  end
  object HTTPSoapDispatcher1: THTTPSoapDispatcher
    Dispatcher = HTTPSoapPascalInvoker1
    WebDispatch.PathInfo = 'soap*'
    Left = 144
    Top = 181
  end
  object SoapConnection1: TSoapConnection
    SOAPServerIID = 'IAppServerSOAP - {C99F4735-D6D2-495C-8CA2-E53E5A439E61}'
    UseSOAPAdapter = True
    Left = 144
    Top = 133
  end
  object OPToSoapDomConvert1: TOPToSoapDomConvert
    Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 144
    Top = 85
  end
  object HTTPReqResp1: THTTPReqResp
    Left = 144
    Top = 237
  end
  object HTTPRIO1: THTTPRIO
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 144
    Top = 32
  end
end
