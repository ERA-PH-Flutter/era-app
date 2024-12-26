import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/screens.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/agents/controllers/agents_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../agent/utility/controller/base_controller.dart';
import '../../../global.dart';
import '../../landingpage/controller/homs_controller.dart';

class SettingsPageWeb extends GetView<AgentsWebController> {
  SettingsPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => switch (controller.agentState.value) {
          AgentsStateWeb.loaded => _loaded(),
          AgentsStateWeb.loading => _loading(),
          AgentsStateWeb.empty => _empty(),
          AgentsStateWeb.error => _error(),
          AgentsStateWeb.blank => _error(),
          AgentsStateWeb.noFeaturedAgent => _empty()
        });
  }

  _error() {
    return Screens.error();
  }

  _empty() {
    return Screens.empty();
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Padding(
      padding: EdgeInsets.all(EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EraText(
                text: 'Edit Profile',
                fontSize: EraTheme.headerWeb,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.black,
                  ))
            ],
          ),
          SizedBox(height: 10.h),
          agentProfile(),
          sb40(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white.withOpacity(0.9),
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textField(
                    labelText: 'Full Name',
                    hintText:
                        "${user!.firstname ?? ""} ${user!.lastname ?? ""}",
                  ),
                  SizedBox(height: 20.h),
                  textField(
                    labelText: 'Email',
                    hintText: user!.email ?? "",
                  ),
                  SizedBox(height: 20.h),
                  textField(
                    labelText: 'Password',
                    hintText: '********',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 30.h),
          //   Center(
          //     child: ElevatedButton(
          //       onPressed: () {
          //         BaseController().showSuccessDialog(
          //             description: "Change profile image success!",
          //             title: "Success",
          //             hitApi: () {
          //             selectedIndex.value = 11;
          //                   Get.find<HomsController>().onNavbarItemSelected(11);
          //              });
          //       },
          //       style: ElevatedButton.styleFrom(
          //         backgroundColor: AppColors.blue,
          //         padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 30.w),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(12),
          //         ),
          //       ),
          //       child: EraText(
          //         text: 'Save Changes',
          //         fontSize: 16.sp,
          //         fontWeight: FontWeight.bold,
          //         color: AppColors.white,
          //       ),
          //     ),
          //   ),
          // ],
        ],
      ),
    );
  }

  Widget agentProfile() {
    return Center(
        child: Stack(
      children: [
        Obx(() {
          controller.image.value;
          return FutureBuilder(
            future: CloudStorage().getFileDirect(
                docRef: user!.image ?? AppStrings.noUserImageWhite),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: AppColors.white,
                        ),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10))
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: controller.image.value != null
                                ? MemoryImage(controller.image.value!)
                                : CachedNetworkImageProvider(snapshot.data!)
                                    as ImageProvider)));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          );
        }),
        Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                if (controller.image.value != null) {}
                Get.dialog(
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AlertDialog(
                      contentPadding: EdgeInsets.all(24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: AppColors.white,
                      title: EraText(
                        text: 'Choose Image File',
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue,
                      ),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // SizedBox(
                          //   width: 250.w,
                          //   height: 40.h,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       controller.getImagePic(controller.image);
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       backgroundColor: AppColors.blue,
                          //     ),
                          //     child: EraText(
                          //       text: 'Take a Picture',
                          //       fontSize: 15.sp,
                          //       fontWeight: FontWeight.bold,
                          //       color: AppColors.white,
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(height: 5.h),
                          SizedBox(
                            width: 300.w,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.getImageGallery();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColors.blue,
                              ),
                              child: EraText(
                                text: 'Choose from Gallery',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40.h,
                              alignment: Alignment.centerRight,
                              child: EraText(
                                text: 'Cancel',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.blue,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 4,
                    color: AppColors.white,
                  ),
                  color: AppColors.blue,
                ),
                child: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    ));
  }

  Widget textField({
    required String hintText,
    TextStyle? hintstlye,
    double? fontSize,
    Color? color,
    String? text,
    String? labelText,
  }) {
    return Column(
      children: [
        // EraText(
        //   text: text ?? '',
        //   fontSize: EraTheme.h2,
        //   fontWeight: FontWeight.bold,
        //   color: AppColors.black,
        //   // lineHeight: 1.0,
        // ),
        // sb20(),
        TextField(
          enabled: false,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            // suffixIcon: isPasswordTextField != null && isPasswordTextField
            //     ? IconButton(
            //         onPressed: () {

            //         },
            //         icon: Icon(
            //           Icons.remove_red_eye,
            //           color: Colors.grey,
            //         ),
            //       )
            //     : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            labelStyle:
                TextStyle(color: AppColors.black, fontSize: fontSize ?? 22.sp),
            hintText: hintText,
            hintStyle: hintstlye ??
                TextStyle(color: AppColors.black, fontSize: fontSize ?? 20.sp),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
            filled: true,
            fillColor: AppColors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.blue),
            ),
          ),
          //obscureText: isPasswordTextField ?? false,
        ),
      ],
    );
  }
}
