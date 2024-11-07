import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageWidget extends StatelessWidget {
  final String thumbnailUrl;

  const ImageWidget({required this.thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File>(
      future: _fetchThumbnail(thumbnailUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Icon(Icons.error);
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Icon(Icons.broken_image);
        } else {
          return Image.file(snapshot.data!);
        }
      },
    );
  }

  Future<File> _fetchThumbnail(String url) async {
    final cacheManager = DefaultCacheManager();
    return cacheManager.getSingleFile('thumbnails/thumbs_$url');
  }
}
