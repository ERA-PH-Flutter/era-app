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
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
      ),
      child: Stack(
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