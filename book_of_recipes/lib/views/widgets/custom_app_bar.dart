import 'package:flutter/material.dart';

import '../../constants.dart';

AppBar customAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    scrolledUnderElevation: 0,
    title: Text(
      title,
      style: const TextStyle(
        color: accentColor,
      ),
    ),
    actions: actions,
  );
}
