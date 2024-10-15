
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/news/controller/new_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/button.dart';
import '../../../../app/widgets/textformfield_widget.dart';
import '../../../../repository/logs.dart';
import '../../../global.dart';

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
          UploadBannersWidget(
            text: 'UPLOAD IMAGE',
            maxImages: 1,
          ),
          sb10(),
          title(
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
                onTap: () async {
                  BaseController().showLoading();
                  try {
                    var news = News(
                      title: controller.titleController.text,
                      description: controller.content.text,
                    );
                    await news.addNews(Get.find<AddListingsController>().images.first);
                    await Logs(
                        title: "${user!.firstname} ${user!.lastname} added a news with ID ${news.id}",
                        type: "news"
                    ).add();
                    BaseController().showSuccessDialog(
                        title: "Success!",
                        description: "News has been added!",
                        hitApi: () {
                          Get.back();
                          Get.back();
                          controller.titleController.clear();
                          controller.content.clear();
                          (Get.find<AddListingsController>().images.first)
                              .clear();
                        });
                  } catch (e) {
                    BaseController().showSuccessDialog(
                        title: "Error!",
                        description: "Error: $e",
                        hitApi: () {
                          Get.back();
                          Get.back();
                        });
                  }
                },
                margin: EdgeInsets.symmetric(horizontal: 5),
                width: 150.w,
                text: 'PUBLISH',
                bgColor: AppColors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            ]),
          ),
          // _featuredNews(),
        ],
      ),
    );
  }

  Widget title({
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(text: 'Title:', color: AppColors.black, fontSize: 18.sp),
        SizedBox(
          height: 70.h,
          width: Get.width / 1.2 - 45.w,
          child: TextformfieldWidget(
            controller: controller,
            hintText: 'Title *',
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
