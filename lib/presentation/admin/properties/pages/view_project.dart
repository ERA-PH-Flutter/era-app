import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';

class ViewProject extends StatelessWidget {
  const ViewProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(EraTheme.paddingWidthAdmin - 5.w),
      alignment: Alignment.topCenter,
      height: Get.height - 150.h,
      child: Card(
        child: ListTile(
          title: EraText(
              text: 'Developer Name: ',
              color: AppColors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ),
      ),
    );
  }
}
