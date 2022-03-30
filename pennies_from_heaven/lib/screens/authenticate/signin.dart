import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/services/auth.dart';

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);
  final AuthService _auth = AuthService();

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    return Center(
      child: ElevatedButton(
        child: const Text('Sign In'),
        onPressed: () async {
          print('Signing In');
          await widget._auth.signInAnon();       
        },
      ),
    );
  }
}
