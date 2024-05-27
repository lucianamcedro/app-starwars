import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth _auth;

  RegisterCubit({required FirebaseAuth auth})
      : _auth = auth,
        super(RegisterInitial());

  Future<void> registerUser(String email, String password) async {
    emit(RegisterLoading());

    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(RegisterSuccess());
    } catch (e) {
      final message = e.toString();

      emit(RegisterFailed(error: message));
    }
  }
}
