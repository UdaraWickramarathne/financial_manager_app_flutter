part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthSignUpRequest extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const AuthSignUpRequest({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [name, email, password];
}

class AuthSignInRequest extends AuthEvent {
  final String email;
  final String password;

  const AuthSignInRequest({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthSignOutRequest extends AuthEvent {}
