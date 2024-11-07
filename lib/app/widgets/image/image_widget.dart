import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageWidget extends StatelessWidget {
  final String thumbnailUrl;
  final BoxFit? fit;
  final height;
  final width;

  const ImageWidget(
      {required this.thumbnailUrl, this.fit, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _fetchThumbnail(thumbnailUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print(
              'ImageWidget: ${snapshot.error} thumbnails error:${thumbnailUrl}');
          return CloudStorage().imageLoader(
            reference: thumbnailUrl,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          print('ImageWidget: ${snapshot.data}');
          return Icon(Icons.broken_image);
        } else {
          print('ImageWidget: ${snapshot.data}');
          return Image.network(
            snapshot.data!,
            fit: fit ?? BoxFit.cover,
            height: height ?? Get.height,
            width: width ?? Get.width,
          );
        }
      },
    );
  }

  Future<String> _fetchThumbnail(String url) async {
    //if not avail thumbnail return the original image

    final ref = FirebaseStorage.instance.ref();
    final urlSplit = url.split('/');
    final fileName = urlSplit.removeLast();
    final thumbUrl = '${urlSplit.join('/')}/thumbnails/thumb_$fileName';
    return await ref.child(thumbUrl).getDownloadURL();
  }
}
