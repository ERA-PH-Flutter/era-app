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
import 'package:file_picker/file_picker.dart';
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
                    Button(
                      margin: EdgeInsets.symmetric(
                          horizontal: EraTheme.paddingWidthAdmin - 5.w),
                      width: Get.width,
                      height: 60.h,
                      bgColor: AppColors.kRedColor,
                      text: 'SELECT VIDEO',
                      onTap: () async {
                        var vid = (await FilePicker.platform.pickFiles(
                            type: FileType.custom, allowedExtensions: ['mp4']));
                        if (vid != null &&
                            vid.files.first.bytes!.lengthInBytes < 104857600) {
                          controller.video = vid.files.first.bytes;
                        }
                      },
                    ),
                  ],
                );
              } else if (controller.selectedType.value == 'Youtube') {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: EraTheme.paddingWidthAdmin),
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
                  var link = '';
                  BaseController().showLoading();
                  if (controller.selectedType.value == 'Image') {
                    link = await CloudStorage().uploadFromMemory(
                        file: controller.images.first,
                        target: "cms",
                        customName: "find_agent");
                  }

                  if (controller.selectedType.value == 'Video') {
                    link = await CloudStorage().uploadFromMemory(
                        file: controller.video!,
                        target: "cms",
                        customName: "find_agent");
                  }

                  if (controller.selectedType.value == 'Youtube') {
                    link = controller.videoLinkAgent.text;
                  }

                  var data = {
                    "description": controller.description.text,
                    "link": link,
                    "type": controller.selectedType.value.toLowerCase(),
                  };
                  await FirebaseFirestore.instance
                      .collection("cms")
                      .doc('find_agents')
                      .set(data);
                  BaseController().hideLoading();
                  controller.showSuccessDialog(
                      title: "Success!",
                      description: "Find agent has been updated!",
                      hitApi: () {
                        Get.back();
                        controller.description.clear();
                        controller.videoLinkAgent.clear();
                        controller.images.clear();
                      });
                  print("Selected Type: ${controller.selectedType.value}");
                  print("Link: ${controller.link}");
                  print("Images: ${controller.images}");
                  print("Video: ${controller.video}");
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
