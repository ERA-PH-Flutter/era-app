import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../global.dart';

class SettingsPage extends GetView<AgentsController> {
  final AgentsController agentController = Get.put(AgentsController());

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: EdgeInsets.all(EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EraText(
                  text: 'Edit Profile',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/agentDashBoard');
                  },
                  child: Icon(
                    CupertinoIcons.forward,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            agentProfile(),
            textField(
                labelText: 'Full Name',
                hintText: "${user!.firstname ?? ""} ${user!.lastname ?? ""}",
                isPasswordTextField: false),
            textField(
                labelText: 'Email',
                hintText: user!.email ?? "",
                isPasswordTextField: false),
            textField(
                labelText: 'Password',
                hintText: '***********',
                isPasswordTextField: true),
          ],
        ),
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
            future: CloudStorage().getFileDirect(docRef: user!.image ?? AppStrings.noUserImageWhite),
            builder: (context,snapshot){
              if(snapshot.hasData){
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
                            image: agentController.image.value != null
                                ? FileImage(agentController.image.value!)
                                : CachedNetworkImageProvider(snapshot.data!)
                            as ImageProvider)));
              }else{
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
                if (agentController.image.value != null) {}
                Get.dialog(
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: AlertDialog(
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
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                agentController.getImagePic();
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: AppColors.blue,
                              ),
                              child: EraText(
                                text: 'Take a Picture',
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Container(
                            width: Get.width,
                            child: ElevatedButton(
                              onPressed: () {
                                agentController.getImageGallery();
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

  Widget textField(
      {required String hintText,
      TextStyle? hintstlye,
      double? fontSize,
      Color? color,
      String? text,
      String? labelText,
      bool? isPasswordTextField}) {
    return Column(
      children: [
        EraText(
          text: text ?? '',
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.hint,
          lineHeight: 1.0,
        ),
        TextField(
          enabled: false,
          enableInteractiveSelection: false,
          decoration: InputDecoration(
            suffixIcon: isPasswordTextField != null && isPasswordTextField
                ? IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            hintText: hintText,
            hintStyle: hintstlye ??
                TextStyle(color: AppColors.black, fontSize: fontSize ?? 18.sp),
          ),
        ),
      ],
    );
  }
}
