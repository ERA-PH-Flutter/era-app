import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  FirebaseAuth auth = FirebaseAuth.instance;
  Authentication();
  login({
    email,
    password,
  }) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return result.user!.uid;
      }
    } on FirebaseAuthException catch (e) {
      return "error: -${e.code}";
    }
    return "error";
  }

  signup({
    email,
    password,
  }) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        return result.user!.uid;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'error: The password provided is too weak. ';
      } else if (e.code == 'email-already-in-use') {
        return 'error: The account already exists for that email.';
      }
      return 'error: ${e.code}';
    }
    return "error";
  }

  logout() async {
    try {
      //await GoogleSignIn().signOut();
      await auth.signOut();
      return "success";
    } on FirebaseAuthException catch (e) {
      return "Error : $e";
    }
  }
}
