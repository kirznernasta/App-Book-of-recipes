import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firebase/authentication.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final Authentication _firebaseAuthentication;

  SignUpCubit({required Authentication firebaseAuthentication})
      : _firebaseAuthentication = firebaseAuthentication,
        super(SignUpState());

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

  void retypingPasswordChanged(String value) => emit(
        state.copyWith(
          newRetypingPassword: value,
        ),
      );

  void changeVisibilityPassword() => emit(
        state.copyWith(
          showingPassword: !state.isShowingPassword,
        ),
      );

  void changeVisibilityRetypingPassword() => emit(
        state.copyWith(
          showingRetypingPassword: !state.isShowingRetypingPassword,
        ),
      );

  void reset() => emit(
        SignUpState(),
      );

  Future<void> trySingUp() async {
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
    } else if (state.password != state.retypingPassword) {
      emit(
        state.copyWith(
          newErrorMessage: 'Passwords provided is not equal.',
        ),
      );
    } else {
      emit(
        state.copyWith(
          tryingSingUp: true,
        ),
      );
      final authenticationTry = await _firebaseAuthentication.signUp(
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
            tryingSingUp: false,
            newErrorMessage: authenticationTry.errorMessage!,
          ),
        );
      } else {
        emit(
          state.copyWith(
            tryingSingUp: false,
            newErrorMessage: '',
            signUpSuccessful: true,
          ),
        );
      }
    }
  }
}
