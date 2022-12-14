import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
      ),
      body: SafeArea(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: ElevatedButton(
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  try {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    print(userCredential);
                  } catch (e) {
                    print(e);
                  }
                },
                child: const Text('Register'),
              ),
            ),
            TextButton(
              onPressed: () {
                // return RegisterView()
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/login', (route) => false);
              },
              child: const Text('Already Registered? Login from here!'),
            )
          ],
        ),
      ),
    );
  }
}
