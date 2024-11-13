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
      if (event is AuthSignUpRequest) {
        emit(AuthLoading());
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
        emit(AuthLoading());
        final result = await _authRepository.signIn(
            email: event.email, password: event.password);

        if (result.user != null) {
          final userDetails =
              await _authRepository.fetchUserData(_authRepository.userID);

          await _authRepository.setUser(userDetails!);
          while (_authRepository.user == null) {
            await _authRepository.setUser(userDetails);
          }
          emit(AuthSuccess());
          developer.log(
              'Sign in success!. Sign in as ${_authRepository.user!.name}');
        } else {
          emit(AuthError(result.message ?? 'Sign In Failed'));
        }
      }

      if (event is AuthSignOutRequest) {
        emit(AuthLoading());
        await _authRepository.signOut();
        emit(AuthSignOut());
        developer.log('Logging out');
      }

      if (event is AuthChangePasswordEvent) {
        emit(AuthChangePasswordLoading());
        final result = await _authRepository.chnagePassword(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        );
        if (result.message == 'success') {
          emit(AuthChangePasswordSuccess());
        } else {
          emit(AuthChangePasswordError(
              result.message ?? 'Password change Error!'));
        }
      }
    });
  }
}
