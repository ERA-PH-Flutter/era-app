import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/constants/colors.dart';
import '../../app/constants/sized_box.dart';
import '../../app/widgets/button.dart';

class DevTool extends StatelessWidget {
  const DevTool({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // EraText(
        //   text: 'Click to migrate image thumbnail',
        //   fontSize: 32.sp,
        //   fontWeight: FontWeight.bold,
        //   color: AppColors.black,
        // ),
        Icon(
          Icons.arrow_downward_sharp,
          size: 100.w,
          color: AppColors.hint,
        ),
        sb20(),
        Button(
          text: 'CLICK TO MIGRATE IMAGE THUMBNAIL',
          fontSize: 24.sp,
          onTap: () async {
            HttpsCallable callable = FirebaseFunctions.instance
                .httpsCallable('migrateGenerateThumbnail');

            try {
              await callable.call();
            } catch (e) {
              print('Error calling function: $e');
            }
          },
          width: 500.w,
          height: 80.h,
          bgColor: AppColors.kRedColor,
          borderRadius: BorderRadius.circular(30),
        ),
      ],
    );
  }
}
