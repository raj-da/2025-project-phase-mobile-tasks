import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entity/user.dart';
import '../../domain/usecase/log_in_usecase.dart';
import '../../domain/usecase/log_out_usecase.dart';
import '../../domain/usecase/sign_up_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LogInUsecase logInUsecase;
  final LogOutUsecase logOutUsecase;
  final SignUpUsecase signUpUsecase;

  AuthBloc({
    required this.logInUsecase,
    required this.logOutUsecase,
    required this.signUpUsecase,
  }) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSingUpRequested);
    on<LogOutRequested>(_onLogoutRequested);
  }

  FutureOr<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logInUsecase(
      email: event.email,
      password: event.password,
    );

    result.fold(
      (failure) => emit(AuthError(messege: failure.messege)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  FutureOr<void> _onSingUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await signUpUsecase(event.name, event.email, event.password);
    result.fold(
      (failure) => emit(AuthError(messege: failure.messege)),
      (success) => emit(SignUpSucssesState(messege: success.messege)),
    );
  }

  FutureOr<void> _onLogoutRequested(
    LogOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await logOutUsecase();
    result.fold(
      (failure) => emit(AuthError(messege: failure.messege)),
      (success) => emit(AuthInitial()),
    );
  }
}
