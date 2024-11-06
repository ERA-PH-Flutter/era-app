import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/constants/colors.dart';
import '../../app/widgets/button.dart';

class DevTool extends StatelessWidget {
  const DevTool({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'MIGRATE IMAGE THUMBNAIL',
      onTap: () {},
      width: 200.w,
      bgColor: AppColors.kRedColor,
      borderRadius: BorderRadius.circular(30),
    );
  }
}
