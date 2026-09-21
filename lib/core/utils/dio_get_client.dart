import 'package:dio/dio.dart';

/// Utilidad transversal para hacer peticiones GET
final class RmDioGetClient {
  const RmDioGetClient(this._dio);

  final Dio _dio;

  Future<Response<Map<String, dynamic>>> get(String path, {Map<String, dynamic>? queryParameters}) {
    return _dio.get<Map<String, dynamic>>(path, queryParameters: queryParameters);
  }
}
