import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class Authentication{
  var auth = FirebaseAuth.instance;
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
      print(e);
    }
  }
  signup({
    email,
    password,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword( // instantiated earlier on: final _firebaseAuth = FirebaseAuth.instance;
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      //todo handle error and exception
    } catch (e) {
      //todo handle error and exception
    }
  }
  logout()async{
    try{
      await auth.signOut();
    } on FirebaseAuthException catch(e){
      print(e);
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
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}