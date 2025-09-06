import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Authservices {
  Future<bool> LoginWithEmailandPassword(String email, String password);
  Future<bool> RegisterWithEmailandPassword(String email, String password);
  User? currentuser();
  Future<void> Logout();
  Future<bool> authenticatewithgoogle();
  Future<bool> authenticatewithfacebook();
}

class Authservicesimp implements Authservices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> LoginWithEmailandPassword(String email, String password) async {
    final usercredintal = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = usercredintal.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> RegisterWithEmailandPassword(
      String email, String password) async {
    final usercredintal = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = usercredintal.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? currentuser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> Logout() async {
    await GoogleSignIn().signOut();
    await _firebaseAuth.signOut();
  }

  @override
  Future<bool> authenticatewithgoogle() async {
    final guser = await GoogleSignIn().signIn();
    final gauth = await guser?.authentication;
    final cerdinital = GoogleAuthProvider.credential(
        accessToken: gauth?.accessToken, idToken: gauth?.idToken);
    final usercerdintal = await _firebaseAuth.signInWithCredential(cerdinital);
    if (usercerdintal.user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> authenticatewithfacebook() async {
    final loginresult = await FacebookAuth.instance.login();
    if (loginresult.status != LoginStatus.values) {
      return false;
    }
    final cerdintial =
        FacebookAuthProvider.credential(loginresult.accessToken!.tokenString);
    final cerdintialuser = await _firebaseAuth.signInWithCredential(cerdintial);
    if (cerdintialuser.user != null) {
      return true;
    } else {
      return false;
    }
  }
}
