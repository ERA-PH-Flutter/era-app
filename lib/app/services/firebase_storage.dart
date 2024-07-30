import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import '../models/user.dart';

class CloudStorage{
    final ref = FirebaseStorage.instance.ref();
    CloudStorage();
    Future<String> findUserImage({
        uid,
    }) async {
        try{
            return await ref.child('users/$uid').getDownloadURL();
        }catch (e){
            return "Error: $e";
        }
    }
    Future<String> getFile({
        folder,name
    }) async {
        try{
            return await ref.child('$folder/$name').getDownloadURL();
        }catch (e){
            return "Error: $e";
        }
    }
}