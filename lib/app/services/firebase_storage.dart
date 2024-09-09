import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      return "Error: $e";
    }
  }

  imageLoader({ref, height, width, BoxFit? fit}) {
    return FutureBuilder(
      future: getFileDirect(docRef: ref),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CachedNetworkImage(
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
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

  Future<String> deleteFileDirect({
    required String docRef,
  }) async {
    try {
      await ref.child(docRef).delete();
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
    } catch (e) {
      return "error";
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
      return "Error: $e";
    }
  }
}
