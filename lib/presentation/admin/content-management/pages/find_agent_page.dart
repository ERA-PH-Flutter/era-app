import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/createaccount_widget.dart';

class FindAgentPage extends GetView<ContentManagementController> {
  const FindAgentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height - 150.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sb30(),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidthAdmin - 5.w),
              child: EraText(
                text: 'FIND AGENT SETTINGS',
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            sb30(),
            Obx(
              () => Container(
                margin: EdgeInsets.symmetric(
                    horizontal: EraTheme.paddingWidthAdmin - 5.w),
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 0),
                      ),
                    ]),
                child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        padding: EdgeInsets.symmetric(
                            horizontal: EraTheme.paddingWidth),
                        value: controller.selectedType.value,
                        items: ["Image", "Video", "Youtube"]
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: EraText(
                                  text: item.toLowerCase(),
                                  fontSize: 20.sp,
                                  color: Colors.black,
                                )))
                            .toList(),
                        onChanged: (value) {
                          controller.selectedType.value = value!;
                        })),
              ),
            ),
            sb30(),
            Obx(() {
              if (controller.selectedType.value == 'Image') {
                return Column(
                  children: [
                    UploadBannersWidget(
                      text: 'UPLOAD IMAGE',
                      maxImages: 1,
                      onImageSelected: (image) {
                        controller.images.add(image);
                      },
                    ),
                    sb40(),
                  ],
                );
              } else if (controller.selectedType.value == 'Video') {
                return Column(
                  children: [
                    sb40(),
                  ],
                );
              } else if (controller.selectedType.value == 'Youtube') {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: EraTheme.paddingWidth + 43.sp),
                      child: SharedWidgets.textFormfield(
                        controller: controller.videoLinkAgent,
                        hintText: 'YOUTUBE LINK',
                        onChanged: (value) {
                          controller.link = value;
                        },
                      ),
                    ),
                    sb40(),
                  ],
                );
              }
              return Container();
            }),
            sb20(),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidthAdmin - 5.w),
              width: Get.width,
              height: 60.h,
              child: Button(
                text: 'SUBMIT',
                bgColor: AppColors.kRedColor,
                onTap: () async {
                  BaseController().showLoading();
                  if (controller.selectedType.value == 'Image') {
                    controller.link = await CloudStorage().uploadFromMemory(
                        file: controller.images.first,
                        target: "cms",
                        customName: "find_agent");
                  }
                  var data = {
                    "description": controller.description.text,
                    "link": controller.link,
                    "type": controller.selectedType.value.toLowerCase(),
                  };
                  await FirebaseFirestore.instance
                      .collection("cms")
                      .doc('find_agents')
                      .set(data);
                  BaseController().hideLoading();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // import 'package:flutter/material.dart';
}
