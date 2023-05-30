import 'package:flutter/material.dart';

import '../../constants.dart';

class Unit extends StatelessWidget {
  final int number;
  final String name;
  final VoidCallback onLongPress;

  const Unit({
    required this.number,
    required this.name,
    required this.onLongPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: onLongPress,
      title: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16,
        ),
        child: Row(
          children: [
            Text(
              '$number. ',
              style: const TextStyle(
                fontSize: 24,
                color: accentColor,
              ),
            ),
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
