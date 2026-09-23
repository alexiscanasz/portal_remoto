part of 'result.dart';

/// Caso de error de [RmResult], con un [message] para mostrar
final class RmFailure<T> extends RmResult<T> {
  const RmFailure(this.message);

  final String message;
}
