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
    [TestCaseAttribute('Deve retornar um objeto CEP', '17560246')]
    [TestCaseAttribute('Deve retornar um objeto CEP', '88056000')]
    procedure GetCepTest(const Value: String);

    [Test]
    [TestCaseAttribute('Deve retornar uma exception', 'AAJHJKJHJK')]
    [TestCaseAttribute('Não deve retornar exception', '')]
    procedure GetCepInvalidTest(const Value: String);
  end;

implementation

uses
  System.SysUtils,
  utils.uExceptions;

procedure UCepRepositoryTest.GetCepInvalidTest(const Value: String);
begin
  Assert
    .WillRaise(
    procedure
    begin
      FCepRepository.GetByCEP(Value);
    end,
    EGetStatusCode,
    'Deve retornar uma exceção do tipo: EGetStatusCode'
    );
end;

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
