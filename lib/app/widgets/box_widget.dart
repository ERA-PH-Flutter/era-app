import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxWidget{
  static Widget build({
    child
  }){
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: AppColors.hint,
          width: 1.0,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: AppColors.hint,
            width: 1.0,
          ),
        ),
        child: child,
      ),
    );
  }

  static Widget BoxWidget2(Color? color, Widget? child) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.hint.withOpacity(0.7), width: 3),
      ),
      child: child,
    );
  }
}

