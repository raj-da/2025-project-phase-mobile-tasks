part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  const AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthError extends AuthState {
  final String messege;
  const AuthError({required this.messege});
}

class LogOut extends AuthState {}

class SignUpSucssesState extends AuthState {
  final String messege;
  const SignUpSucssesState({required this.messege});

  @override
  List<Object> get props => [messege];
}
