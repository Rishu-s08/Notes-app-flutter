import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

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
        title: const Text('Verify Email'),
      ),
      body: Center(
          child: Column(
            children: [
              const Text('We have sent you an email to verify your account.'),
              const Text('If you have not received an email, press the button below.'),
              ElevatedButton(
                onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    await user?.sendEmailVerification();
                    if(context.mounted){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Verification email sent')),
                    );
                    Navigator.of(context).pushNamed(loginRoute);
                  }
                },
                child: Text('Send verification email'),
              ),
            ],
          ),
      ),
    );
  }
}
