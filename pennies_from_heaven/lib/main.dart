import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:pennies_from_heaven/firebase_options.dart';
import 'package:pennies_from_heaven/models/pfhuser.dart';
import 'package:pennies_from_heaven/screens/wrapper.dart';
import 'package:pennies_from_heaven/services/auth.dart';
import 'package:provider/provider.dart';
import 'dart:html';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('kIsWeb = $kIsWeb');

  if (kIsWeb) {
    var splitUrl = window.location.href.split('/');
    String clientId = splitUrl[splitUrl.length -
        1]; // A clientId with String length = 0 means no client id was detected in the URL.
    print('clientId = $clientId');

    // initialize the facebook javascript SDK

    try {
      await FacebookAuth.i.webInitialize(
        appId: "470607827508938",
        cookie: true,
        xfbml: true,
        version: "v13.0",
      );
      print('Facebook Auth initialized');
    } catch (e) {
      print('Facebook Auth failed to initialize');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<PfhUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: const Wrapper(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
