import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/core/utils/typedefs.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/series/data/mappers/series_mapper.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';

class AuthRepoImpl implements AuthRepo {
  AuthRepoImpl(this._remoteDataSource) : mapper = SeriesMapper();

  final AuthRemoteDataSource _remoteDataSource;
  final SeriesMapper mapper;

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

  @override
  ResultFuture<bool> addFavoriteItem({required SeriesModel item}) async {
    try {
      await _remoteDataSource.addFavoriteItem(item: mapper.toData(item));
      return const Right(true);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> removeFavoriteItem({required SeriesModel item}) async {
    try {
      await _remoteDataSource.removeFavoriteItem(item: mapper.toData(item));
      return const Right(false);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> isFavoriteItem({required SeriesModel item}) async {
    try {
      final result = await _remoteDataSource.isFavoriteItem(
        item: mapper.toData(item),
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  Stream<List<SeriesModel>> getFavoriteListStream() =>
      _remoteDataSource.getFavoriteListStream();
}
