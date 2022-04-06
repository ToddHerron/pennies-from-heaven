import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/services/auth.dart';
// import 'package:pennies_from_heaven/services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        elevation: 0.0,
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('Logout'),
            style: ButtonStyle(elevation: MaterialStateProperty.all(0.0)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
    );
  }
}
