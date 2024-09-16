import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/about_us.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/news/controller/new_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/button.dart';
import '../../../../app/widgets/textformfield_widget.dart';
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
                onTap: () async {
                  BaseController().showLoading();
                  try {
                    await News(
                      title: controller.titleController.text,
                      description: controller.content.text,
                    ).addNews(Get.find<AddListingsController>().images.first);
                    BaseController().showSuccessDialog(
                        title: "Success!",
                        description: "News has been added!",
                        hitApi: () {
                          Get.back();
                          Get.back();
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

  // Widget _featuredNews() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.vertical,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             EraText(
  //               text: 'FEATURED NEWS',
  //               color: AppColors.kRedColor,
  //               fontSize: 20.sp,
  //               fontWeight: FontWeight.w600,
  //             ),
  //             sbw30(),
  //             Container(
  //               width: 300.w,
  //               child: TextformfieldWidget(
  //                 hintText: 'Find News',
  //                 maxLines: 1,
  //               ),
  //             ),
  //             sbw15(),
  //             // Button(
  //             //   onTap: () {
  //             //     //todo change picture
  //             //   },
  //             //   margin: EdgeInsets.symmetric(horizontal: 5),
  //             //   width: 80.w,
  //             //   text: 'UPDATE',
  //             //   bgColor: AppColors.blue,
  //             //   borderRadius: BorderRadius.circular(30),
  //             // ),
  //           ],
  //         ),
  //         SizedBox(height: 10.h),
  //         Obx(() {
  //           if (controller.newsState == NewsState.loaded) {
  //             return SizedBox(
  //               height: 550.h,
  //               width: Get.width,
  //               child: StreamBuilder(
  //                 stream:
  //                     FirebaseFirestore.instance.collection('news').snapshots(),
  //                 builder: (context, snapshot) {
  //                   if (!snapshot.hasData) {
  //                     return Center(child: CircularProgressIndicator());
  //                   }
  //                   List<int> randomIndex = [];
  //                   for (int i = 0;
  //                       i < min(10, snapshot.data!.docs.length);
  //                       i++) {
  //                     var random = Random().nextInt(snapshot.data!.docs.length);
  //                     while (randomIndex.contains(random)) {
  //                       random = Random().nextInt(snapshot.data!.docs.length);
  //                     }
  //                     randomIndex.add(random);
  //                   }

  //                   return GridView.builder(
  //                       physics: ScrollPhysics(),
  //                       shrinkWrap: true,
  //                       scrollDirection: Axis.horizontal,
  //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //                         crossAxisCount: 1,
  //                         mainAxisExtent: 390.w, //410
  //                       ),
  //                       itemCount: randomIndex.length,
  //                       itemBuilder: (context, i) {
  //                         var docIndex = randomIndex[i];
  //                         var news = News.fromJSON(
  //                             snapshot.data!.docs[docIndex].data());
  //                         var more = false.obs;
  //                         return GestureDetector(
  //                           onTap: () {},
  //                           child: Container(
  //                             margin:
  //                                 EdgeInsets.only(bottom: 15.h, right: 12.w),
  //                             child: Container(
  //                               padding:
  //                                   settings!.featuredNews!.contains(news.id)
  //                                       ? EdgeInsets.all(5)
  //                                       : EdgeInsets.zero,
  //                               decoration: BoxDecoration(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                   border: settings!.featuredNews!
  //                                           .contains(news.id)
  //                                       ? Border.all(
  //                                           color: AppColors.kRedColor,
  //                                           width: 3.w,
  //                                         )
  //                                       : Border.all(
  //                                           width: 1,
  //                                           color: AppColors.kRedColor)),
  //                               width: Get.width,
  //                               child: Stack(
  //                                 children: [
  //                                   CloudStorage().imageLoaderProvider(
  //                                       ref: news.image,
  //                                       height: 250.h,
  //                                       borderRadius:
  //                                           BorderRadius.circular(10.r)),
  //                                   Positioned(
  //                                       top: 5.h,
  //                                       right: 10.h,
  //                                       child: IconButton(
  //                                         onPressed: () {
  //                                           more.value = true;
  //                                         },
  //                                         icon: Icon(
  //                                           Icons.more_horiz_rounded,
  //                                           color: Colors.white,
  //                                           shadows: const [
  //                                             BoxShadow(
  //                                                 offset: Offset(0, 0),
  //                                                 color: Colors.white,
  //                                                 blurRadius: 5,
  //                                                 spreadRadius: 1)
  //                                           ],
  //                                         ),
  //                                       )),
  //                                   Positioned(
  //                                     bottom: 0,
  //                                     left: -4,
  //                                     right: -4,
  //                                     top: 200.h,
  //                                     child: Container(
  //                                       decoration: BoxDecoration(
  //                                         color: AppColors.white,
  //                                         borderRadius:
  //                                             BorderRadius.circular(20.r),
  //                                       ),
  //                                       child: Padding(
  //                                         padding: EdgeInsets.symmetric(
  //                                             horizontal:
  //                                                 EraTheme.paddingWidthSmall +
  //                                                     15.w,
  //                                             vertical: 15.h),
  //                                         child: Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             EraText(
  //                                               text: news.title ?? "No title",
  //                                               fontSize:
  //                                                   EraTheme.paragraph + 5.sp,
  //                                               color: AppColors.kRedColor,
  //                                               fontWeight: FontWeight.bold,
  //                                               textOverflow:
  //                                                   TextOverflow.ellipsis,
  //                                               maxLines: 3,
  //                                             ),
  //                                             EraText(
  //                                               text: news.description ??
  //                                                   "No description",
  //                                               fontSize:
  //                                                   EraTheme.paragraph - 2.sp,
  //                                               color: AppColors.hint,
  //                                               fontWeight: FontWeight.w500,
  //                                               maxLines: 5,
  //                                               textOverflow:
  //                                                   TextOverflow.ellipsis,
  //                                             ),
  //                                             SizedBox(
  //                                               height: 10.h,
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Obx(() {
  //                                     if (more.value == true) {
  //                                       return Wrap(
  //                                         children: [
  //                                           Container(
  //                                               margin: EdgeInsets.symmetric(
  //                                                   horizontal: 10.w,
  //                                                   vertical: 15.h),
  //                                               decoration: BoxDecoration(
  //                                                   borderRadius:
  //                                                       BorderRadius.circular(
  //                                                           10.r),
  //                                                   color: Colors.white,
  //                                                   boxShadow: const [
  //                                                     BoxShadow(
  //                                                         offset: Offset(0, 0),
  //                                                         blurRadius: 5,
  //                                                         spreadRadius: 1,
  //                                                         color: Colors.black38)
  //                                                   ]),
  //                                               width: Get.width,
  //                                               child: Column(children: [
  //                                                 Container(
  //                                                     alignment:
  //                                                         Alignment.centerRight,
  //                                                     child: IconButton(
  //                                                       onPressed: () {
  //                                                         more.value = false;
  //                                                       },
  //                                                       icon: Icon(
  //                                                         Icons.close,
  //                                                         size: 25.sp,
  //                                                         color: Colors.black,
  //                                                         shadows: const [
  //                                                           BoxShadow(
  //                                                               offset: Offset(
  //                                                                   0, 0),
  //                                                               color: Colors
  //                                                                   .white,
  //                                                               blurRadius: 5,
  //                                                               spreadRadius: 1)
  //                                                         ],
  //                                                       ),
  //                                                     )),
  //                                                 _menuOptions("Edit",
  //                                                     () async {
  //                                                   //todo move to edit
  //                                                 }, Icons.edit),
  //                                                 _menuOptions(
  //                                                     settings!.featuredNews!
  //                                                             .contains(news.id)
  //                                                         ? "Remove from Featured"
  //                                                         : "Add to Featured",
  //                                                     () async {
  //                                                   controller.newsState.value =
  //                                                       NewsState.loading;
  //                                                   await settings!
  //                                                       .addToFeaturedNews(
  //                                                           news.id);
  //                                                   controller.newsState.value =
  //                                                       NewsState.loaded;
  //                                                 }, Icons.add_circle),
  //                                                 _menuOptions("Delete",
  //                                                     () async {
  //                                                   await news.deleteNews();
  //                                                 }, Icons.delete_rounded),
  //                                                 SizedBox(
  //                                                   height: 20.h,
  //                                                 )
  //                                               ])),
  //                                         ],
  //                                       );
  //                                     } else {
  //                                       return Container();
  //                                     }
  //                                   }),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         );
  //                       });
  //                 },
  //               ),
  //             );
  //           } else {
  //             return Center(child: CircularProgressIndicator());
  //           }
  //         })
  //       ],
  //     ),
  //   );
  // }

  _menuOptions(text, callback, icon) {
    var isHover = false.obs;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        isHover.value = true;
      },
      onExit: (event) {
        isHover.value = false;
      },
      child: GestureDetector(
        onTap: callback,
        child: Obx(() => Container(
              alignment: Alignment.center,
              width: Get.width,
              color: isHover.value ? AppColors.kRedColor : Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 25.sp,
                    color: isHover.value ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  EraText(
                    text: text,
                    fontSize: 18.sp,
                    color: isHover.value ? Colors.white : Colors.black,
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
