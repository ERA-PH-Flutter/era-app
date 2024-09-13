import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';

import '../../../../app/constants/theme.dart';

class UploadBannersWidget extends StatelessWidget {
  final ContentManagementController controller;
  final String? text;
  final int maxImages;

  const UploadBannersWidget({
    super.key,
    required this.controller,
    this.text,
    required this.maxImages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Reusing textBuild function
              AddListings.textBuild(text ?? 'UPLOAD BANNERS', EraTheme.header,
                  FontWeight.w600, AppColors.black),
              AddListings.textBuild('${controller.images.length}/$maxImages',
                  22.sp, FontWeight.w600, Colors.black)
            ],
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shadowColor: Colors.transparent,
                    side: BorderSide(
                      color: AppColors.hint.withOpacity(0.1),
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    controller.getImageGallery();
                  },
                  icon: Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: AppColors.white,
                  ),
                  label: EraText(
                    text: 'Select Photos',
                    color: AppColors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Obx(() {
            if (controller.images.isEmpty) {
              return _buildUploadPhoto();
            } else {
              return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.h,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(controller.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }
          }),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: EraText(
              text: 'Photo must be at least 300px X 300px',
              fontSize: 15.sp,
              color: AppColors.hint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadPhoto() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width / 1.2 - 45.w,
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
    );
  }
}
