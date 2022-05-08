import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pennies_from_heaven/models/pfhuser.dart';
import 'package:pennies_from_heaven/shared/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

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

  // sign in with Google

  Future signInWithGoogle() async {
    GoogleSignInAccount? googleUser;

    easyLoadingConfigForForms();
    EasyLoading.show();

    try {
      // Trigger the authentication flow
      googleUser = await GoogleSignIn(
              clientId:
                  '387393806114-1a59l34q1libjccpr0d4a8qk0aeuf1k8.apps.googleusercontent.com')
          .signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          return 'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.';
        case 'invalid-credential':
          return 'The supplied auth credential is malformed or has expired.';
        case 'operation-not-allowed':
          return 'Signing in with a provider that is not enabled for this Firebase project.';
        case 'user-disabled':
          return 'The user account has been disabled by an administrator.';
        case 'user-not-found':
          return 'There is no user record corresponding to this identifier. The user may have been deleted.';
        case 'wrong-password':
          return 'The password is invalid or the user does not have a password.';
        default:
          return 'Unknown error occurred. ${e.code}';
      }
    } finally {
      EasyLoading.dismiss();
    }
  }

// Login with Facebook

  Future signInWithFacebook() async {
    EasyLoading.show();

    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );
      print('result: ' + result.accessToken.toString()); // access token
      print('result.status = ' + result.status.toString());

      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential credential = FacebookAuthProvider.credential(
            result.accessToken!.token,
          );

          final UserCredential authResult =
              await _auth.signInWithCredential(credential);

          print('authResult.user.uid = ' + authResult.user.toString());

          final User? user = authResult.user;
          return _userFromFirebaseUser(user);

        case LoginStatus.cancelled:
          return "Login cancelled by user. Error: ${result.message}";

        case LoginStatus.failed:
          return "Login failed with Facebook. Error: ${result.message}";

        default:
          return null;
      }
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
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
