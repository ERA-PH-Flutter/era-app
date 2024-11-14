import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

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
          return Center(
              child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator.adaptive()));
        } else if (snapshot.hasError) {
          return CloudStorage().imageLoader(
            reference: thumbnailUrl,
            height: height,
            width: width,
            fit: fit ?? BoxFit.cover,
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Icon(Icons.broken_image);
        } else {
          return PhotoView(
            imageProvider: Image.network(
              snapshot.data!,
              fit: fit ?? BoxFit.cover,
              height: height,
              width: width,
            ).image,
            backgroundDecoration: BoxDecoration(color: Colors.transparent),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2.0,
          );

          // Image.network(
          //   snapshot.data!,

          // );
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
