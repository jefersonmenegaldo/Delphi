unit Projeto.Repository.uCepRepository;

interface

uses
  Projeto.View.uInterfaces,
  System.Generics.Collections,
  Projeto.Repository.uBaseRepository,
  Projeto.Dao.uBaseDAO,
  Projeto.Model.uCep,
  System.Classes;

type
  TCepRepository<T: class, constructor> = class(TBaseRepository<T>, IRestBase<T>)
  public
    FDB: TBaseDAO<CEP>;
    function ObterTodos: TList<T>; overload;
    function GetByCEP(const Value: string): T; overload;
    //function GetByCep(const Value: String): T;

    constructor Create; overload;

  end;

implementation

uses
  System.SysUtils, REST.Json;

constructor TCepRepository<T>.Create;
begin
  Base_URL := 'viacep.com.br/ws/';

  FDB := TBaseDAO<CEP>.Create;
  inherited;
end;

function TCepRepository<T>.ObterTodos: TList<T>;
begin
 //
end;

function TCepRepository<T>.GetByCEP(const Value: string): T;
var fCep: cep;
s: string;
begin
  Result := T(FDB.Get(
  'dados['+quotedstr('cep')+'] = '+ QuotedStr('"'+ Value +'"')
  //'dados->' +
   //QuotedStr('cep')+ ' ? ' +QuotedStr('01001-000')
  //'id = 1'
   //''
  ));
  if not Assigned(Result) then
  begin
    Result := Get(Format('%s/json/',[Value]));

    FCep := Cep.Create;
    s := TJson.ObjectToJsonString(Result);


    FCep := TJson.JsonToObject<Cep>(TJson.ObjectToJsonString(Result));
    s := FCep.ClassName;
    Result := T(FDB.Add( FCEP ));
  end;

end;

end.
