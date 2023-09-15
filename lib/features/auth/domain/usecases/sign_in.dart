import 'package:equatable/equatable.dart';
import 'package:gaze/core/usecases/usecase.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';

class SignInUseCase extends UseCaseWithParams<UserModel, SignInParams> {
  const SignInUseCase(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<UserModel> call(SignInParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
