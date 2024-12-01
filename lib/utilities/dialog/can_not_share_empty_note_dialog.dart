import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialog/generic_dialog.dart';

Future<void> showCannotShareEmptyDialog(BuildContext context) {
  return showgenericDialog<void>(
    context: context,
    title: 'sharing',
    content: 'you can not share a empty note!',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
