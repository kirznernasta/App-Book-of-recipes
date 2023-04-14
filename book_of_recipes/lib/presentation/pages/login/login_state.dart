part of 'login_cubit.dart';

class LoginState {
  final String email;
  final String password;
  final bool isShowingPassword;
  final String errorMessage;
  final bool isTryingLogIn;
  final bool isLogInSuccessful;

  LoginState({
    this.email = '',
    this.password = '',
    this.isShowingPassword = false,
    this.errorMessage = '',
    this.isTryingLogIn = false,
    this.isLogInSuccessful = false,
  });

  LoginState copyWith({
    String? newEmail,
    String? newPassword,
    bool? showingPassword,
    String? newErrorMessage,
    bool? tryingLogIn,
    bool? logInSuccessful,
  }) =>
      LoginState(
        email: newEmail ?? email,
        password: newPassword ?? password,
        isShowingPassword: showingPassword ?? isShowingPassword,
        errorMessage: newErrorMessage ?? errorMessage,
        isTryingLogIn: tryingLogIn ?? isTryingLogIn,
        isLogInSuccessful: logInSuccessful ?? isLogInSuccessful,
      );
}
