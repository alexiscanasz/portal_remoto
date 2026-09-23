import '../../../../core/core.dart';
import '../entities/character_entity.dart';
import '../repositories/characters_repository.dart';

/// Caso de uso que obtiene el detalle de un personaje por su id
final class RmGetCharacterDetailUseCase {
  RmGetCharacterDetailUseCase({required RmCharactersRepository repository})
    : _repository = repository;

  final RmCharactersRepository _repository;

  Future<RmResult<RmCharacterEntity>> call(int id) => _repository.getById(id);
}
