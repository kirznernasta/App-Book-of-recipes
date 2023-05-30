import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../../widgets/custom_app_bar.dart';
import '../profile_creation/profile_creation.dart';
import 'email_verification_cubit.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

  Widget _body(BuildContext context, EmailVerificationState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _successAnimation(state),
          _text(context, state),
          Container(
            margin: const EdgeInsets.symmetric(
              vertical: 48,
            ),
            child: state.isWaiting
                ? _waitingAnimation()
                : _createProfileButton(context),
          ),
        ],
      ),
    );
  }

  Widget _successAnimation(EmailVerificationState state) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 48,
      ),
      child: state.isWaiting
          ? null
          : Lottie.asset(
              verifiedAnimation,
              repeat: false,
            ),
    );
  }

  Widget _text(BuildContext context, EmailVerificationState state) {
    return Text(
      state.isWaiting
          ? 'We have sent you an Email on \n\n${context.read<EmailVerificationCubit>().currentUserEmail ?? 'no email provided'}'
          : 'Email verified',
      style: const TextStyle(
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _waitingAnimation() {
    return const CircularProgressIndicator(
      color: accentColor,
    );
  }

  Widget _createProfileButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const ProfileCreation(),
          ),
        );
      },
      child: const Text(
        'Create profile',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(title: 'Email verification', context: context),
          body: _body(context, state),
        );
      },
    );
  }
}
