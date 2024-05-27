import 'package:desafio_starwars_flutter/data/usecase/auth/auth.dart';
import 'package:desafio_starwars_flutter/domain/core/auth_error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase authUsecase;

  AuthCubit({
    required this.authUsecase,
  }) : super(AuthInitial());

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());

    try {
      await authUsecase.signInWithEmailAndPassword(email, password);
      emit(AuthSuccess());
    } catch (error) {
      if (error is AuthError) {
        final mensagemDeErro = AuthErrorMessage(error).message;
        emit(AuthFailed(error: mensagemDeErro));
      }
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    try {
      await authUsecase.signOut();
      emit(AuthLoggedOut());
    } catch (error) {
      if (error is AuthError) {
        final mensagemDeErro = AuthErrorMessage(error).message;
        emit(AuthFailed(error: mensagemDeErro));
      }
    }
  }
}
