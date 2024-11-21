
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your email'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          const Text("we've sent you an email verification"),
          const Text("if you haven't received , press the button"),
          TextButton(
              onPressed: () async {
                AuthService.firebase().currentUser;
              },
              child: const Text('send email verification')),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut() ;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text('Restart')),
        ],
      ),
    );
  }
}
