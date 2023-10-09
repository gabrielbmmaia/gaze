import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/series/data/models/series_entity.dart';
import 'package:gaze/features/series/domain/models/series_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepo repo;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repo = AuthRepoImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.email);
    registerFallbackValue(const SeriesEntity.empty());
  });

  const tUser = UserModel.empty();
  const tEmail = 'email';
  const tPassword = 'password';
  const tFullName = 'fullName';
  const tUserData = 'userData';
  const tUpdateAction = UpdateUserAction.email;
  const tServerException = ServerException(message: '', statusCode: '');

  group('signIn', () {
    test(
      'should call [AuthRemoteDataSource.signIn] and return [UserModel] '
      'when call to remote source is successful',
      () async {
        when(
          () => remoteDataSource.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUser);

        final result = await repo.signIn(
          email: tEmail,
          password: tPassword,
        );

        expect(result, const Right<dynamic, UserModel>(tUser));
        verify(
          () => remoteDataSource.signIn(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
        'should call [AuthRemoteDataSource.signIn] and return [ServerFailure] '
        'when the call is unsuccessful', () async {
      when(
        () => remoteDataSource.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(tServerException);

      final result = await repo.signIn(
        email: tEmail,
        password: tPassword,
      );

      expect(
        result,
        Left<ServerFailure, dynamic>(
          ServerFailure.fromException(tServerException),
        ),
      );
      verify(
        () => remoteDataSource.signIn(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });

  group('signUp', () {
    test(
      'should call [AuthRemoteDataSource.signUp] and return [void] when '
      'the call is successful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            fullName: any(named: 'fullName'),
          ),
        ).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repo.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(result, const Right<dynamic, void>(null));
        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            fullName: tFullName,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should call [AuthRemoteDataSource] and return [ServerFailure] when '
      'the call is unsuccessful',
      () async {
        when(
          () => remoteDataSource.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
            fullName: any(named: 'fullName'),
          ),
        ).thenThrow(tServerException);

        final result = await repo.signUp(
          email: tEmail,
          fullName: tFullName,
          password: tPassword,
        );

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource.signUp(
            email: tEmail,
            password: tPassword,
            fullName: tFullName,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('updateUser', () {
    test(
      'should call [AuthRemoteDataSource.updateUser] and return void when '
      'the call is successful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<dynamic>(named: 'userData'),
          ),
        ).thenAnswer((_) async => Future.value());

        final result = await repo.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        );

        expect(result, const Right<dynamic, void>(null));
        verify(
          () => remoteDataSource.updateUser(
              action: tUpdateAction, userData: tUserData),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should call [AuthRemoteDataSource.updateUser] and return [ServerFailure] '
      'when the call to remote data source is unsuccessful',
      () async {
        when(
          () => remoteDataSource.updateUser(
            action: any(named: 'action'),
            userData: any<dynamic>(named: 'userData'),
          ),
        ).thenThrow(tServerException);

        final result = await repo.updateUser(
          action: tUpdateAction,
          userData: tUserData,
        );

        expect(
          result,
          Left<ServerFailure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource.updateUser(
            action: tUpdateAction,
            userData: tUserData,
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('addFavoriteItem', () {
    test(
      'should call [AuthRemoteDataSource.addFavoriteItem] and return [true] when '
      'the call is successful',
      () async {
        when(() => remoteDataSource.addFavoriteItem(item: any(named: 'item')))
            .thenAnswer((_) async => true);

        final result = await repo.addFavoriteItem(
          item: const SeriesModel.empty(),
        );

        expect(result, const Right<dynamic, bool>(true));
        verify(
          () => remoteDataSource.addFavoriteItem(
            item: const SeriesEntity.empty(),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should call [AuthRemoteDataSource.addFavoriteItem] and return '
      '[ServerFailure] when the call to remote data source is unsuccessful',
      () async {
        when(() => remoteDataSource.addFavoriteItem(item: any(named: 'item')))
            .thenThrow(tServerException);

        final result = await repo.addFavoriteItem(
          item: const SeriesModel.empty(),
        );

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource.addFavoriteItem(
            item: const SeriesEntity.empty(),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('removeFavoriteItem', () {
    test(
      'should call [AuthRemoteDataSource.removeFavoriteItem] and return '
      '[false] when the call is successful',
      () async {
        when(() => remoteDataSource.removeFavoriteItem(item: any(named: 'item')))
            .thenAnswer((_) async => false);

        final result = await repo.removeFavoriteItem(
          item: const SeriesModel.empty(),
        );

        expect(result, const Right<dynamic, bool>(false));
        verify(
          () => remoteDataSource.removeFavoriteItem(
            item: const SeriesEntity.empty(),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should call [AuthRemoteDataSource.addFavoriteItem] and return '
      '[ServerFailure] when the call to remote data source is unsuccessful',
      () async {
        when(() => remoteDataSource.removeFavoriteItem(item: any(named: 'item')))
            .thenThrow(tServerException);

        final result = await repo.removeFavoriteItem(
          item: const SeriesModel.empty(),
        );

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource.removeFavoriteItem(
            item: const SeriesEntity.empty(),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group('isFavoriteItem', () {
    test(
      'should call [AuthRemoteDataSource.isFavoriteItem] and return '
      '[Right<bool>] when the call is successful',
      () async {
        when(() => remoteDataSource.isFavoriteItem(item: any(named: 'item')))
            .thenAnswer((_) async => true);

        final result = await repo.isFavoriteItem(
          item: const SeriesModel.empty(),
        );

        expect(result, const Right<dynamic, bool>(true));
        verify(
          () => remoteDataSource.isFavoriteItem(
            item: const SeriesEntity.empty(),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should call [AuthRemoteDataSource.isFavoriteItem] and return '
      '[ServerFailure] when the call to remote data source is unsuccessful',
      () async {
        when(() => remoteDataSource.isFavoriteItem(item: any(named: 'item')))
            .thenThrow(tServerException);

        final result = await repo.isFavoriteItem(
          item: const SeriesModel.empty(),
        );

        expect(
          result,
          Left<Failure, dynamic>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(
          () => remoteDataSource.isFavoriteItem(
            item: const SeriesEntity.empty(),
          ),
        ).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
