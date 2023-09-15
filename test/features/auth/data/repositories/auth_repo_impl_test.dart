import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/core/errors/exceptions.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:gaze/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRemoteDataSource remoteDataSource;
  late AuthRepo repo;

  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repo = AuthRepoImpl(remoteDataSource);
    registerFallbackValue(UpdateUserAction.password);
  });

  const tUser = UserModel.empty();
  const tEmail = 'email';
  const tPassword = 'password';
  const tFullName = 'fullName';
  const tUserData = 'userData';
  const tUpdateAction = UpdateUserAction.password;
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
        verify(() => remoteDataSource.signUp(
              email: tEmail,
              password: tPassword,
              fullName: tFullName,
            )).called(1);
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
  });
}
