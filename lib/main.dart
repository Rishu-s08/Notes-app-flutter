// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mynotes/constants/routes.dart';
// import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
// import 'package:mynotes/services/auth/bloc/auth_event.dart';
// import 'package:mynotes/services/auth/bloc/auth_state.dart';
// import 'package:mynotes/services/auth/firebase_auth_provider.dart';
// import 'package:mynotes/views/login_view.dart';
// import 'package:mynotes/views/notes/create_update_note_view.dart';
// import 'package:mynotes/views/notes/notes_view.dart';
// import 'package:mynotes/views/register_view.dart';
// import 'package:mynotes/views/verify_email_view.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: BlocProvider<AuthBloc>(
//         create: (context) => AuthBloc(FirebaseAuthProvider()),
//         child: const HomePage(),
//       ),
//       routes: {
//         registerRoute: (context) => const RegisterView(),
//         loginRoute: (context) => const LoginView(),
//         verifyEmailRoute: (context) => const VerifyEmailView(),
//         notesRoute: (context) => const NotesView(),
//         createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
//       },
//     ),
//   );
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     print("Dispatching AuthEventInitialize...");
//     context.read<AuthBloc>().add(const AuthEventInitialize());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is AuthStateLoggedIn) {
//           return const NotesView();
//         } else if (state is AuthStateNeedVerification) {
//           return const VerifyEmailView();
//         } else if (state is AuthStateLoggedOut) {
//           return const LoginView();
//         } else {
//           // print(state);
//           return const NotesView();
//         }
//       },
//     );
//   }
// }

// //     return FutureBuilder(
// //       future: AuthService.firebase().initialize(),
// //       builder: (context, snapshot) {
// //         switch (snapshot.connectionState) {
// //           case ConnectionState.done:
// //             final user = AuthService.firebase().currentUser;
// //             if (user != null) {
// //               if (user.isEmailVerified) {
// //                 return const NotesView();
// //               } else {
// //                 return const VerifyEmailView();
// //               }
// //             } else {
// //               return const LoginView();
// //             }
// //           default:
// //             return Scaffold(
// //               body: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: const [
// //                   CircularProgressIndicator(),
// //                   Text('Loading...'),
// //                 ],
// //               ),
// //             );
// //         }
// //       },
// //     );
// //   }
// // }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/services/auth/firebase_auth_provider.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes/create_update_note_view.dart';
import 'package:mynotes/views/notes/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
