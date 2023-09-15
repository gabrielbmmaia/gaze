import 'package:dartz/dartz.dart';
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
  });

  const tUser = UserModel.empty();
  const tEmail = 'email';
  const tPassword = 'password';

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
  });
}
