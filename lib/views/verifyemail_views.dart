import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(51, 46, 35, 108),
      appBar: AppBar(
        title: const Text(
            style: TextStyle(
              color: Colors.white70,
              fontSize: 34,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            'Verify your email'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                style: TextStyle(color: Colors.white70, fontSize: 20),
                "we've sent you an email verification"),
            // const Text(
            //     style: TextStyle(color: Colors.white70, fontSize: 20),
            //     "if you haven't received , press the button"),
            TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventSendEmailVerification(),
                      );
                },
                child: const Text('send email verification')),
            TextButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: const Text('Restart')),
          ],
        ),
      ),
    );
  }
}
