import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gaze/core/errors/exceptions.dart';

/// Classe criada para servir como estado de error de um [Either]
abstract class Failure extends Equatable {
  Failure({
    required this.message,
    required this.statusCode,
  }) : assert(
          statusCode is int || statusCode is String,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;

  // status code dynamic por conta do Firebase.
  final dynamic statusCode;

  String get errorMessage =>
      '$statusCode ${statusCode is String ? '' : 'Error:'} $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

/// Failure utilizado em conexões externas com servidores como APIs e Firebase
class ServerFailure extends Failure {
  ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
