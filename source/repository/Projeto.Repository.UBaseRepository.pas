unit Projeto.Repository.uBaseRepository;

interface

uses Rest.Client,
     Rest.Json,
     System.Generics.Collections,
     System.Classes,
     System.SysUtils;

type
  TBaseRepository<T: class, constructor> = class abstract (TInterfacedObject)
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    FBase_URL: String;
    procedure BaseUrlValidate;
  public
    function Get(const aResource: string): T; overload;
    function GetAll(const aResource: string): TList<T>; overload;
    constructor Create;
    destructor Destroy; override;

    property Base_URL: String write FBase_URL;
  end;

  

implementation

uses
  REST.Types,
  System.JSON,
  Vcl.Dialogs,
  utils.uExceptions;

{ TBaseRepository<T> }
procedure TBaseRepository<T>.BaseUrlValidate;
begin
  if Trim(FRESTClient.BaseURL).IsEmpty then
    raise EURLBase.Create('URL Base não foi informada');
end;

constructor TBaseRepository<T>.Create;
begin
  FRESTClient := TRESTClient.Create(nil);
  FRESTRequest := TRESTRequest.Create(nil);
  FRESTResponse := TRESTResponse.Create(nil);

  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;

  FRESTClient.BaseURL := FBase_URL;

  inherited;
end;

destructor TBaseRepository<T>.Destroy;
begin
  FRESTClient.Free;
  FRESTRequest.Free;
  FRESTResponse.Free;

  inherited;
end;

function TBaseRepository<T>.Get(const aResource: string): T;
var
  FJsonResult:  TJsonValue;
  FJsonArray: TJSONArray;
  i: integer;
begin
  BaseUrlValidate;

  Result := T.create;

  FRESTRequest.Resource := aResource;
  FRESTRequest.Method := rmGET;

  try
    FRESTRequest.Execute;
    if FRESTRequest.Response.StatusCode <> 200 then
      raise EGetStatusCode.Create('Não foi possivel consultar o CEP no VIACEP');


    FJsonResult := TJSONObject.ParseJSONValue(FRESTRequest.Response.Content);
    //FJsonArray := FJsonResult.GetValue<TJSONArray>('');

    Result := Tjson.JsonToObject<T>(FJsonResult.ToJSON);

  finally
    FJsonResult.Free;
  end;

end;

function TBaseRepository<T>.GetAll(const aResource: string): TList<T>;
var
  FJsonResult:  TJsonValue;
  FJsonArray: TJSONArray;
  i: integer;
begin
  BaseUrlValidate;
  Result := TList<T>.create;

  FRESTRequest.Resource := aResource;
  FRESTRequest.Method := rmGET;

  try
    FRESTRequest.Execute;
    if FRESTRequest.Response.StatusCode <> 200 then
      Exit;

    FJsonResult := TJSONObject.ParseJSONValue(FRESTRequest.Response.Content);
    FJsonArray := FJsonResult.GetValue<TJSONArray>('');

    for I := 0 to FJsonArray.Count - 1 do
      begin
        showmessage( FJsonArray.Items[i].ToJSON );
        Result.Add( Tjson.JsonToObject<T>(FJsonArray.Items[i].ToJSON));
      end;

  finally
    FJsonResult.Free;
  end;

end;

end.
