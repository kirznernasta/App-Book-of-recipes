import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationTry {
  final User? user;
  final String? errorMessage;

  AuthenticationTry({
    required this.user,
    required this.errorMessage,
  });
}
