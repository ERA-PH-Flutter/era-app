import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/constants/theme.dart';
import '../controller/log_list_admin_controller.dart';

class LogListAdmin extends GetView<LogListAdminController> {
  const LogListAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    LogListAdminController controller = Get.put(LogListAdminController());
    return SingleChildScrollView(
        child: Container(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      height: Get.height - 150.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sb30(),
          EraText(
            text: 'Log List Management',
            color: AppColors.blue,
            fontSize: EraTheme.header + 3.sp,
            fontWeight: FontWeight.bold,
          ),
          sb20(),
          _builTextField('LOG MESSAGE: '),
        ],
      ),
    ));
  }

  Widget _builTextField(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
            textAlign: TextAlign.start,
            text: text,
            color: AppColors.black,
            fontSize: EraTheme.small,
            fontWeight: FontWeight.bold),
      ],
    );
  }
}
