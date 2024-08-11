// ignore_for_file: unused_import

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppNavItems extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final Function()? onTap;
  const AppNavItems(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.isActive,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    if (isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            Image.asset(
              iconPath,
              width: 50.w,
              height: 50.h,
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 100.h,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 40.w,
              height: 40.h,
            ),
            Text(
              label,
              style: TextStyle(fontSize: 12.sp, color: CupertinoColors.white),
            ),
          ],
        ),
      );
    }
  }
}
