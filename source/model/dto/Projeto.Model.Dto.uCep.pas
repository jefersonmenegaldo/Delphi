unit Projeto.Model.Dto.uCep;

interface
 (*
 {
    "cep": "01001-000",
    "logradouro": "Praça da Sé",
    "complemento": "lado ímpar",
    "bairro": "Sé",
    "localidade": "São Paulo",
    "uf": "SP",
    "ibge": "3550308",
    "gia": "1004",
    "ddd": "11",
    "siafi": "7107"
  }
  *)
type
  TCepDTO = class
  private
    FCep: String;
    FLogradouro: String;
    FComplemento: String;
    FBairro: String;
    FLocalidade: String;
    FUf: String;
    FIbge: String;
    FGia: String;
    FDDD: String;
    FSiafi: String;


    function GetCep: String;
  public
    property Cep: String read GetCep write FCep;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Localidade: String read FLocalidade write FLocalidade;
    property Uf: String read FUf write FUf;
    property Ibge: String read FIbge write FIbge;
    property Gia: String read FGia write FGia;
    property DDD: String read FDDD write FDDD;
    property Siafi: String read FSiafi write FSiafi;
  end;

implementation

uses
  System.SysUtils;

{ TCepDTO }

function TCepDTO.GetCep: String;
begin
  Result := StringReplace(FCep, '-', '', [rfReplaceAll, rfIgnoreCase]);
end;

end.
