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
      this.lineHeight 
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(horizontal: 18.0),
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

  static Widget projectTitle(
      double? fontSize, FontWeight? fontWeight, Color? color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: EraText(
        text: 'PROJECTS',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  static Widget projectSubtitle(
      double? fontSize, FontWeight? fontWeight, Color? color) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: EraText(
        text: 'Perspectives by ERA Research & Market Inteleligence',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
