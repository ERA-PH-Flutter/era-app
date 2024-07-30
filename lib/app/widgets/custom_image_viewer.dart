import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        child: CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: 500.w,
        ),
      ),
    );
  }
}
