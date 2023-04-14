import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../login/login.dart';
import '../sing_up/sign_up.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  Widget _body(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 32,
      ),
      decoration: BoxDecoration(
        image: _backgroundImage(),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _logo(),
          _getStartedButton(context),
          _hintText(context),
        ],
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
      margin: const EdgeInsets.symmetric(
        vertical: 160,
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

  Widget _getStartedButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const Login(),
          ),
        );
      },
      child: Container(
        width: 240,
        height: 48,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 8,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 32,
        ),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(
            32,
          ),
        ),
        child: const Center(
          child: Text(
            'Get started',
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.none,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _hintText(BuildContext context) {
    return Row(
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
    return Scaffold(
      body: _body(context),
    );
  }
}
