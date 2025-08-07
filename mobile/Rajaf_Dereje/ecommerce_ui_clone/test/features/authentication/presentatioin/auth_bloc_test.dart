import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_ui_clone/core/error/failures.dart';
import 'package:ecommerce_ui_clone/core/success/success.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/entity/user.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/usecase/log_in_usecase.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/usecase/log_out_usecase.dart';
import 'package:ecommerce_ui_clone/features/authentication/domain/usecase/sign_up_usecase.dart';
import 'package:ecommerce_ui_clone/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([LogInUsecase, LogOutUsecase, SignUpUsecase])
void main() {
  late MockLogInUsecase mockLogInUsecase;
  late MockLogOutUsecase mockLogOutUsecase;
  late MockSignUpUsecase mockSignUpUsecase;
  late AuthBloc authBloc;

  setUp(() {
    mockLogInUsecase = MockLogInUsecase();
    mockLogOutUsecase = MockLogOutUsecase();
    mockSignUpUsecase = MockSignUpUsecase();
    authBloc = AuthBloc(
      logInUsecase: mockLogInUsecase,
      logOutUsecase: mockLogOutUsecase,
      signUpUsecase: mockSignUpUsecase,
    );
  });

  const id = 'id';
  const testname = 'test';
  const testEmail = 'test@example.com';
  const testPassword = 'password123';

  final testUser = const User(id: id, email: testEmail, name: testname);

  group('LoginRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] on successful login',
      build: () {
        when(
          mockLogInUsecase(email: testEmail, password: testPassword),
        ).thenAnswer((_) async => Right(testUser));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const LoginRequested(email: testEmail, password: testPassword),
      ),
      expect: () => [AuthLoading(), AuthAuthenticated(testUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on login failure',
      build: () {
        when(
          mockLogInUsecase(email: testEmail, password: testPassword),
        ).thenAnswer((_) async => const Left(ServerFailure()));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const LoginRequested(email: testEmail, password: testPassword),
      ),
      expect: () => [AuthLoading(), const AuthError(messege: 'Login failed')],
    );
  }); // log in request group

  group('SignupRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] on successful signup',
      build: () {
        when(
          mockSignUpUsecase(testname, testEmail, testPassword),
        ).thenAnswer((_) async => const Right(SignUpSucess()));
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const SignUpRequested(
          name: testname,
          email: testEmail,
          password: testPassword,
        ),
      ),
      expect: () => [
        AuthLoading(),
        const SignUpSucssesState(messege: 'Sign Up successful'),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] on signup failure',
      build: () {
        when(mockSignUpUsecase(testname, testEmail, testPassword)).thenAnswer(
          (_) async => const Left(ServerFailure()),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(
        const SignUpRequested(
          name: testname,
          email: testEmail,
          password: testPassword,
        ),
      ),
      expect: () => [AuthLoading(), const AuthError(messege: 'Signup failed')],
    );
  }); // sign up group

   group('LogoutRequested', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthInitial] when logout is requested',
      build:  () {
        when(mockLogOutUsecase()).thenAnswer(
          (_) async => const Right(LogOutSuccess()),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutRequested()),
      expect: () => [AuthLoading(),AuthInitial()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading,AuthError] when logout is requested',
      build:  () {
        when(mockLogOutUsecase()).thenAnswer(
          (_) async => const Left(LogOutFailure()),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(LogOutRequested()),
      expect: () => [AuthLoading(),const AuthError(messege: 'Log out failed')],
    );
  });
}
