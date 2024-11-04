import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';
import 'dart:developer' as developer;
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(AuthLoading());
      if (event is AuthSignUpRequest) {
        final result = await _authRepository.signUp(
          email: event.email,
          password: event.password,
          name: event.name,
        );
        if (result.user != null) {
          emit(AuthSuccess());

          developer.log('Signup success');
        } else {
          emit(AuthError(result.message ?? 'Signup Failed'));
        }
      }

      if (event is AuthSignInRequest) {
        final result = await _authRepository.signIn(
            email: event.email, password: event.password);

        if (result.user != null) {
          final user =
              await _authRepository.fetchUserData(_authRepository.userID);

          _authRepository.setUser(user!);
          emit(AuthSuccess());
          developer.log('Sign in success!. Sign in as ${user.name}');
        } else {
          emit(AuthError(result.message ?? 'Sign In Failed'));
        }
      }

      if (event is AuthSignOutRequest) {
        await _authRepository.signOut();
        emit(AuthSignOut());
        developer.log('Logging out');
      }
    });
  }
}
