unit Projeto.Repository.uPokemonRepository;

interface

uses
  Projeto.View.uInterfaces,
  Projeto.Repository.UBaseRepository,
  System.Generics.Collections,
  System.Classes;

type
  TPokemonRepository<T: class, constructor> = class(TBaseRepository<T>, IRestBase<T>)
  public
    function ObterTodos: TList<T>; overload;
    function GetByCEP(const Value: string): T; overload;
    function Get: T; overload;
    constructor Create; overload;

  end;

implementation

uses
  System.SysUtils;

{ PokemonRepository }
constructor TPokemonRepository<T>.Create;
begin
  Base_URL := 'https://pokeapi.glitch.me/v1';
  inherited;
end;

function TPokemonRepository<T>.Get: T;
begin
  raise Exception.Create('Not implemented');
end;

function TPokemonRepository<T>.GetByCEP(const Value: string): T;
begin
  raise Exception.Create('Not implemented');
end;

function TPokemonRepository<T>.ObterTodos: TList<T>;
begin
  Result := GetAll('pokemon/6');
end;

end.
