import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/screens/authenticate/signin.dart';
import 'package:pennies_from_heaven/screens/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn();
    } else {
      return const SignUp();
    }
  }
}
