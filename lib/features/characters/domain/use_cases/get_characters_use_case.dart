import '../../../../core/core.dart';
import '../entities/characters_page.dart';
import '../repositories/characters_repository.dart';

/// Obtiene un listado de personajes, filtrando opcionalmente por [name] e inicialmente
/// consultando la primera pagina a menos que se indique la pagina a solicitar
final class RmGetCharactersUseCase {
  RmGetCharactersUseCase({required RmCharactersRepository repository}) : _repository = repository;

  final RmCharactersRepository _repository;

  Future<RmResult<RmCharactersPage>> call({String? name, int page = 1}) =>
      _repository.getAll(name: name, page: page);
}
