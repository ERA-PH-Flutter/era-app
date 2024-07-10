import 'package:firebase_storage/firebase_storage.dart';
class CloudStorage{
    final ref = FirebaseStorage.instance.ref();
    CloudStorage();
}