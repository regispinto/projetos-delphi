unit SplasScreen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg,
  uDM, uConexao, Vcl.ComCtrls;

type
  TfSplash = class(TForm)
    imSplash: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fSplash: TfSplash;
  conexaoClass : TConexao;

implementation

{$R *.dfm}

end.
