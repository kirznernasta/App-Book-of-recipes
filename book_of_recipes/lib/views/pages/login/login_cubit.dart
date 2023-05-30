import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user.dart';
import '../../../repositories/user_repository.dart';
import '../../../services/firebase/authentication.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository _userRepository;
  final Authentication _authentication;

  LoginCubit({
    required Authentication firebaseAuthentication,
    required UserRepository userRepository,
  })  : _authentication = firebaseAuthentication,
        _userRepository = userRepository,
        super(LoginState());

  Future<User?> singUppedUser() async {
    final userId = _authentication.currentUser!.uid;
    return await _userRepository.receiveUserById(userId);
  }

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
      final authenticationTry = await _authentication.logIn(
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
