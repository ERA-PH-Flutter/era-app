import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutUsPage extends GetView<ContentManagementController> {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sb30(),
          UploadBannersWidget(text: 'UPLOAD IMAGE', maxImages: 1),
          sb10(),

          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth + 43.sp),
            child: AddAgent.buildTextFieldFormDesc(
                'Description *', controller.description),
          ),
          sb40(),
          Container(
            margin: EdgeInsets.only(right: 80.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Button(
                onTap: () {},
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                text: 'SUBMIT',
                bgColor: AppColors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  // import 'package:flutter/material.dart';
}
