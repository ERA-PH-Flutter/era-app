import 'dart:io';

import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PropertiesCard extends StatelessWidget {
  final String image;
  final String label;
  const PropertiesCard({super.key, required this.image, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: FileImage(
            File(image)
          )
        )
      ),
      child:  Stack(
        children: [
          Positioned(
            bottom: 10.0,
            left: 10.0,
            child: EraText(
              text: label,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
