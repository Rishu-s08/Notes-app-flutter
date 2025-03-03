import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password; 

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
            children: [
              TextField(controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        scrollPadding: EdgeInsets.all(5.0),
                        decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',),
              ),
              TextField(controller: _password,
                        obscureText: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        ),
              ),
              TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    devtools.log('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    devtools.log('The account already exists for that email.');
                  }
                } catch (e) {
                  devtools.log(e.toString());
                }
              },
              child: const Text('Register'),
            ),
            TextButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
            }, child: const Text('Already have an account? Login here')),
            ],
      ),
    );
  }
}

