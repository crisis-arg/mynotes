import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialog/generic_dialog.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  return showgenericDialog(
    context: context,
    title: 'An error occured',
    content: text,
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
