import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/constants/colors.dart';
import '../../../app/widgets/app_text.dart';
import '../../../app/widgets/button.dart';

mixin class BaseController {
  showSuccessDialog(
  {
    VoidCallback? hitApi,
    String title = 'Success',
    String? description = 'Successfully',
    cancelable = false,
    cancelButton = "No",
    okayButton = "Okay",
    dismissible = false,
  }) {
    showCupertinoDialog(
      barrierDismissible: dismissible,
      context: Get.context!,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.5),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EraText(
                text: title,
                fontWeight: FontWeight.w500,
                color: AppColors.primary,
                fontSize: 25.sp,
              ),
              SizedBox(
                height: 10.h,
              ),
              EraText(
                text: description ?? '',
                fontWeight: FontWeight.w400,
                color: AppColors.black,
                fontSize: 16.sp,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (cancelable)
                    CupertinoButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        cancelButton,
                        style: GoogleFonts.poppins(
                          color: AppColors.primary,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10.w,
                  ),
                  CupertinoButton(
                    color: AppColors.primary,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                    onPressed: hitApi ?? (){
                      Get.back();
                      // if (Get.isDialogOpen!)
                    },
                    child: Text(
                      okayButton,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showLoading([String? message]) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => CupertinoDialogAction(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: AppColors.primary,
              )
              // CupertinoActivityIndicator(),
              // SizedBox(height: 8),
              // Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  static void hideLoading() {
    Get.back();
  }

  static void showErroDialog({
    VoidCallback? onTap,
    String title = 'Error',
    String? description = 'Something went wrong',
  }) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.5),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EraText(
                text: title,
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
              SizedBox(
                height: 10.h,
              ),
              EraText(
                text: description ?? '',
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              SizedBox(
                height: 10.h,
              ),
              Button(
                height: 48.h,
                text: "Okay",
                onTap: () {
                  // if (hitApi != null) {
                  onTap!();
                  // }
                  // if (Get.isDialogOpen!)
                  Get.back();
                },
                bgColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
    // Get.dialog(Text(description!));
    // Get.dialog(
    //   Dialog(
    //     child: Padding(
    //       padding: const EdgeInsets.all(16.0),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Text(
    //             title,
    //             style: Get.textTheme.headline4,
    //           ),
    //           Text(
    //             description ?? '',
    //             style: Get.textTheme.headline6,
    //           ),
    //           ElevatedButton(
    //             onPressed: () {
    //               if (Get.isDialogOpen!) Get.back();
    //             },
    //             child: Text('Okay'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
