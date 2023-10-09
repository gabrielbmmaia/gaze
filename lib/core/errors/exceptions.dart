import 'package:equatable/equatable.dart';

/// [Exception] personalizada do aplicativo. Deverá ser arremeçada em todos
/// casos de error em conexão com servidores externos como APIS e Firebase
class ServerException extends Equatable implements Exception {
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  final String message;
  final String statusCode;

  @override
  List<String> get props => [message, statusCode];
}
