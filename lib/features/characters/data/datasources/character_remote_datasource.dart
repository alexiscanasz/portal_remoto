import 'package:dio/dio.dart';

import '../../../../core/core.dart';
import '../../domain/domain.dart';
import '../models/character_model.dart';

abstract interface class RmCharacterRemoteDatasource {
  Future<RmCharactersPage> getAll({String? name, int page = 1});
  Future<RmCharacterModel> getById(int id);
}

// el nombre "limpio" sin el sufijo "Impl" ya esta tomado por la interfaz de arriba
final class RmCharacterRemoteDatasourceImpl implements RmCharacterRemoteDatasource {
  RmCharacterRemoteDatasourceImpl({required Dio dio}) : _client = RmDioGetClient(dio);

  final RmDioGetClient _client;

  @override
  Future<RmCharactersPage> getAll({String? name, int page = 1}) async {
    try {
      final resp = await _client.get(
        RmApiConstants.charactersEndpoint,
        queryParameters: {if (name != null && name.isNotEmpty) 'name': name, 'page': page},
      );

      final body = resp.data ?? const {};
      final characters = RmCharacterModel.listFromJson(body);
      final hasNext = body['info']?['next'] != null;
      return RmCharactersPage(characters: characters, hasNext: hasNext);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return const RmCharactersPage(characters: [], hasNext: false);
      }
      rethrow;
    }
  }

  @override
  Future<RmCharacterModel> getById(int id) async {
    final resp = await _client.get('${RmApiConstants.charactersEndpoint}/$id');

    return RmCharacterModel.fromJson(resp.data ?? const {});
  }
}
