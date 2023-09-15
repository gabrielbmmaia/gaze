import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<UserModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  });

  Future<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  });
}
