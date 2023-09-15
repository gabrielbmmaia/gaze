import 'package:dartz/dartz.dart';
import 'package:gaze/core/enums/update_user.dart';
import 'package:gaze/features/auth/domain/repositories/auth_repo.dart';
import 'package:gaze/features/auth/domain/usecases/update_user.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late UpdateUserUseCase useCase;

  setUp(() {
    repo = MockAuthRepo();
    useCase = UpdateUserUseCase(repo);
    registerFallbackValue(UpdateUserAction.fullName);
  });

  const tUseCaseParams = UpdateUserParams.empty();

  test(
    'should call [AuthRepo.updateUser] and return [Right<null>]',
    () async {
      when(() => repo.updateUser(
            action: any(named: 'action'),
            userData: any(named: 'userData'),
          )).thenAnswer((_) async => const Right(null));

      final result = await useCase(tUseCaseParams);

      expect(result, const Right<dynamic, void>(null));
      verify(() => repo.updateUser(
          action: tUseCaseParams.action,
          userData: tUseCaseParams.userData)).called(1);
      verifyNoMoreInteractions(repo);
    },
  );
}
