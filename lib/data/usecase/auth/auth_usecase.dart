abstract class AuthUsecase {
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}
