import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:financial_app/repositories/auth/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthSignUpRequest) {
        try {
          final user = await _authRepository.signUp(
            email: event.email,
            password: event.password,
            name: event.name,
          );
          if (user != null) {
            emit(AuthSuccess());
          } else {
            emit(const AuthError('Signup Failed'));
          }
        } catch (e) {
          emit(AuthError(e.toString()));
        }
      }
    });
  }
}
