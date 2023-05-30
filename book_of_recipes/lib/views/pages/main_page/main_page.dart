import 'package:flutter/material.dart';

import '../../../models/user.dart';
import 'admin/admin_main_page.dart';
import 'client/client_main_page.dart';

class MainPage extends StatelessWidget {
  final User? user;
  const MainPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      if (user!.isAdmin) {
        return AdminMainPage(
          admin: user!,
        );
      }
      return ClientMainPage(
        user: user!,
      );
    }
    throw Exception('USER IS NULL IN MAIN PAGE!');
  }
}
