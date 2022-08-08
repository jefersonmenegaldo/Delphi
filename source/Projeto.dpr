program Projeto;

uses
  Vcl.Forms,
  Projeto.View.uPrincipal in 'view\Projeto.View.uPrincipal.pas' {FrmPrincipal},
  Projeto.View.uInterfaces in 'interfaces\Projeto.View.uInterfaces.pas',
  Projeto.Model.Dto.uPokemon in 'model\dto\Projeto.Model.Dto.uPokemon.pas',
  Projeto.Model.Dto.uFamily in 'model\dto\Projeto.Model.Dto.uFamily.pas',
  Projeto.Model.Dto.uAbilities in 'model\dto\Projeto.Model.Dto.uAbilities.pas',
  Projeto.Repository.uPokemonRepository in 'repository\Projeto.Repository.uPokemonRepository.pas',
  Projeto.Repository.UBaseRepository in 'repository\Projeto.Repository.UBaseRepository.pas',
  Projeto.Repository.uImagemRepository in 'repository\Projeto.Repository.uImagemRepository.pas',
  Projeto.Model.Dto.uCep in 'model\dto\Projeto.Model.Dto.uCep.pas',
  Projeto.Repository.uCepRepository in 'repository\Projeto.Repository.uCepRepository.pas',
  Projeto.Model.uCep in 'model\Projeto.Model.uCep.pas',
  Projeto.Dao.uBaseDAO in 'dao\Projeto.Dao.uBaseDAO.pas',
  Projeto.Dao.uConnection in 'dao\Projeto.Dao.uConnection.pas',
  Utils.UExceptions in 'utils\utils.UExceptions.pas';

{$R *.res}

begin

  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;


end.
