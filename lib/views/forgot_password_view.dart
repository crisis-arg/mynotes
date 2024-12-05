import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialog/error_dialog.dart';
import 'package:mynotes/utilities/dialog/password_reset_email_sent_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetEmailSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(context, 'you are not a registered user');
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text(
              style: TextStyle(
                color: Colors.white70,
                fontSize: 34,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
              'Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                  style: TextStyle(color: Colors.white70, fontSize: 20),
                  'If you forgot your password, simply enter your email and we will send you a password reset link'),
              TextField(
                style: const TextStyle(color: Colors.white70),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: 'Your email address',
                ),
              ),
              TextButton(
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotpassword(email: email));
                },
                child: const Text('Send me a password reset link'),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text('Back to login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
