import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication{
  FirebaseAuth auth = FirebaseAuth.instance;
  Authentication();
  login({
    email,
    password,
  }) async {
    try{
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }on FirebaseAuthException catch(e){
      return "error";
    }
    return auth.currentUser!.uid;
  }
  signup({
    email,
    password,
  }) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
  logout()async{
    try{
      //await GoogleSignIn().signOut();
      await auth.signOut();
      return "success";
    } on FirebaseAuthException catch(e){
      return "Error : $e";
    }
  }
  Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return auth.currentUser!.uid;
    } on FirebaseAuthException catch (e) {
      print(e);
      return null;
    }
  }
}