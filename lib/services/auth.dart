
import 'package:firebase_auth/firebase_auth.dart';
import 'package:poker_guy/models/app_user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    return _auth.authStateChanges();

  }

  // sign in anon
  Future<User> signInAnon() async {
    try {
      UserCredential cred = await _auth.signInAnonymously();
      return cred.user;

    } catch (e) {
      throw Exception("Sign in anon is no good.");
    }
  }



  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Stream<User> authStateChanged() {

    return _auth.authStateChanges();

  }

}