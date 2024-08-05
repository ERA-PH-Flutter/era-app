import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/authentication/controllers/authentication_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAccount extends GetView<LoginPageController> {
  const CreateAccount({super.key});
//https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/createaccount%2Fuploadphoto.png?alt=media&token=94338eab-f7d3-4d33-b4ff-4a9f205abb80
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              paddingText(),
              Obx(() => controller.image.value.path == ''
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        controller.getImageGallery();
                      },
                      label: Image.asset(
                        AppEraAssets.uploadphoto,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Image.file(
                      controller.image.value,
                      fit: BoxFit.cover,
                    )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: EraText(
                    text: 'Photo must be at least 300px X 300px',
                    fontSize: 15.sp,
                    color: AppColors.hint),
              ),
              paddintText2(),
            ],
          )),
        ));
  }

  Widget paddingText() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textBuild(
                'CREATE AN ACCOUNT', 25.sp, FontWeight.w600, AppColors.blue),
            SizedBox(height: 20.h),
            textBuild(
                'Join Us Today!', 25.sp, FontWeight.w600, AppColors.kRedColor),
            SizedBox(height: 20.h),
            textBuild(
                'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.\n\nERA Real Estate was founded on the principle of collaboration. The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared serve your unique needs.',
                14.sp,
                FontWeight.w500,
                AppColors.black),
            SizedBox(height: 10.h),
            textBuild(
                'CREATE PROFILE', 25.sp, FontWeight.w600, AppColors.kRedColor),
            SizedBox(height: 20.h),
            textBuild('Profile Photo', 20.sp, FontWeight.w500, AppColors.black),
          ],
        ));
  }

  Widget paddintText2() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        buildWidget(
          'Name',
          TextformfieldWidget(hintText: 'Name', maxLines: 1),
        ),
        buildWidget(
          'WhatsApp Number',
          TextformfieldWidget(hintText: 'WhatsApp Number', maxLines: 1),
        ),
        buildWidget(
          'Email',
          TextformfieldWidget(hintText: 'Your Email here', maxLines: 1),
        ),
        buildWidget(
          'Confirm Email',
          TextformfieldWidget(hintText: 'Confirm Email', maxLines: 1),
        ),
        Obx(
          () => buildWidget(
            'Password',
            TextformfieldWidget(
                controller: controller.password,
                obscureText: controller.passwordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.passwordVisible.value
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill),
                  onPressed: () {
                    controller.passwordVisible.value =
                        !controller.passwordVisible.value;
                  },
                ),
                hintText: 'Password',
                maxLines: 1),
          ),
        ),
        Obx(
          () => buildWidget(
            'Confirm Passowrd',
            TextformfieldWidget(
                controller: controller.password,
                obscureText: controller.confirmPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(controller.confirmPasswordVisible.value
                      ? CupertinoIcons.eye_fill
                      : CupertinoIcons.eye_slash_fill),
                  onPressed: () {
                    controller.confirmPasswordVisible.value =
                        !controller.confirmPasswordVisible.value;
                  },
                ),
                hintText: 'Confirm Passowrd',
                maxLines: 1),
          ),
        ),
        SizedBox(height: 20.h),
        Button.button2(390.w, 50.h, () {}, 'CREATE ACCOUNT'),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget buildWidget(String text, TextformfieldWidget textFormField) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
              text: text,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black),
          SizedBox(height: 5.h),
          textFormField,
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget textBuild(
      String text, double fontSize, FontWeight fontWeight, Color color) {
    return Column(
      children: [
        EraText(
          text: text,
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
          maxLines: 50,
        ),
      ],
    );
  }
}



 

// class AddListings extends GetView<AddListingsController> {
//   const AddListings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: CustomAppbar(),
//         backgroundColor: AppColors.white,
//         body: SingleChildScrollView(
//           child: SafeArea(
//               child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               paddingText(),
//               Obx(() => controller.image.value.path == ''
//                   ? ElevatedButton.icon(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                       ),
//                       onPressed: () {
//                         controller.getImageGallery();
//                       },
//                       label: Image.asset(
//                         'assets/icons/uploadphoto.png',
//                         fit: BoxFit.fill,
//                       ),
//                     )
//                   : Image.file(
//                       controller.image.value,
//                       fit: BoxFit.cover,
//                     )),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30.w),
//                 child: EraText(
//                     text: 'Photo must be at least 300px X 300px',
//                     fontSize: 15.sp,
//                     color: AppColors.hint),
//               ),
//               paddintText2(),
//             ],
//           )),
//         ));
//   }


//   }

//   Widget paddingText() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         textBuild('CREATE LISTING', 25.sp, FontWeight.w600, AppColors.blue),
//         SizedBox(height: 15.h),
//         textBuild('PROPERTY INFORMATION', 25.sp, FontWeight.w600,
//             AppColors.kRedColor),
//         SizedBox(height: 20.h),
//         EraText(
//           text:
//               'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.\n\nERA Real Estate was founded on the principle of collaboration. The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared serve your unique needs.',
//           fontSize: 14.sp,
//           fontWeight: FontWeight.w500,
//           color: AppColors.black,
//           maxLines: 20,
//         ),
//         SizedBox(height: 10.h),
//         EraText(
//             text: 'CREATE PROFILE',
//             fontSize: 25.sp,
//             fontWeight: FontWeight.w600,
//             color: AppColors.kRedColor),
//         SizedBox(height: 20.h),
//         EraText(
//             text: 'Profile Photo',
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w500,
//             color: AppColors.black),
//       ],
//     );
//   }


