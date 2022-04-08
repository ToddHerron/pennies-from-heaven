import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pennies_from_heaven/models/pfhuser.dart';
import 'package:pennies_from_heaven/shared/constants.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create pfm user object based on firebase user

  PfhUser? _userFromFirebaseUser(User? user) {
    if (user == null) return null;
    return PfhUser(uid: user.uid);
  }

  // auth change user stream

  Stream<PfhUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // sign up with email and password

  Future signUpWithEmailAndPassword(String email, String password) async {
    easyLoadingConfigForForms();
    try {
      EasyLoading.show(
        status: 'Creating account...',
      );
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      EasyLoading.dismiss();
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      switch (e.code) {
        case 'weak-password':
          return 'The password provided is too weak';
        case 'email-already-in-use':
          return 'An account already exists for that email';
        case 'invalid-email':
          return ('Invalid email');
        default:
          return 'Sign-up error: ${e.code}';
      }
    }
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    easyLoadingConfigForForms();
    try {
      EasyLoading.show();
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      EasyLoading.dismiss();
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      switch (e.code) {
        case 'user-not-found':
          return ('User not found');
        case 'wrong-password':
          return ('Wrong password');
        case 'invalid-email':
          return ('Invalid email');
        default:
          return 'Unknown error';
      }
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }
}
