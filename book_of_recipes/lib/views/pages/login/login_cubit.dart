import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firebase/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Authentication _firebaseAuthentication;

  LoginCubit({required Authentication firebaseAuthentication})
      : _firebaseAuthentication = firebaseAuthentication,
        super(LoginState());

  void emailChanged(String value) => emit(
        state.copyWith(
          newEmail: value,
        ),
      );

  void passwordChanged(String value) => emit(
        state.copyWith(
          newPassword: value,
        ),
      );

  void changeVisibilityPassword() => emit(
        state.copyWith(
          showingPassword: !state.isShowingPassword,
        ),
      );

  Future<void> tryLogIn() async {
    if (state.email.isEmpty) {
      emit(
        state.copyWith(
          newErrorMessage: 'Email provided is empty.',
        ),
      );
    } else if (state.password.isEmpty) {
      emit(
        state.copyWith(
          newErrorMessage: 'Password provided is empty.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          tryingLogIn: true,
        ),
      );
      final authenticationTry = await _firebaseAuthentication.logIn(
        email: state.email,
        password: state.password,
      );
      await Future.delayed(
        const Duration(
          seconds: 3,
        ),
      );
      if (authenticationTry.user == null) {
        emit(
          state.copyWith(
            tryingLogIn: false,
            newErrorMessage: authenticationTry.errorMessage!,
          ),
        );
      } else {
        emit(
          state.copyWith(
            tryingLogIn: false,
            newErrorMessage: '',
            logInSuccessful: true,
          ),
        );
      }
    }
  }
}
