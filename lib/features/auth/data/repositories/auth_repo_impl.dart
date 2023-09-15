
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<UserModel> signIn({required String email, required String password}) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> signUp({required String email, required String fullName, required String password}) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  ResultFuture<void> updateUser({required UpdateUserAction action, required userData}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

}