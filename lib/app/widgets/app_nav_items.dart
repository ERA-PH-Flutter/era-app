import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppNavItems extends StatelessWidget {
  final String iconPath;
  final String label;
  const AppNavItems({super.key, required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 50.w,
          height: 50.h,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: CupertinoColors.white),
        ),
      ],
    );
  }
}
