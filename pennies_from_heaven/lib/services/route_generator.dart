import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/screens/wrapper.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    print("settings.runtimeType = ${settings.runtimeType}");
    print("settings = ${settings.toString()}");
    print("args = $args");
    print("settings.name = ${settings.name}");
    print("settings.name.runtimeType = ${settings.name.runtimeType}");

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const Wrapper());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
