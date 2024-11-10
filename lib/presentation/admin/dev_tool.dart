import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app/constants/colors.dart';
import '../../app/widgets/button.dart';

class DevTool extends StatelessWidget {
  const DevTool({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      text: 'MIGRATE IMAGE THUMBNAIL',
      onTap: ()async  {
   HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('migrateGenerateThumbnail');

    try {
      await callable.call();
    } catch (e) {
      print('Error calling function: $e');
    }
      },
      width: 200.w,
      bgColor: AppColors.kRedColor,
      borderRadius: BorderRadius.circular(30),
    );
  }
}
