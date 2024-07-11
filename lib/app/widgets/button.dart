import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextStyle? style;

  const Button(
      {super.key,
      this.onTap,
      required this.text,
      this.bgColor,
      this.fontWeight,
      this.fontSize,
      this.style});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35 ),
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Center(
            child: FarmerText(
          text: text,
          color: AppColors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
        )),
      ),
    );
  }
}
