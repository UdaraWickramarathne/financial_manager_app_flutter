import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:financial_app/models/user.dart';
import 'package:financial_app/repositories/auth/auth_result.dart';
import 'package:financial_app/repositories/auth/base_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'dart:developer' as dev;

class AuthRepository extends BaseAuthRepository {
  final auth.FirebaseAuth _firebaseAuth;
  final CollectionReference _usersCollection =
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
  Future<AuthResult> signUp(
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
        await _addUserIfNotExists(newUser);
      }
      return AuthResult(user: user);
    } on auth.FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          errorMessage = 'The account already exists for that email.';
          break;
        default:
          errorMessage =
              'An unexpected error occurred. Please try again later.';
      }
      return AuthResult(message: errorMessage);
    } catch (e) {
      return AuthResult(message: 'An unknown error occurred during sign-up.');
    }
  }

  //method for signIn user

  @override
  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    try {
      final creadential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      auth.User? user = creadential.user;

      return AuthResult(user: user);
    } on auth.FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Invalid credentials. Try again!';
          break;
        case 'user-not-found':
          errorMessage = 'No user found for this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password provided.';
          break;
        default:
          errorMessage =
              'An unexpected error occurred. Please try again later.';
      }
      return AuthResult(message: errorMessage);
    } catch (e) {
      return AuthResult(message: 'An unknown error occurred during sign-in.');
    }
  }

  //method for signOut user

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      dev.log(e.toString());
    }
  }

  Future<void> _addUserIfNotExists(User newUser) async {
    var doc = await _usersCollection.doc(newUser.userID).get();

    if (!doc.exists) {
      await _usersCollection.doc(newUser.userID).set(newUser.toJson());
    }
  }

  Future<User?> fetchUserData(String userID) async {
    try {
      DocumentSnapshot doc = await _usersCollection.doc(userID).get();
      if (doc.exists) {
        return User.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      dev.log(e.toString());
    }
    return null;
  }

  @override
  Future<AuthResult> chnagePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      if (currentUser != null) {
        auth.AuthCredential credential = auth.EmailAuthProvider.credential(
          email: currentUser!.email!,
          password: currentPassword,
        );
        await currentUser!.reauthenticateWithCredential(credential);
        await currentUser!.updatePassword(newPassword);
        await currentUser!.reload();

        return AuthResult(message: 'success');
      }
      return AuthResult(message: 'Password Change Error!');
    } on auth.FirebaseAuthException catch (e) {
      String errorMessage;
      dev.log(e.code);
      switch (e.code) {
        case 'invalid-credential':
          errorMessage = 'Incorrect current password!';
          break;
        case 'weak-password':
          errorMessage = 'Password must have 6 characters';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password provided.';
          break;
        default:
          errorMessage =
              'An unexpected error occurred. Please try again later.';
      }
      return AuthResult(message: errorMessage);
    } catch (e) {
      dev.log(e.toString());
      return AuthResult(message: 'Password Change Error!');
    }
  }

  @override
  Future<void> updateUser(User user) async {
    try {
      await _usersCollection.doc(user.userID).update(user.toJson());
    } catch (e) {
      throw Exception('Error updating user: $e');
    }
  }
}
