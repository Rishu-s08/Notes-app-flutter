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
      appBar: AppBar(title: const Text('Verify Email')),
      body: Center(
        child: Column(
          children: [
            const Text('We have sent you an email to verify your account.'),
            const Text(
              'If you have not received an email, press the button below.',
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(
                  const AuthEventSendEmailVerification(),
                );
              },
              child: Text('Send verification email'),
            ),
            ElevatedButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text('Back to login'),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthEventSendVerificationEmail {
  const AuthEventSendVerificationEmail();
}
