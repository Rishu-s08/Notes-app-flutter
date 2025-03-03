import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
      routes: {
        '/register': (context) => const RegisterView(),
        '/login': (context) => const LoginView(),
        '/verify-email': (context) => const VerifyEmailView(),
        '/notes': (context) => const NotesView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser; 
              if(user != null){
                if(user.emailVerified){
                  return const NotesView();
                }else{
                  Navigator.of(context).pushNamedAndRemoveUntil('/verify-email', (route) => false);
                }
              }
              else{
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
              }
            return Scaffold(
              body: Center(
                child: Text('Welcome to MyNotes'),
              ),
            );
            default: 
              return Scaffold(body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                   CircularProgressIndicator(),
                    Text('Loading...'),
                ],
              ));
          }
        },
      );
  }
}

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

enum MenuAction { logout }

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async{
            switch(value){
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if(shouldLogout){
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                }
            }
          },
          itemBuilder: (context){
            return const [PopupMenuItem(
              value: MenuAction.logout,
              child: Text('Logout'),
            )];
          },)
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to MyNotes'),   
          ],
        ),
      ),
    );
  }
}


Future<bool> showLogOutDialog(BuildContext context){
  return showDialog(context: context, builder: (context){
  return AlertDialog(
    title: const Text('Logout'),
    content: const Text('Are you sure you want to logout?'),
    actions: [
      TextButton(onPressed: () {
        Navigator.of(context).pop(false);
      },child: const Text('Cancel'),),
      TextButton(onPressed: () {
        Navigator.of(context).pop(true);    
      },child: Text('Logout'),)
    ],
  );}
  ).then((value) => value ?? false);
}
