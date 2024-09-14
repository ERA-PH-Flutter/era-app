import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/about_us.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/news/controller/new_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/button.dart';

class UploadNews extends GetView<NewsController> {
  const UploadNews({super.key});

  @override
  Widget build(BuildContext context) {
    NewsController controller = Get.put(NewsController());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          sb30(),
          //to do  nikko only one image upload error if more than one
          UploadBannersWidget(text: 'UPLOAD IMAGE', maxImages: 1),
          sb10(),
          AboutUsPage.title(
            controller: controller.titleController,
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth + 43.sp),
            child: AddAgent.buildTextFieldFormDesc(
                'Content *', controller.content),
          ),
          sb40(),
          Container(
            margin: EdgeInsets.only(right: 80.w),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Button(
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                text: 'PUBLISH',
                bgColor: AppColors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
