import 'package:flutter/material.dart';

import '../../constants.dart';

class HintCard extends StatelessWidget {
  final Icon icon;
  final String text;
  final TextStyle? style;
  final bool isMaxWidth;

  const HintCard({
    required this.text,
    this.style,
    this.icon = const Icon(
      Icons.tips_and_updates,
      size: 48,
      color: accentColor,
    ),
    this.isMaxWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMaxWidth ? MediaQuery.of(context).size.width : null,
      margin: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(
            child: icon,
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: style,
            ),
          ),
        ],
      ),
    );
  }
}
