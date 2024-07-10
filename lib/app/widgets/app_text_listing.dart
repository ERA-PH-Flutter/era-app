import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TextListing extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const TextListing(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.fontWeight,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        children: [
          FarmerText(
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
