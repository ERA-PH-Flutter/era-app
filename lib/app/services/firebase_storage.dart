import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

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
    Future<String> getFileDirect({
        required String docRef,
    }) async {
        try{
            return await ref.child(docRef).getDownloadURL();
        }catch (e){
            return "Error: $e";
        }
    }
    Future<String> deleteFileDirect({
        required String docRef,
    }) async {
        try{
            await ref.child(docRef).delete();
            return "success";
        }catch (e){
            return "Error: $e";
        }
    }
    Future<String> upload({
        required File file,required String target
    }) async {
        try{
            var filename = file.path.split("/")[file.path.split("/").length - 1];
            var uploadFilename = "${DateTime.now().microsecondsSinceEpoch}_$filename";
            var fileRef = ref.child('$target/$uploadFilename');
            await fileRef.putFile(file);
            return '$target/$uploadFilename';
        }catch (e){
            return "error";
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