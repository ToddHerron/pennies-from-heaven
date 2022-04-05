import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Sign In'),
          onPressed: () async {
            await _auth.signInAnon();
            // print('sign in anon');
          },
        ),
      ),
    );
  }
}
