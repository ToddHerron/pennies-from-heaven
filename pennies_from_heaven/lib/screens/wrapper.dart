import 'package:pennies_from_heaven/models/pfhuser.dart';
import 'package:flutter/material.dart';
import 'package:pennies_from_heaven/screens/authenticate/authenticate.dart';
import 'package:pennies_from_heaven/screens/home_page.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<PfhUser?>(context);

    // return either the Home or Authenticate widget
    return user == null ? const Authenticate() : HomePage();
  }
}
