import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';

class CloudStorage{
    final ref = FirebaseStorage.instance.ref();
    CloudStorage();
    Future<User> findUser({
        uid,
    }) async {
        try{
            var userJson = jsonDecode(await ref.child('users/$uid').getDownloadURL());
            return User.fromJSON(userJson);
        }catch (e){
            print(e);
            return User(id: "Unknown");
        }
    }
}