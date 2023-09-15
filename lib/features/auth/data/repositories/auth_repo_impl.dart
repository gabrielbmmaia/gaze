import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.signIn(
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      await _remoteDataSource.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> updateUser({
    required UpdateUserAction action,
    required dynamic userData,
  }) async {
    try {
      await _remoteDataSource.updateUser(
        action: action,
        userData: userData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
