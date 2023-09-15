import 'package:dartz/dartz.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/sign_up.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late SignUpUseCase useCase;

  setUp(() {
    repo = MockAuthRepo();
    useCase = SignUpUseCase(repo);
  });

  const tSignUpParams = SignUpParams.empty();

  test(
    'should call [AuthRepo.signUp] and return [Right<null>]',
    () async {
      when(() => repo.signUp(
              email: any(named: 'email'),
              fullName: any(named: 'fullName'),
              password: any(named: 'password')))
          .thenAnswer((_) async => const Right(null));

      final result = await useCase(tSignUpParams);

      expect(result, const Right<dynamic, void>(null));
      verify(() => repo.signUp(
            email: tSignUpParams.email,
            fullName: tSignUpParams.fullName,
            password: tSignUpParams.password,
          )).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
