import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  const CustomFloatingActionButton({
    required this.icon,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: onPressed,
        child: Icon(
          icon,
          size: 32,
        ),
      ),
    );
  }
}
