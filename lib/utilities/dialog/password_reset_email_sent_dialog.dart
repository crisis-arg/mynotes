import "package:flutter/material.dart";
import "package:mynotes/utilities/dialog/generic_dialog.dart";


Future<void> showPasswordResetEmailSentDialog(BuildContext context) {
  return showgenericDialog<void>(
    context: context,
    title: 'Password Reset',
    content: 'Password Reset Email has been sent',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}