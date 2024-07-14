import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';

class Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? bgColor;
  final FontWeight? fontWeight;
  final double? fontSize;
  final TextStyle? style;
  final double? height;
  final Color? color;

  const Button(
      {super.key,
      this.onTap,
      required this.text,
      this.bgColor,
      this.fontWeight,
      this.fontSize,
      this.style,
      this.height,
      this.color
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 35 ),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: bgColor,
        ),
        child: Center(
            child: FarmerText(
          text: text,
          color: color ?? AppColors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
        )),
      ),
    );
  }
}
