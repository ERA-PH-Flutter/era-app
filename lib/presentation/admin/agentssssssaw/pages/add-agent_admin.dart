import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/agents-admin_controller.dart';

//todo add text
 
class AddAgents extends GetView<AgentsAdminController> {
  const AddAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.agentAState.value) {
                AgentsAState.loading => _loading(),
                AgentsAState.loaded => _loaded(),
                AgentsAState.error => _error(),
                AgentsAState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            EraText(
              text: 'PROPERTY INFORMATION',
              color: AppColors.black,
              fontSize: 5.sp,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(
              height: 10.h,
            ),
            EraText(
              text: 'CREATE LISTINGS',
              color: AppColors.black,
              fontSize: 5.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 10.h,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFormField(
                            TextformfieldWidget(
                              controller:
                                  controller.propertyNameControllerA,
                              fontSize: 4.sp,
                              maxLines: 1,
                            ),
                            105.w,
                            'Property Name*',
                            60.h),
                      ],
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextFormField(
                            TextformfieldWidget(
                              controller:
                                  controller.propertyNameControllerA,
                              fontSize: 4.sp,
                              maxLines: 1,
                            ),
                            105.w,
                            'Property Cost*',
                            60.h),
                      ],
                    ),
                  ],
                ),
                // SizedBox(height: 10.h),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         _buildTextFormField(
                //             TextformfieldWidget(
                //               controller: controller.propertyNameController,
                //               fontSize: 4.sp,
                //               maxLines: 1,
                //             ),
                //             50.w,
                //             'Price per sqm*',
                //             60.h),
                //       ],
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'Floor Area*',
                //         60.h),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'Beds*',
                //         60.h),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'Bathrooms*',
                //         60.h),
                //   ],
                // ),
                // SizedBox(
                //   height: 10.h,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         160.w,
                //         'Location*',
                //         60.h),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'Property Type*',
                //         60.h),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         _buildTextFormField(
                //             TextformfieldWidget(
                //               controller: controller.propertyNameController,
                //               fontSize: 4.sp,
                //               maxLines: 1,
                //             ),
                //             50.w,
                //             'Offer Type*',
                //             60.h),
                //       ],
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'View*',
                //         60.h),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'Sub Category*',
                //         60.h),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 1,
                //         ),
                //         50.w,
                //         'Parking*',
                //         60.h),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     _buildTextFormField(
                //         TextformfieldWidget(
                //           controller: controller.propertyNameController,
                //           fontSize: 4.sp,
                //           maxLines: 5,
                //         ),
                //         216.w,
                //         'Description*',
                //         200.h),
                //   ],
                // ),
                // Row(
                //   children: [
                //     EraText(
                //       text: 'Upload Photo*',
                //       color: AppColors.black,
                //       fontSize: 4.sp,
                //     ),
                //     Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 20.w),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           ElevatedButton.icon(
                //             style: ElevatedButton.styleFrom(
                //               backgroundColor: AppColors.blue,
                //               shadowColor: Colors.transparent,
                //               side: BorderSide(
                //                   color: AppColors.hint.withOpacity(0.1),
                //                   width: 1),
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //             ),
                //             onPressed: () {
                //               controller.getImageGallery();
                //             },
                //             icon: Icon(
                //               CupertinoIcons.photo_fill_on_rectangle_fill,
                //               color: AppColors.white,
                //             ),
                //             label: EraText(
                //               text: 'Select Photos',
                //               color: AppColors.white,
                //               fontSize: 20.sp,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(
      Widget child, double width, String text, double height) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 4.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: height,
              width: width,
              child: child,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ],
    );
  }

  _error() {
    return Container(
      child: EraText(
        text: 'errorrrr',
        color: AppColors.black,
      ),
    );
    //todo add error screen
  }

  _empty() {
    return Container(
      child: EraText(
        text: 'EMPTYYYY',
        color: AppColors.black,
      ),
    );
    //todo add empty screen
  }
}
