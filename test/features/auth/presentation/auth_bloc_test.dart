import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/usecases/sign_in.dart';
import 'package:gaze/features/auth/domain/usecases/sign_up.dart';
import 'package:gaze/features/auth/domain/usecases/update_user.dart';
import 'package:gaze/features/auth/presentation/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSignInUseCase extends Mock implements SignInUseCase {}

class MockSignUpUseCase extends Mock implements SignUpUseCase {}

class MockUpdateUserUseCase extends Mock implements UpdateUserUseCase {}

void main() {
  late SignInUseCase signIn;
  late SignUpUseCase signUp;
  late UpdateUserUseCase updateUser;
  late AuthBloc bloc;

  setUp(() {
    signIn = MockSignInUseCase();
    signUp = MockSignUpUseCase();
    updateUser = MockUpdateUserUseCase();
    bloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      updateUser: updateUser,
    );
  });

  const tUser = UserModel.empty();
  const tSigInParams = SignInParams.empty();
  const tSigUpParams = SignUpParams.empty();
  const tUpdateUserParams = UpdateUserParams.empty();

  setUpAll(() {
    registerFallbackValue(tSigInParams);
    registerFallbackValue(tSigUpParams);
    registerFallbackValue(tUpdateUserParams);
  });

  tearDown(() => bloc.close());

  test(
    'initialState should be [AuthInitial]',
    () {
      expect(bloc.state, const AuthInitial());
    },
  );

  group('signInEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignIn] when [SignInEvent] is added',
      build: () {
        when(() => signIn(any())).thenAnswer((_) async => const Right(tUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSigInParams.email,
          password: tSigInParams.password,
        ),
      ),
      expect: () => const <AuthState>[AuthLoading(), SignedIn(tUser)],
      verify: (_) {
        verify(() => signIn(tSigInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });
}
