unit Projeto.DAO.uConnection;

interface

uses FireDAC.Comp.Client,
     FireDAC.Comp.Script,
     System.SysUtils,
     FireDAC.Stan.Def,
     FireDAC.DApt,
     FireDAC.Stan.Async,
     FireDAC.Phys.PG;

type
  TConnection = class
    private
      FConnection: TFDConnection;
      FPGDriverLink: TFDPhysPgDriverLink;
    public
      constructor Create;
      destructor Destroy; override;
      property Connection: TFDConnection read FConnection write FConnection;
  end;

implementation

uses
  Vcl.Forms;

{ TConnection }

constructor TConnection.Create;
begin
  FPGDriverLink := TFDPhysPgDriverLink.Create(Application);
  FConnection := TFDConnection.Create(Application);


  FPGDriverLink.VendorLib := 'C:\Projetos\DelphiDocker\output\lib\libpq.dll';//IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'lib\libpq.dll';

  FConnection.Params.Add(Format('CharacterSet=%s', ['UTF8']));
  FConnection.Params.DriverID := 'PG';
  FConnection.Params.UserName := 'postgres';
  FConnection.Params.Password := 'postgres';
  FConnection.Params.Values['DATABASE'] := 'meudb';
  FConnection.Params.Values['PORT']    := '5432';

  FConnection
  .Params
  .SaveToFile(IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + 'Connection.def');

  FConnection.Open;
end;

destructor TConnection.Destroy;
begin
  if FConnection.Connected then
    FConnection.Close;

  if Assigned(FConnection) then
    FConnection.Free;

  if Assigned(FPGDriverLink) then
    FPGDriverLink.Free;

  inherited;
end;

end.
