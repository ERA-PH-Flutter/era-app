import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CloudStorage {
  final ref = FirebaseStorage.instance.ref();
  CloudStorage();
  Future<String> findUserImage({
    uid,
  }) async {
    try {
      return await ref.child('users/$uid').getDownloadURL();
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> getFile({folder, name}) async {
    try {
      return await ref.child('$folder/$name').getDownloadURL();
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> getFileDirect({
    required String docRef,
  }) async {
    try {
      return await ref.child(docRef).getDownloadURL();
    } catch (e) {
      return await ref.child(AppStrings.noUserImageWhite).getDownloadURL();
    }
  }

  Future<Object?> getFileBytes({
    required String docRef,
  }) async {
    try {
      return await ref.child(docRef).getData();
    } catch (e) {
      return await ref.child(AppStrings.noUserImageWhite).getData();
    }
  }
  Future<Object?> getFilesBytes({
    required List docRefs,
  }) async {
    var files = [];
    try {
      for (var docRef in docRefs) {
        files.add(await ref.child(docRef).getData());
      }return files;
    } catch (e) {
      return [];
    }
  }

  Widget imageLoader({ref, height, width, BoxFit? fit}){
    return FutureBuilder(
      future: getFileDirect(docRef: ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CachedNetworkImage(
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageUrl: snapshot.data!,
            fit: fit ?? BoxFit.cover,
            width: width,
            height: height,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  imageLoaderProvider({
    ref,
    height,
    width,
    borderRadius,
    color,
    child,
    shadow,
  }) {
    return FutureBuilder(
      future: getFileDirect(docRef: ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.zero,
                color: color ?? AppColors.white,
                boxShadow: shadow ?? [],
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      snapshot.data!,
                    ))),
            child: child,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  deleteFileDirect({
    required String docRef,
  }) async {
    try {
      await ref.child(docRef).delete();
      return "success";
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> deleteAll({
    required List fileList,
  }) async {
    try {
      for(int i = 0;i < fileList.length;i++){
        await ref.child(fileList[i]).delete();
      }
      return "success";
    } catch (e) {
      return "Error: $e";
    }
  }

  Future<String> upload(
      {required File file, required String target, customName}) async {
    try {
      var filename = file.path.split("/")[file.path.split("/").length - 1];
      var uploadFilename = "${DateTime.now().microsecondsSinceEpoch}_$filename";
      var fileRef = ref.child('$target/${customName ?? uploadFilename}');
      await fileRef.putFile(file);
      return '$target/${customName ?? uploadFilename}';
    } catch (e,ex) {
      return "";
    }
  }
  Future<String> uploadCustom(
      {required  file, required customName}) async {
    try {
      var fileRef = ref.child(customName);
      await fileRef.putData(file);
      return customName;
    } catch (e,ex) {
      print(ex);
      return e.toString();
    }
  }
  Future<String> uploadFromMemory(
      {required file, required String target, customName}) async {
    try {
      var filename = "${Random().nextInt(100)}";
      var uploadFilename = "${DateTime.now().microsecondsSinceEpoch}_$filename.png";
      var fileRef = ref.child('$target/${customName ?? uploadFilename}');
      await fileRef.putData(file);
      return '$target/${customName ?? uploadFilename}';
    } catch (e,ex) {
      return "";
    }
  }

  Future<String> uploadImage({required File image}) async {
    try {
      var filename = image.path.split("/")[image.path.split("/").length - 1];
      var imageRef = ref.child(
          'listings/${"${DateTime.now().microsecondsSinceEpoch}_$filename"}');
      await imageRef.putFile(image);
      return await imageRef.getDownloadURL();
    } catch (e) {
      return "";
    }
  }
}
