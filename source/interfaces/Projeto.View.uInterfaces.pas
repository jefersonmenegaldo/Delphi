unit Projeto.View.uInterfaces;

interface

uses
  System.Generics.Collections,
  Vcl.Graphics;

type
  IRestBase<T> = interface
    ['{944D3945-CEEA-436F-A1B7-8E7A03BA97E6}']
    function ObterTodos: TList<T>; overload;
    function GetByCEP(const Value: string): T; overload;
  end;

  IRestCep<T> = interface
    ['{0EBE2816-DBD4-4B78-BD1B-9DB3FCE93E70}']
    function GetByCEP(const Value: string): T; overload;

  end;

  IImagemRepository = interface
  ['{650F4FDB-150F-4796-9580-471FC53AF974}']
    function GetImagem(const aUrl: string): TBitmap;
    function ResizeImagem(const aData: TBitmap;
                                aHeight: Integer;
                                aWidth: Integer): TBitmap;
  end;

  

implementation

end.
