import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/services/firebase_storage.dart';
import '../../../../app/widgets/createaccount_widget.dart';

class JoinEraPage extends GetView<ContentManagementController> {
  const JoinEraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sb30(),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin - 5.w),
            child: EraText(
              text: 'JOIN ERA SETTINGS',
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
                      items: ["Image", "Youtube"]
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
                ],
              );
            }
            // else if (controller.selectedType.value == 'Video') {
            //   return Column(
            //     children: [
            //       // EraText(text: "Select Video",color: Colors.black,),
            //       Button(
            //         margin: EdgeInsets.symmetric(
            //             horizontal: EraTheme.paddingWidthAdmin - 5.w),
            //         width: Get.width,
            //         height: 60.h,
            //         bgColor: AppColors.kRedColor,
            //         text: 'SELECT VIDEO',
            //         onTap: () async {
            //           var vid = (await FilePicker.platform.pickFiles(
            //               type: FileType.custom, allowedExtensions: ['mp4']));
            //           if (vid != null &&
            //               vid.files.first.bytes!.lengthInBytes < 104857600) {
            //             controller.video = vid.files.first.bytes;
            //           }
            //         },
            //       ),
            //     ],
            //   );
            // }
            else if (controller.selectedType.value == 'Youtube') {
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
                ],
              );
            }
            return Container();
          }),
          //sb20(),
          // Padding(
          //   padding:
          //       EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth + 43.sp),
          //   child: SharedWidgets.textFormfield(
          //     controller: controller.descriptionJoinEra,
          //     hintText: 'DESCRIPTION',
          //     MaxLines: 15,
          //     textInputType: TextInputType.multiline,
          //   ),
          // ),
          sb40(),
          // Container(
          //   margin: EdgeInsets.only(right: 80.w),
          //   child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //     Button(
          //       onTap: () async {
          //         controller.showLoading();
          //         await FirebaseFirestore.instance
          //             .collection("cms")
          //             .doc('join_era')
          //             .set({
          //           "photo": await CloudStorage().uploadFromMemory(
          //               file: controller.images.first, target: "cms"),
          //           'description': controller.description.text,
          //           'video_link': controller.videoLinkAgent.text
          //         });
          //         controller.showSuccessDialog(
          //             title: "Success!",
          //             description: "About us has been updated!",
          //             hitApi: () {
          //               Get.back();
          //               Get.back();
          //             });
          //       },
          //       margin: EdgeInsets.symmetric(horizontal: 5),
          //       width: 150.w,
          //       text: 'SUBMIT',
          //       bgColor: AppColors.blue,
          //       borderRadius: BorderRadius.circular(30),
          //     ),
          //   ]),
          // ),
          // sb20(),
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
                  controller.link = "cms/join_era";
                  await CloudStorage().uploadFromMemory(
                      file: controller.images.first,
                      target: "cms",
                      customName: "join_era");
                }
                // else if (controller.selectedType.value == 'Video') {
                //   var uploadProgress = 0.0.obs;

                //   (FirebaseStorage.instance
                //       .ref('cms')
                //       .child('join_era')
                //       .putData(controller.video!)
                //       .asStream()
                //       .listen((snapshot) {
                //     uploadProgress.value =
                //         (snapshot.bytesTransferred / 1048576) /
                //             (snapshot.totalBytes / 1048576);
                //   })).onDone(() async {
                //     link = 'cms/join_era';
                //     Get.back();
                //   });
                // }
                else if (controller.selectedType.value == 'Youtube') {
                  link = controller.videoLinkAgent.text;
                }
                // else {
                //   link = controller.videoLinkJoinEra.text;
                // }
                var data = {
                  "description": controller.descriptionJoinEra.text,
                  "link": link,
                  "type": controller.selectedType.value.toLowerCase(),
                };
                await FirebaseFirestore.instance
                    .collection("cms")
                    .doc('join_era')
                    .set(data);
                BaseController().hideLoading();

                controller.showSuccessDialog(
                    title: "Success!",
                    description: "Join Era Settings has been updated!",
                    hitApi: () {
                      Get.back();
                      // Get.back();
                    });
              },
            ),
          ),
          sb50()
        ],
      ),
    );
  }
  // Get.dialog(Obx(() => Wrap(
  //       children: [
  //         Container(
  //           width: 200.w,
  //           padding: EdgeInsets.all(20.w),
  //           child: Center(
  //             child: Row(
  //               children: [
  //                 LinearProgressIndicator(
  //                   value: uploadProgress.value,
  //                 ),
  //                 EraText(
  //                   text:
  //                       '${(uploadProgress.value * 100).toStringAsFixed(2)}%',
  //                   color: Colors.black,
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     )));

  // import 'package:flutter/material.dart';
}
