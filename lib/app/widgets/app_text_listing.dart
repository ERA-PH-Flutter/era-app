import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/widgets.dart';

class TextListing extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final EdgeInsetsGeometry? margin;
  final double? lineHeight;
  const TextListing(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.margin,
      this.lineHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: Column(
        children: [
          EraText(
            text: text,
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
            lineHeight: lineHeight,
          ),
        ],
      ),
    );
  }

//adjust
  static Widget projectTitle(
      double? fontSize, FontWeight? fontWeight, Color? color) {
    return EraText(
      text: 'PROJECTS',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  static Widget projectSubtitle(
      double? fontSize, FontWeight? fontWeight, Color? color) {
    return EraText(
      text: 'Perspectives by ERA Research & Market Intelligence',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
