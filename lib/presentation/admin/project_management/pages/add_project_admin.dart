import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProjectAdmin extends GetView<ListingsAdminController> {
  const AddProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ListingsAdminController controller = Get.put(ListingsAdminController());
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            EraText(
              text: 'PROPERTY INFORMATION',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w500,
            ),
            EraText(
              text: 'ADD PROJECTS',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w600,
            ),
            EraText(
              text: 'BANNER PHOTO ',
              color: AppColors.black,
              fontSize: EraTheme.header - 10.sp,
              fontWeight: FontWeight.w600,
            ),
            AddAgent.buildUploadPhoto(onTap: () {
              controller.getImageGallery();
            }),
            SizedBox(height: 20.h),
            Row(
              children: [
                _buildTextField(
                  controller: controller.propertyNameController,
                  label: 'Property Name *',
                ),
                sbw20(),
                _buildTextField(
                  controller: controller.developerController,
                  label: 'Developer *',
                ),
                sbw20(),
                _buildTextField(
                  controller: controller.developerController,
                  label: '3D Virtual Tour Link *',
                ),
                sbw20(),
                _buildTextField(
                  controller: controller.locationControllers,
                  label: 'Location *',
                ),
              ],
            ),
            sb20(),
            SizedBox(
              width: Get.width,
              child: TextformfieldWidget(
                controller: controller.descriptionController,
                hintText: 'Description *',
                maxLines: 8,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
              ),
            ),
            sb20(),
            Row(
              children: [
                buildFeautredPhoto(onTap: () {
                  controller.getImageGallery();
                }),
                sbw10(),
                SizedBox(
                  width: Get.width / 4.2,
                  child: TextformfieldWidget(
                    controller: controller.addFeaturedDesc1,
                    hintText: 'Description *',
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                buildFeautredPhoto(onTap: () {
                  controller.getImageGallery();
                }),
                sbw10(),
                SizedBox(
                  width: Get.width / 4.2,
                  child: TextformfieldWidget(
                    controller: controller.addFeaturedDesc2,
                    hintText: 'Description *',
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                buildFeautredPhoto(
                    title: 'Outdoor Amenities',
                    onTap: () {
                      controller.getImageGallery();
                    }),
                sbw10(),
                SizedBox(
                  width: Get.width / 4.2,
                  child: TextformfieldWidget(
                    controller: controller.outdoorAmenitiesController,
                    hintText: 'Description *',
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                buildFeautredPhoto(
                    title: 'Indoor Amenities',
                    onTap: () {
                      controller.getImageGallery();
                    }),
                sbw10(),
                SizedBox(
                  width: Get.width / 4.2,
                  child: TextformfieldWidget(
                    controller: controller.indoorAmenitiesController,
                    hintText: 'Description *',
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            ),

            //3 options to put carousel

            buildCarouselOption(
              controller: controller,
              title: 'CAROUSEL 1',
              controller1: controller.areaController,
              controller2: controller.roomController,
              controller3: controller.balconyController,
              controller4: controller.carouselDesc,
            ),

            buildCarouselOption(
              controller: controller,
              title: 'CAROUSEL 2',
              controller1: controller.areaController1,
              controller2: controller.roomController2,
              controller3: controller.balconyController3,
              controller4: controller.carouselDesc2,
            ),

            buildCarouselOption(
              controller: controller,
              title: 'CAROUSEL 3',
              controller1: controller.areaController4,
              controller2: controller.roomController5,
              controller3: controller.balconyController6,
              controller4: controller.carouselDesc3,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  text: 'SUBMIT',
                  bgColor: AppColors.blue,
                  borderRadius: BorderRadius.circular(30),
                ),
                Button(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  width: 150.w,
                  text: 'CANCEL',
                  bgColor: AppColors.hint,
                  borderRadius: BorderRadius.circular(30),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {TextEditingController? controller,
      String? label,
      TextInputType? keyboardType}) {
    return SizedBox(
      width: Get.width / 5.1,
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildFeautredPhoto({void Function()? onTap, String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: title ?? 'ADD FEATURED PHOTOS',
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            Container(
              width: 300.w,
              height: 250.h,
              decoration: BoxDecoration(
                color: AppColors.hint.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.hint.withOpacity(0.9),
                  width: 2,
                ),
              ),
              child: Center(
                child: Image.asset(AppEraAssets.uploadAdmin),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarouselOption({
    ListingsAdminController? controller,
    String? title,
    TextEditingController? controller1,
    TextEditingController? controller2,
    TextEditingController? controller3,
    TextEditingController? controller4,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title!,
          color: AppColors.black,
          fontSize: EraTheme.header - 10.sp,
          fontWeight: FontWeight.w600,
        ),
        EraText(
          text: 'Add photos (min 10)',
          color: AppColors.black,
          fontSize: EraTheme.header - 12.sp,
          fontWeight: FontWeight.w500,
        ),
        GestureDetector(
          onTap: () {
            //im not sure if this is the right function to call
            controller!.getImageGallery();
          },
          child: Container(
            width: Get.width,
            height: 250.h,
            decoration: BoxDecoration(
              color: AppColors.hint.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.hint.withOpacity(0.9),
                width: 2,
              ),
            ),
            child: Center(
              child: Image.asset(AppEraAssets.uploadAdmin),
            ),
          ),
        ),
        sb20(),
        Row(
          children: [
            _buildTextField(
              controller: controller1,
              label: 'Area *',
            ),
            sbw20(),
            _buildTextField(
              controller: controller2,
              label: 'Number of Rooms *',
            ),
            sbw20(),
            _buildTextField(
              controller: controller3,
              label: 'Balcony Size *',
            ),
          ],
        ),
        sb20(),
        TextformfieldWidget(
          controller: controller4,
          hintText: 'Description *',
          maxLines: 8,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
        ),
        sb20(),
      ],
    );
  }
}
