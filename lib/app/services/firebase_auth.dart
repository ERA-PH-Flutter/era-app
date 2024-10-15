import 'package:firebase_auth/firebase_auth.dart';

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
      return "error $e";
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
}