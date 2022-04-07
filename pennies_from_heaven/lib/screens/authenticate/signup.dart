import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/services/auth.dart';
import 'package:pennies_from_heaven/shared/constants.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  const SignUp({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Sign In'),
            style: ButtonStyle(elevation: MaterialStateProperty.all(0.0)),
            onPressed: () {
              widget.toggleView();
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                ),
                onChanged: (value) {
                  setState(() => email = value);
                },
                validator: (value) => value!.isEmpty ? 'Enter an email' : null,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  setState(() => password = value);
                },
                validator: (value) =>
                    value!.length < 6 ? 'Enter a password 6+ chars long' : null,
                obscureText: true,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _auth
                        .signUpWithEmailAndPassword(email, password)
                        .then((value) {
                      if (value.runtimeType == String) {
                        setState(() {
                          error = value;
                        });
                      }

                      return;
                    });
                  }
                },
              ),
              const SizedBox(height: 20.0),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
