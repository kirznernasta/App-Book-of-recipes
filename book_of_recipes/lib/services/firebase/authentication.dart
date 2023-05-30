import 'package:firebase_auth/firebase_auth.dart';

import 'authentication_try.dart';

class Authentication {
  final _firebaseAuthentication = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuthentication.currentUser;

  Stream<User?> get authenticationStateChanged =>
      _firebaseAuthentication.authStateChanges();

  Future<AuthenticationTry> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuthentication
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthenticationTry(user: userCredential.user, errorMessage: null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return AuthenticationTry(
            user: null, errorMessage: 'The email provided is invalid.');
      } else if (e.code == 'weak-password') {
        return AuthenticationTry(
            user: null, errorMessage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return AuthenticationTry(
            user: null,
            errorMessage: 'The account already exists for that email.');
      } else {
        return AuthenticationTry(user: null, errorMessage: e.code);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendVerificationEmail() {
    final user = currentUser;
    if (user == null) throw Exception('No current user to verify!');
    return user.sendEmailVerification();
  }

  Future<AuthenticationTry> logIn({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuthentication
          .signInWithEmailAndPassword(email: email, password: password);
      return AuthenticationTry(user: userCredential.user, errorMessage: null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return AuthenticationTry(
            user: null, errorMessage: 'The email provided is invalid.');
      } else if (e.code == 'user-not-found') {
        return AuthenticationTry(
            user: null,
            errorMessage: 'There is no user corresponding to the given email.');
      } else if (e.code == 'wrong-password') {
        return AuthenticationTry(
            user: null, errorMessage: 'The password provided is wrong.');
      } else {
        return AuthenticationTry(user: null, errorMessage: e.code);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProfile({
    required String image,
    required String username,
  }) async {
    final user = currentUser;
    if (user != null) {
      await user.updateDisplayName(username);
      await user.updatePhotoURL(image);
    }
  }
}
