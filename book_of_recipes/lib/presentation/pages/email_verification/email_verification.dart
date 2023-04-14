import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../constants.dart';
import '../main_page/main_page.dart';
import 'email_verification_cubit.dart';

class EmailVerification extends StatelessWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            centerTitle: true,
            title: const Text(
              'Email verification',
              style: TextStyle(
                color: Colors.white60,
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 48,
                  ),
                  child: state.isWaiting
                      ? null
                      : Lottie.asset(
                          verifiedAnimation,
                          repeat: false,
                        ),
                ),
                Text(
                  state.isWaiting
                      ? 'We have sent you an Email on \n\n${context.read<EmailVerificationCubit>().currentUserEmail ?? 'no email provided'}'
                      : 'Email verified',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 48,
                  ),
                  child: state.isWaiting
                      ? const CircularProgressIndicator(
                          color: accentColor,
                        )
                      : GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MainPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Get started',
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
