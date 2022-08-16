unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.TypInfo, Soap.WebServExp,
  Soap.WSDLBind, Xml.XMLSchema, Soap.InvokeRegistry, Soap.WSDLIntf,
  System.Net.URLClient, System.Net.HttpClient, Soap.Rio, Soap.SOAPHTTPClient,
  Soap.SOAPHTTPTrans, Soap.SOAPDomConv, Soap.OPToSOAPDomConv, Data.DB,
  Datasnap.DBClient, Soap.SOAPConn, Soap.SOAPHTTPDisp, Soap.WebBrokerSOAP,
  Soap.SOAPPasInv, Soap.SOAPHTTPPasInv, Soap.WSDLPub;

type
  TForm2 = class(TForm)
    WSDLHTMLPublish1: TWSDLHTMLPublish;
    HTTPSoapPascalInvoker1: THTTPSoapPascalInvoker;
    HTTPSoapDispatcher1: THTTPSoapDispatcher;
    SoapConnection1: TSoapConnection;
    OPToSoapDomConvert1: TOPToSoapDomConvert;
    HTTPReqResp1: THTTPReqResp;
    HTTPRIO1: THTTPRIO;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
