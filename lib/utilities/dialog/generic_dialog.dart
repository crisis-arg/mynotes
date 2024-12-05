import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showgenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white70,
        title: Text(title),
        content: Text(content),
        actions: options.keys.map(
          (optionTitle) {
            final value = options[optionTitle];
            return TextButton(
              onPressed: () {
                if (value != null) {
                  Navigator.of(context).pop(value);
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(optionTitle),
            );
          },
        ).toList(),
      );
    },
  );
}
