
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';

/*
* ResultFuture é um typedef de Future<Either<Failure, T>>
* */
abstract class AuthRepo {
  const AuthRepo();

  ResultFuture<UserModel> signIn({
    required String email,
    required String password,
  });

  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  });

  /*
  * Funcionalidade para alterar alguma informação do usuário. É necessário
  * informar o Enum desejado e o dado a ser alterado.
  * */
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });

}
