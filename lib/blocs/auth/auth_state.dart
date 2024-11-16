part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthChangePasswordLoading extends AuthState {}

final class AuthChangePasswordSuccess extends AuthState {}

final class AuthChangePasswordError extends AuthState {
  final String message;

  const AuthChangePasswordError(this.message);

  @override
  List<Object> get props => [message];
}

final class AuthInfoLoading extends AuthState {}

final class AuthInfoSuccess extends AuthState {
  final String name;

  const AuthInfoSuccess({required this.name});

  @override
  List<Object> get props => [name];
}

final class AuthInfoError extends AuthState {
  final String message;

  const AuthInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
