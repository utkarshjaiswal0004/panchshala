import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
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
        title: const Text('Login To Panchshala'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return SafeArea(
                child: Column(
                  children: [
                    TextField(
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: true,
                      textAlign: TextAlign.left,
                      decoration: const InputDecoration(
                        hintText: "Enter your email here",
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                    ),
                    TextField(
                      controller: _password,
                      textAlign: TextAlign.left,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Enter your password here",
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          final userCredential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          print('The code breaked during login in LoginView');
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              );
            default:
              return const SafeArea(
                child: Text('Loading.....'),
              );
          }
        },
      ),
    );
  }
}
