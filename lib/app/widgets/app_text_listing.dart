import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/widgets.dart';

class TextListing extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final EdgeInsetsGeometry? margin;
  const TextListing(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color,
      this.margin});

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
          ),
        ],
      ),
    );
  }
}
