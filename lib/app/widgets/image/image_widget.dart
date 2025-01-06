import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String thumbnailUrl;
  final BoxFit? fit;
  final height;
  final width;

  const ImageWidget({
    required this.thumbnailUrl,
    this.fit,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CloudStorage().imageLoader(
      reference: thumbnailUrl,
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
    );
  }
}
