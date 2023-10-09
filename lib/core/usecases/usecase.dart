import 'package:gaze/core/utils/typedefs.dart';

/// É necessário enviar via genérics o tipo de retorno e tipo do parametro
/// do UseCase.
/// O Retorno será enviado como Future<Either<Failure, Type>>
abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();

  // Padronizar para que todos tenham a chamada call
  ResultFuture<Type> call(Params params);
}

/// É necessário enviar via genérics o tipo de retorno do UseCase.
/// O Retorno será enviado como Future<Either<Failure, Type>>
abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}

/// É necessário enviar via genérics o tipo de retorno do UseCase.
/// O Retorno será enviado como Stream<Type>
abstract class StreamUseCaseWithoutParams<Type> {
  const StreamUseCaseWithoutParams();

  Stream<Type> call();
}
