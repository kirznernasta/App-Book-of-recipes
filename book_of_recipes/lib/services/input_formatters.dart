import 'package:flutter/services.dart';

class NumberInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regularExpression = RegExp(r'^[1-9]\d*$');
    late final String formattedText;

    if (!regularExpression.hasMatch(newValue.text)) {
      if (newValue.text == '') {
        formattedText = '';
      } else {
        formattedText = oldValue.text;
      }
    } else {
      formattedText = newValue.text;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class DoubleInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regularExpression = RegExp(r'^\d+\.?(\d{0,2})$');
    late final String formattedText;

    if (!regularExpression.hasMatch(newValue.text)) {
      if (newValue.text == '') {
        formattedText = '0';
      } else {
        formattedText = oldValue.text;
      }
    } else {
      if (newValue.text.startsWith('00')) {
        formattedText = '0';
      } else if (newValue.text.startsWith('0') &&
          !newValue.text.startsWith('0.')) {
        formattedText = newValue.text.substring(1);
      } else if (newValue.text == '0.00') {
        formattedText = '0';
      } else {
        formattedText = newValue.text;
      }
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
