unit Projeto.Repository.UCepRepositoryTest;

interface

uses
  DUnitX.TestFramework,
  Projeto.Model.Dto.uCep,
  Projeto.View.uInterfaces,
  Projeto.Repository.uCepRepository;

type
  [TestFixture('Via Cep', 'Valida a consulta do cep no ViaCep')]
  UCepRepositoryTest = class
  private
    FCepRepository: IRestBase<TCepDto>;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    [TestCaseAttribute('Deve retornar um objeto CEP', '86801140')]
    [TestCaseAttribute('Não deve retornar excpetion', '')]
    [TestCaseAttribute('Não deve retornar excpetion', 'AAJHJKJHJK')]
    procedure GetCepTest(const Value: String);
  end;

implementation

uses
  System.SysUtils;

procedure UCepRepositoryTest.GetCepTest(const Value: String);
var
  FCep: TCepDto;
begin
  FCep := FCepRepository.GetByCEP(Value);
  try
    Assert.AreEqual(Value, FCep.Cep);
  finally
    if Assigned(FCep) then
      FCep.Free;
  end;

end;

procedure UCepRepositoryTest.Setup;
begin
  FCepRepository := TCepRepository<TCepDTO>.Create;
end;

procedure UCepRepositoryTest.TearDown;
begin

end;

initialization
  TDUnitX.RegisterTestFixture(UCepRepositoryTest);

end.
