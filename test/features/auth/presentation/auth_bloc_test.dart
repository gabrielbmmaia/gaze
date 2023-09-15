import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:gaze/core/errors/failures.dart';
import 'package:gaze/features/auth/domain/models/user_model.dart';
import 'package:gaze/features/auth/domain/usecases/sign_in.dart';
import 'package:gaze/features/auth/domain/usecases/sign_up.dart';
import 'package:gaze/features/auth/domain/usecases/update_user.dart';
import 'package:gaze/features/auth/presentation/bloc/auth_bloc.dart';
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
  final tServerFailure = ServerFailure(
    message: 'Test Failure',
    statusCode: 505,
  );

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
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [SignInEvent] is '
      'added unsuccessful',
      build: () {
        when(() => signIn(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInEvent(
          email: tSigInParams.email,
          password: tSigInParams.password,
        ),
      ),
      expect: () => <AuthState>[
        const AuthLoading(),
        AuthError(
          tServerFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(() => signIn(tSigInParams)).called(1);
        verifyNoMoreInteractions(signIn);
      },
    );
  });

  group('signUpEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, SignedUp] when [SignUpEvent] is added',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSigUpParams.email,
          password: tSigUpParams.password,
          fullName: tSigUpParams.fullName,
        ),
      ),
      expect: () => const <AuthState>[AuthLoading(), SignedUp()],
      verify: (_) {
        verify(() => signUp(tSigUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [SignUpEvent] is '
      'added unsuccessful',
      build: () {
        when(() => signUp(any())).thenAnswer((_) async => Left(tServerFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignUpEvent(
          email: tSigUpParams.email,
          password: tSigUpParams.password,
          fullName: tSigUpParams.fullName,
        ),
      ),
      expect: () => <AuthState>[
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => signUp(tSigUpParams)).called(1);
        verifyNoMoreInteractions(signUp);
      },
    );
  });

  group('updateUserEvent', () {
    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, UserUpdated] when [UpdateUserEvent] is added',
      build: () {
        when(() => updateUser(any())).thenAnswer(
          (_) async => const Right(null),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          userData: tUpdateUserParams.userData,
        ),
      ),
      expect: () => const <AuthState>[AuthLoading(), UserUpdated()],
      verify: (_) {
        verify(() => updateUser(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthLoading, AuthError] when [UpdateUserEvent] is '
      'added unsuccessful',
      build: () {
        when(() => updateUser(any())).thenAnswer(
          (_) async => Left(tServerFailure),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: tUpdateUserParams.action,
          userData: tUpdateUserParams.userData,
        ),
      ),
      expect: () => <AuthState>[
        const AuthLoading(),
        AuthError(tServerFailure.errorMessage)
      ],
      verify: (_) {
        verify(() => updateUser(tUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });
}
