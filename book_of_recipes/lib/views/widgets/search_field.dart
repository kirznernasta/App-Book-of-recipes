import 'package:flutter/material.dart';

import '../../constants.dart';

class SearchField extends StatelessWidget {
  final EdgeInsets? padding;
  final String? hintText;
  final void Function(String)? onChanged;

  const SearchField({this.onChanged, this.padding, this.hintText, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0.0),
        child: TextField(
          decoration: InputDecoration(
            focusColor: accentColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
              borderSide: const BorderSide(
                color: accentColor,
              ),
            ),
            prefixIcon: const Icon(
              Icons.search,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(48.0),
            ),
            hintText: hintText ?? 'Search recipes...',
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
