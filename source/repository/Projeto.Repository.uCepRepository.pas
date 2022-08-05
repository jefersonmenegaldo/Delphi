unit Projeto.Repository.uCepRepository;

interface

uses
  Projeto.View.uInterfaces,
  System.Generics.Collections,
  Projeto.Repository.uBaseRepository,
  System.Classes;

type
  TCepRepository<T: class, constructor> = class(TBaseRepository<T>, IRestBase<T>)
  public
    function ObterTodos: TList<T>; overload;
    function GetByCEP(const Value: string): T; overload;
    //function GetByCep(const Value: String): T;

    constructor Create; overload;

  end;

implementation

uses
  System.SysUtils;

{ PokemonRepository }
constructor TCepRepository<T>.Create;
begin
  Base_URL := 'viacep.com.br/ws/';
  inherited;
end;

function TCepRepository<T>.ObterTodos: TList<T>;
begin
 //
end;

function TCepRepository<T>.GetByCEP(const Value: string): T;
begin
  Result := Get(Format('%s/json/',[Value]));
end;

end.
