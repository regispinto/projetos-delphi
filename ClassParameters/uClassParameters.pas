unit uClassParameters;

interface

uses
    IniFiles, SysUtils, Forms, Dialogs, StrUtils, Data.DB,
    uFunctios;

type
  TParameters = class
  private
    FFileName: string;
    FSection: string;
    FParam: string;
    FValue: string;
  public
    property FileName: string read FFileName write FFileName;
    property Section: string read FSection write FSection;
    property Param: string read FParam write FParam;
    property Value: string read FValue write FValue;

    constructor Create (FileName: string);
    destructor Destroy; Override;
  end;

implementation

{ TParameters }

constructor TParameters.Create(FileName: string);
begin
  FFileName := FileName;
end;

destructor TParameters.Destroy;
begin

  inherited;
end;

end.
