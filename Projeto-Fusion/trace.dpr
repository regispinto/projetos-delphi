program trace;

uses
  Vcl.Forms,
  uMaster in 'uMaster.pas' {fMaster},
  uDM in 'uDM.pas' {DM: TDataModule},
  uClassConnection in '..\ClassConnection\uClassConnection.pas',
  uFunctios in '..\GenericFunctions\uFunctios.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfMaster, fMaster);
  Application.Run;
end.
