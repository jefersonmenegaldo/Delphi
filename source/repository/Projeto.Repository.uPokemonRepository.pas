unit Projeto.Repository.uPokemonRepository;

interface

uses
  Projeto.View.uInterfaces,
  Projeto.Repository.UBaseRepository,
  System.Generics.Collections,
  System.Classes;

type
  TPokemonRepository<T: class, constructor> = class(TBaseRepository<T>,IRestBase<T>)
  public
    function GetAll: TList<T>; overload;
  end;

implementation

{ PokemonRepository }
function TPokemonRepository<T>.GetAll: TList<T>;
begin
  Result := Execute('pokemon/6');
end;

end.
