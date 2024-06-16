import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class FarmerBottomSheet{
  double? height;
  double? width;
  EdgeInsets? padding;
  Widget child;
  bool? dismissible;
  FarmerBottomSheet({
    this.height,
    this.width,
    this.padding,
    this.dismissible,
    required this.child
  });
  show(whenComplete){
    showModalBottomSheet(
        isDismissible: dismissible?? true,
        backgroundColor: Colors.transparent,
        context: Get.context!,
        isScrollControlled: true,
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                padding: padding??EdgeInsets.all(16.h),
                height: height??200.h,
                width: width??Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                    ),
                    color: AppColors.white
                ),
                child: child
            ),
          );
        }
    ).whenComplete(whenComplete);
  }
}
