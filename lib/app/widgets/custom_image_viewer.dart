import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final double? radius;
  final double? borderradius;
  final BoxBorder? border;

  // final bool isActive;
  //  required this.isActive;
  const CustomImage(
      {super.key,
      required this.url,
      this.radius,
      this.borderradius,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: border,
        borderRadius: BorderRadius.circular(borderradius ?? 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderradius ?? 0),
        child: CloudStorage().imageLoader(
          ref: url,
          width: Get.width,
          height: Get.height,
        ),
      ),
    );
  }
}
