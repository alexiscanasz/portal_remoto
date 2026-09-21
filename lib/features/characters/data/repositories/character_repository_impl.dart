import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../datasources/character_remote_datasource.dart';

/// Implementacion de [RmCharactersRepository] que obtiene los datos de la api
/// de rick and morty y traduce los errores de red a un [RmFailure]
final class RmCharactersRepositoryImpl implements RmCharactersRepository {
  RmCharactersRepositoryImpl({required this.characterRemoteDatasource});

  final RmCharacterRemoteDatasource characterRemoteDatasource;

  @override
  Future<RmResult<RmCharactersPage>> getAll({String? name, int page = 1}) async {
    try {
      final result = await characterRemoteDatasource.getAll(name: name, page: page);
      return RmSuccess(result);
    } catch (_) {
      return const RmFailure('Could not load characters');
    }
  }

  @override
  Future<RmResult<RmCharacterEntity>> getById(int id) async {
    try {
      final character = await characterRemoteDatasource.getById(id);
      return RmSuccess(character);
    } catch (_) {
      return const RmFailure('Could not load character');
    }
  }
}
