import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../email_verification/email_verification.dart';
import '../login/login.dart';
import 'sign_up_cubit.dart';

class SignUp extends StatefulWidget {
  SignUp({required BuildContext context, Key? key}) : super(key: key) {
    context.read<SignUpCubit>().reset();
  }

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Widget _body(SignUpState state) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: _backgroundImage(),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: state.isSignUpSuccessful
              ? [
                  _logo(),
                  _successText(),
                  _verifyButton(),
                ]
              : state.isTryingSingUp
                  ? [
                      _logo(),
                      _loadingAnimation(),
                    ]
                  : [
                      _logo(),
                      _emailTextField(),
                      _passwordTextField(state),
                      _retypePasswordTextField(state),
                      _signUpButton(),
                      _errorText(state),
                      _hintText(),
                    ],
        ),
      ),
    );
  }

  DecorationImage _backgroundImage() {
    return const DecorationImage(
      image: AssetImage(
        welcomeScreenBackgroundImage,
      ),
      fit: BoxFit.cover,
      opacity: 0.3,
    );
  }

  Widget _logo() {
    return Container(
      margin: const EdgeInsets.only(
        top: 72,
        bottom: 32,
      ),
      child: const Hero(
        tag: logoHeroTag,
        child: Icon(
          Icons.auto_stories_outlined,
          size: 240,
          color: accentColor,
        ),
      ),
    );
  }

  Widget _successText() {
    return const Padding(
      padding: EdgeInsets.only(
        top: 48,
        bottom: 24,
      ),
      child: Text(
        'Sing Up successfully!',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: greyColor,
        borderRadius: BorderRadius.circular(48),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          onChanged: context.read<SignUpCubit>().emailChanged,
        ),
      ),
    );
  }

  Widget _passwordTextField(SignUpState state) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 24.0,
        left: 24.0,
        top: 16,
        bottom: 8,
      ),
      child: Material(
        color: greyColor,
        borderRadius: BorderRadius.circular(48),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: state.isShowingPassword
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
              onPressed: context.read<SignUpCubit>().changeVisibilityPassword,
            ),
          ),
          obscureText: !state.isShowingPassword,
          onChanged: context.read<SignUpCubit>().passwordChanged,
        ),
      ),
    );
  }

  Widget _retypePasswordTextField(SignUpState state) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 24.0,
        left: 24.0,
        top: 8,
        bottom: 8,
      ),
      child: Material(
        color: greyColor,
        borderRadius: BorderRadius.circular(48),
        child: TextFormField(
          obscureText: !state.isShowingRetypingPassword,
          decoration: InputDecoration(
            hintText: 're-type password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: state.isShowingRetypingPassword
                  ? const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    )
                  : const Icon(
                      Icons.visibility_off,
                      color: Colors.grey,
                    ),
              onPressed:
                  context.read<SignUpCubit>().changeVisibilityRetypingPassword,
            ),
          ),
          onChanged: context.read<SignUpCubit>().retypingPasswordChanged,
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return GestureDetector(
      onTap: context.read<SignUpCubit>().trySingUp,
      child: Container(
        width: 350,
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(
          bottom: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: const Center(
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _verifyButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const EmailVerification(),
          ),
        );
      },
      child: Container(
        width: 350,
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(
          bottom: 16,
          top: 16,
        ),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: const Center(
          child: Text(
            'Verify my email',
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingAnimation() {
    return const Padding(
      padding: EdgeInsets.only(
        bottom: 120,
        top: 48,
      ),
      child: CircularProgressIndicator(
        color: Colors.grey,
      ),
    );
  }

  Widget _errorText(SignUpState state) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 160,
        top: 8,
      ),
      child: Text(
        state.errorMessage,
        style: TextStyle(
          color: Colors.red,
          fontSize: 16,
          decoration: TextDecoration.none,
          backgroundColor: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _hintText() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account? ',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              decoration: TextDecoration.none,
              fontSize: 16,
            ),
          ),
          _logInButton(),
        ],
      ),
    );
  }

  Widget _logInButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Login(),
          ),
        );
      },
      child: Text(
        'Log In',
        style: TextStyle(
          color: accentColor.withOpacity(0.8),
          decoration: TextDecoration.underline,
          decorationColor: Colors.amber,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Scaffold(
          body: _body(state),
        );
      },
    );
  }
}
