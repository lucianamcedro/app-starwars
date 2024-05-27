import 'package:desafio_starwars_flutter/data/repository/auth/auth_repository.dart';
import 'package:desafio_starwars_flutter/data/usecase/auth/auth_usecase.dart';

class AuthUsecaseImp implements AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecaseImp({required this.authRepository});

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    return authRepository.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() {
    return authRepository.signOut();
  }
}
