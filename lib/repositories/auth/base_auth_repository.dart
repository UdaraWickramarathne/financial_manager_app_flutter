import 'package:firebase_auth/firebase_auth.dart' as auth;

abstract class BaseAuthRepository {
  Stream<auth.User?> get userStream;

  String get userID;

  auth.User? get currentUser;

  Future<auth.User?> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<auth.User> signIn({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
