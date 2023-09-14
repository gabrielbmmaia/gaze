import 'package:equatable/equatable.dart';

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
}
