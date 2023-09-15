import 'package:dartz/dartz.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late SignInUseCase useCase;

  setUp(() {
    repo = MockAuthRepo();
    useCase = SignInUseCase(repo);
  });

  const tUser = UserModel.empty();
  const tEmail = '';
  const tPassword = '';

  test(
    'should call [AuthRepo.signIn] and return [Right<User>]',
    () async {
      when(() => repo.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'))).thenAnswer(
        (_) async => const Right(tUser),
      );

      final result = await useCase(const SignInParams(
        email: tEmail,
        password: tPassword,
      ));

      expect(result, const Right<dynamic, UserModel>(tUser));
      verify(() => repo.signIn(email: tEmail, password: tPassword)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
