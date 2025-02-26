import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/constants/colors.dart';
import '../../app/constants/theme.dart';

class BottomWidgets {
  static Widget bigCircle({required String text, height, width}) {
    return Row(
      children: [
        Container(
          width: height,
          height: width,
          decoration: BoxDecoration(
            color: const Color(0xFF0e6937),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check,
            color: AppColors.white,
          ),
        ),
        sbw10(),
        EraText(
          text: text,
          fontSize: EraTheme.h5,
          color: AppColors.hint,
          fontWeight: FontWeight.bold,
        )
      ],
    );
  }
}
