part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {}

class SignedIn extends AuthState {
  const SignedIn(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class SignedUp extends AuthState {
  const SignedUp();
}

class UserUpdated extends AuthState {
  const UserUpdated(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
