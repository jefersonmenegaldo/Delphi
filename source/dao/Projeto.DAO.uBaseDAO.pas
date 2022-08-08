unit Projeto.DAO.uBaseDAO;

interface

uses System.Generics.Collections,
     System.Classes,
     FireDAC.Comp.Client,
     Projeto.DAO.uConnection;

type
  TBaseDAO<T: class, constructor> = class abstract (TInterfacedObject)
  private
    FQuery: TFDQuery;
    FConnection: TConnection;

  public
    function Add(const value: T): T; overload;
    function Get(const aResource: string): T; overload;
    function GetAll(const aResource: string): TList<T>; overload;
    constructor Create;
    destructor Destroy; override;


  end;

implementation

uses
  System.JSON, Vcl.Dialogs, System.SysUtils, REST.Json, FireDAC.Stan.Intf,
  Data.DB;


function TBaseDAO<T>.Add(const value: T): T;
begin


  FQuery.SQL.Clear;
  FQuery.SQL.Add('Insert into '+value.ClassName+' (id, dados) values('+
    '(select max(id) +1 from ' + value.ClassName+ ')'+
  ',' + QuotedStr(TJson.ObjectToJsonString(Value))+' ) returning id,dados');

  FQuery.Prepare;
  //FQuery.SQL.SaveToFile('c:\projetos\sql.txt');
  FQuery.Open;

  if FQuery.IsEmpty then
    Exit;

  Result := TJson.JsonToObject<T>(FQuery.FieldByName('Dados').AsString);
end;

constructor TBaseDAO<T>.Create;
begin
  FConnection := TConnection.Create;
  FQuery := TFDQuery.Create(nil);

  FQuery.Connection := FConnection.Connection;
  inherited;
end;

destructor TBaseDAO<T>.Destroy;
begin
  FConnection.Free;
  FQuery.Free;
  inherited;
end;

function TBaseDAO<T>.Get(const aResource: string): T;
begin
  Result := nil;
  FQuery.SQL.Clear;
  FQuery.Params.Clear;
  FQuery.SQL.Add(Format('Select * from %s ', [TClass(T).ClassName]));

  if not Trim(aResource).IsEmpty then
    FQuery.SQL. Add(Format('Where %s', [aResource]));

  FQuery.SQL.Add(' Limit 1');
  FQuery.Open;

  if FQuery.IsEmpty then
    Exit;

  Result := TJson.JsonToObject<T>(FQuery.FieldByName('Dados').AsString);
end;

function TBaseDAO<T>.GetAll(const aResource: string): TList<T>;
begin
    //

end;

end.
