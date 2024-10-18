import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/createaccount_widget.dart';

class JoinEraPage extends GetView<ContentManagementController> {
  const JoinEraPage({super.key});

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
            child: SharedWidgets.textFormfield(
              controller: controller.videoLinkJoinEra,
              hintText: 'UPLOAD VIDEO LINK',
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth + 43.sp),
            child: SharedWidgets.textFormfield(
              controller: controller.descriptionJoinEra,
              hintText: 'DESCRIPTION',
              MaxLines: 15,
              textInputType: TextInputType.multiline,
            ),
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
