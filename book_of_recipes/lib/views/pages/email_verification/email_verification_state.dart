part of 'email_verification_cubit.dart';

class EmailVerificationState {
  final bool isWaiting;

  EmailVerificationState({
    this.isWaiting = true,
  });

  EmailVerificationState copyWith({bool? waiting}) => EmailVerificationState(
        isWaiting: waiting ?? isWaiting,
      );
}
