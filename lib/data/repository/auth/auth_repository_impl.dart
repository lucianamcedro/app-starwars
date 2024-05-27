import 'package:desafio_starwars_flutter/data/repository/auth/auth_repository.dart';
import 'package:desafio_starwars_flutter/domain/core/auth_error.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseExceptionToError(e);
    } catch (e) {
      throw AuthError.serverError;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthError.serverError;
    }
  }
}

AuthError _mapFirebaseExceptionToError(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-credential':
    case 'wrong-password':
      return AuthError.invalidCredentials;
    case 'network-request-failed':
      return AuthError.networkError;
    default:
      return AuthError.serverError;
  }
}
