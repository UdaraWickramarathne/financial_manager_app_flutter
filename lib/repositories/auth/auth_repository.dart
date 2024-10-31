import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_app/models/user.dart';
import 'package:financial_app/repositories/auth/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  @override
  Stream<auth.User?> get userStream => _firebaseAuth.userChanges();
  Stream<auth.User?> get userState => _firebaseAuth.authStateChanges();

  @override
  auth.User? get currentUser => auth.FirebaseAuth.instance.currentUser;

  @override
  String get userID => _firebaseAuth.currentUser?.uid ?? '';

  @override
  Future<auth.User> signIn({required String email, required String password}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    throw UnimplementedError();
  }

  @override
  Future<auth.User?> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final creadential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      auth.User? user = creadential.user;

      if (user != null) {
        User newUser = User(
          userID: user.uid,
          name: name,
          email: email,
          createdAt: Timestamp.now(),
        );
        _addUserIfNotExists(newUser);
      }
      return user;
    } catch (e) {
      print('error signup');
      return null;
    }
  }

  Future<void> _addUserIfNotExists(User newUser) async {
    var doc = await _users.doc(newUser.userID).get();

    if (!doc.exists) {
      await _users.doc(newUser.userID).set(newUser.toJson());
    }
  }
}
