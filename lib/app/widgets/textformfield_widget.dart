import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//not finished
class TextformfieldWidget extends StatelessWidget {
  final TextStyle? style;
  final InputDecoration? decoration;
  final String? hintText;
  final TextStyle? hintstlye;

  const TextformfieldWidget(
      {super.key, this.style, this.decoration, this.hintText, this.hintstlye});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: AppColors.black, fontSize: 15.sp),
      decoration: InputDecoration(
        hintText: 'Name',
        hintStyle: TextStyle(color: AppColors.hint),
        fillColor: AppColors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.black,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
