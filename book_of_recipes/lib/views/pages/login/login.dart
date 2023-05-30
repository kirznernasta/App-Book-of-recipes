import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants.dart';
import '../main_page/main_page.dart';
import '../sing_up/sign_up.dart';
import 'login_cubit.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Widget _body(BuildContext context, LoginState state) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: _backgroundImage(),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: state.isTryingLogIn || state.isLogInSuccessful
              ? [
                  _logo(),
                  _loadingAnimation(context, state),
                ]
              : [
                  _logo(),
                  _emailTextField(context),
                  _passwordTextField(context, state),
                  _logInButton(context),
                  _errorText(state),
                  _hintText(context),
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

  Widget _loadingAnimation(BuildContext context, LoginState state) {
    if (state.isLogInSuccessful) {
      Future.delayed(const Duration(milliseconds: 5), () async {
        final user = await context.read<LoginCubit>().singUppedUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainPage(
              user: user,
            ),
          ),
        );
      });
    }
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

  Widget _errorText(LoginState state) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 124,
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

  Widget _emailTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Material(
        color: greyColor,
        borderRadius: BorderRadius.circular(48),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'email',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: context.read<LoginCubit>().emailChanged,
        ),
      ),
    );
  }

  Widget _passwordTextField(BuildContext context, LoginState state) {
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
        child: TextField(
          obscureText: !state.isShowingPassword,
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
              onPressed: context.read<LoginCubit>().changeVisibilityPassword,
            ),
          ),
          onChanged: context.read<LoginCubit>().passwordChanged,
        ),
      ),
    );
  }

  Widget _logInButton(BuildContext context) {
    return GestureDetector(
      onTap: context.read<LoginCubit>().tryLogIn,
      child: Container(
        width: 350,
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        margin: const EdgeInsets.only(
          bottom: 8,
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
            'Log In',
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

  Widget _hintText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 132,
        bottom: 6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account? ',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              decoration: TextDecoration.none,
              fontSize: 16,
            ),
          ),
          _singUpButton(context),
        ],
      ),
    );
  }

  Widget _singUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (builderContext) => SignUp(
              context: builderContext,
            ),
          ),
        );
      },
      child: Text(
        'Sing Up',
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
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: _body(context, state),
        );
      },
    );
  }
}
