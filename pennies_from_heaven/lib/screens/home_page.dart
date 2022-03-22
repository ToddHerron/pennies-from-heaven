import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Go to Second Page'),
          onPressed: () {
            Navigator.of(context).pushNamed('/second');
          },
        ),
      ),
    );
  }
}
