import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'screens/second_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/': (context) => const HomePage(),
      '/second': (context) => const SecondPage(),
    });
  }
}
