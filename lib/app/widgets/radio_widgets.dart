import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RadioWidgets extends StatelessWidget {
  final String? text;

  const RadioWidgets({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.9,
          child: Radio(
            fillColor: WidgetStatePropertyAll(AppColors.hint),
            value: 1,
            groupValue: null,
            onChanged: null,
          ),
        ),
        Text(
          text ?? 'SELL',
          style: TextStyle(
              color: AppColors.hint,
              fontSize: 20.sp,
              fontWeight: FontWeight.w400),
        ),
        // Row(
        //   children: [
        //     Transform.scale(
        //       scale: 1.9,
        //       child: Radio(
        //         fillColor: WidgetStatePropertyAll(AppColors.hint),
        //         value: 1,
        //         groupValue: null,
        //         onChanged: null,
        //       ),
        //     ),
        //     Text(
        //       'RENT',
        //       style: TextStyle(
        //           color: AppColors.hint,
        //           fontSize: 20.sp,
        //           fontWeight: FontWeight.w400),
        //     )
        //   ],
        // ),
      ],
    );
  }
}
