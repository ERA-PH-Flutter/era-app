import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/addlistings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddListings extends GetView<AddListingsController> {
  const AddListings({super.key});

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
              textBuild(
                  'CREATE LISTING', 25.sp, FontWeight.w600, AppColors.blue),
              SizedBox(height: 15.h),
              textBuild('PROPERTY INFORMATION', 25.sp, FontWeight.w600,
                  AppColors.kRedColor),
              SizedBox(height: 20.h),
              buildWidget(
                'Property Name',
                TextformfieldWidget(hintText: 'Property Name', maxLines: 1),
              ),
              buildWidget(
                'Property Cost',
                TextformfieldWidget(hintText: 'Php 100,000,000', maxLines: 1),
              ),
              textBuild(
                  'UPLOAD PHOTOS', 22.sp, FontWeight.w600, AppColors.kRedColor),
              SizedBox(height: 20.h),
              textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
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
                        'assets/icons/uploadphoto.png',
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

  Widget paddintText2() {
    return Column(
      children: [
        SizedBox(height: 20.h),
        buildWidget(
          'Price per sqm',
          TextformfieldWidget(
              controller: controller.pricePerSqmController,
              hintText: 'Php 100,000',
              maxLines: 1),
        ),
        buildWidget(
          'Floor Area',
          TextformfieldWidget(
              controller: controller.floorAreaController,
              hintText: '151 sqm',
              maxLines: 1),
        ),
        buildWidget(
          'Beds',
          TextformfieldWidget(
              controller: controller.bedsController,
              hintText: '2',
              maxLines: 1),
        ),
        buildWidget(
          'Baths',
          TextformfieldWidget(
              controller: controller.bathsController,
              hintText: '3',
              maxLines: 1),
        ),
        buildWidget(
          'Area',
          TextformfieldWidget(
              controller: controller.areaController,
              hintText: '150 sqm',
              maxLines: 1),
        ),
        buildWidget(
          'Offer Type',
          TextformfieldWidget(
              controller: controller.offerTypeController,
              hintText: 'Sale',
              maxLines: 1),
        ),
        buildWidget(
          'View',
          TextformfieldWidget(
              controller: controller.viewController,
              hintText: 'Sunrise',
              maxLines: 1),
        ),
        buildWidget(
          'Location',
          TextformfieldWidget(
              controller: controller.locationController,
              hintText: 'Bonifacio Global City, Taguig',
              maxLines: 1),
        ),
        buildWidget(
          'Property Type',
          TextformfieldWidget(
              controller: controller.propertyTypeController,
              hintText: 'Condominium',
              maxLines: 1),
        ),
        buildWidget(
          'Subcatergory',
          TextformfieldWidget(
              controller: controller.propertySubCategoryController,
              hintText: 'Penthouse',
              maxLines: 1),
        ),
        SizedBox(height: 20.h),
        Button.button2(390.w, 50.h, () {}, 'CREATE LISTING'),
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
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            EraText(
              text: text,
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
          ],
        ));
  }
}
