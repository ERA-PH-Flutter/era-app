import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/sellproperty_controller.dart';
//todo add text

class SellProperty extends GetView<SellPropertyController> {
  const SellProperty({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidth, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title(),
              SizedBox(height: 20.h),
              SharedWidgets.textFormfield(
                  name: 'Name',
                  textInputType: TextInputType.text,
                  hintText: 'Name',
                  controller: controller.name),
              SizedBox(height: 20.h),
              SharedWidgets.textFormfield(
                  name: 'Phone Number',
                  textInputType: TextInputType.number,
                  hintText: 'Phone Number',
                  controller: controller.phoneNum),
              SizedBox(height: 20.h),
              SharedWidgets.textFormfield(
                  name: 'Email Address',
                  textInputType: TextInputType.text,
                  hintText: 'Email Address',
                  controller: controller.name),
              SizedBox(height: 20.h),
              SharedWidgets.dropDown(
                controller.selectedProperty,
                controller.propertyTypes,
                (value) => controller.selectedProperty.value = value!,
                'Property Type',
                'Property Type',
              ),
              SizedBox(height: 20.h),
              SharedWidgets.textFormfield(
                  name: 'Property Location',
                  textInputType: TextInputType.text,
                  hintText: 'Property Location',
                  controller: controller.propertyLocation),
              SizedBox(height: 20.h),
              SharedWidgets.textFormfield(
                  name: 'Price',
                  textInputType: TextInputType.number,
                  hintText: 'Price',
                  controller: controller.price),
              SizedBox(height: 20.h),
              EraText(
                  text: 'Description', fontSize: 18.sp, color: AppColors.black),
              SizedBox(height: 5.h),
              TextformfieldWidget(
                hintText: 'Enter Description',
                maxLines: 10,
                color: AppColors.hint,
              ),
              SizedBox(height: 20.h),
              Button(
                  text: 'SEND',
                  onTap: () {},
                  bgColor: AppColors.kRedColor,
                  borderRadius: BorderRadius.circular(30),
                  height: 43.h,
                  fontSize: 18.sp,
                  width: Get.width),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    ));
  }

  Widget title() {
    return EraText(
      text: 'Share your property details',
      color: AppColors.kRedColor,
      fontSize: EraTheme.header,
      fontWeight: FontWeight.bold,
    );
  }
}
//   return Scaffold(
//     body: WillPopScope(
//       onWillPop: () {
//         Get.back();
//         return Future.value(false);
//       },
//       child: SafeArea(
//         child: Obx(() => switch (controller.sellState.value) {
//               SellState.loading => _loading(),
//               SellState.loaded => _loaded(),
//               SellState.error => _error(),
//               SellState.empty => _empty()
//             }),
//       ),
//     ),
//   );
// }

// _loading() {
//   return Center(
//     child: CircularProgressIndicator(
//       color: AppColors.primary,
//     ),
//   );
// }

// _loaded() {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 25.h),
//     child: Column(
//       children: [

//       ],
//     ),
//   );
// }

// _error() {
//   //todo add error screen
// }
// _empty() {
//   //todo add empty screen
// }
// }
