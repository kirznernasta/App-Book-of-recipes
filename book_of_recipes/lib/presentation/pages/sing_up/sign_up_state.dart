part of 'sign_up_cubit.dart';

class SignUpState {
  final String email;
  final String password;
  final String retypingPassword;
  final bool isShowingPassword;
  final bool isShowingRetypingPassword;
  final String errorMessage;
  final bool isTryingSingUp;
  final bool isSignUpSuccessful;

  SignUpState({
    this.email = '',
    this.password = '',
    this.retypingPassword = '',
    this.isShowingPassword = false,
    this.isShowingRetypingPassword = false,
    this.errorMessage = '',
    this.isTryingSingUp = false,
    this.isSignUpSuccessful = false,
  });

  SignUpState copyWith({
    String? newEmail,
    String? newPassword,
    String? newRetypingPassword,
    bool? showingPassword,
    bool? showingRetypingPassword,
    String? newErrorMessage,
    bool? tryingSingUp,
    bool? signUpSuccessful,
  }) =>
      SignUpState(
        email: newEmail ?? email,
        password: newPassword ?? password,
        retypingPassword: newRetypingPassword ?? retypingPassword,
        isShowingPassword: showingPassword ?? isShowingPassword,
        isShowingRetypingPassword:
            showingRetypingPassword ?? isShowingRetypingPassword,
        errorMessage: newErrorMessage ?? errorMessage,
        isTryingSingUp: tryingSingUp ?? isTryingSingUp,
        isSignUpSuccessful: signUpSuccessful ?? isSignUpSuccessful,
      );
}
