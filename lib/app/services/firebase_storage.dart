import 'dart:convert';
import 'dart:io';

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
    Future<String> uploadImage({
        required File image
    }) async {
        try{
            var filename = image.path.split("/")[image.path.split("/").length - 1];
            var imageRef = ref.child('listings/${"${DateTime.now().microsecondsSinceEpoch}_$filename"}');
            await imageRef.putFile(image);
            return await imageRef.getDownloadURL();
        }catch (e){
            return "Error: $e";
        }
    }
}