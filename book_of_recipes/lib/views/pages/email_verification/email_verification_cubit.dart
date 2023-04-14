import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/firebase/authentication.dart';

part 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final Authentication _firebaseAuthentication;
  late final Timer timer;

  EmailVerificationCubit({
    required Authentication firebaseAuthentication,
  })  : _firebaseAuthentication = firebaseAuthentication,
        super(EmailVerificationState()) {
    _verify();
    timer = Timer.periodic(
        const Duration(
          seconds: 3,
        ), (_) {
      checkEmailVerified();
    });
  }

  String? get currentUserEmail => _firebaseAuthentication.currentUser?.email;

  Future<void> _verify() async {
    _firebaseAuthentication.sendVerificationEmail();

    // _firebaseAuthentication.authenticationStateChanged.listen(
    //   (user) {
    //     print('update!!!');
    //     if (user == null || currentUser == null) return;
    //     if (user == currentUser) {
    //       if (user.emailVerified) {
    //         emit(
    //           state.copyWith(
    //             waiting: false,
    //           ),
    //         );
    //       }
    //     }
    //   },
    // );
  }

  void checkEmailVerified() {
    final currentUser = _firebaseAuthentication.currentUser;
    currentUser?.reload();
    if (currentUser != null && currentUser.emailVerified) {
      emit(
        state.copyWith(
          waiting: false,
        ),
      );
      timer.cancel();
    }
  }
}
