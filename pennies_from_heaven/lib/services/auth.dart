import 'package:firebase_auth/firebase_auth.dart';
import 'package:pennies_from_heaven/models/pfhuser.dart';

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

  // sign in anon

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
    }
  }

  // sign in with email and password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // print(e.toString());
      return null;
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
