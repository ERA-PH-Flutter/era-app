import 'dart:typed_data';

import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/app_text.dart';

class UploadPhotos extends StatelessWidget {
  final String? text;
  final int maxImages;
  final Function(Uint8List)? onImageSelected;

  final RxList<Uint8List> images = <Uint8List>[].obs;

  UploadPhotos({
    super.key,
    this.text,
    required this.maxImages,
    this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 10.h),
          _buildSelectPhotosButton(),
          SizedBox(height: 10.h),
          Obx(() {
            if (images.isEmpty) {
              return _buildUploadPhoto();
            } else {
              return _buildImagesGrid();
            }
          }),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AddListings.textBuild(
          text ?? 'UPLOAD BANNERS',
          EraTheme.header,
          FontWeight.w600,
          AppColors.black,
        ),
        Obx(() => AddListings.textBuild(
              '${images.length}/$maxImages',
              22.sp,
              FontWeight.w600,
              Colors.black,
            )),
      ],
    );
  }

  Widget _buildSelectPhotosButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ElevatedButton.icon(
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
        onPressed: () async {
          if (images.length >= maxImages) {
            Get.snackbar(
                'Limit reached', 'You can upload up to $maxImages images.');
            return;
          }

          try {
            final imagePick =
                await ImagePicker().pickImage(source: ImageSource.gallery);
            if (imagePick != null) {
              var image = await imagePick.readAsBytes();
              // Notify parent widget via callback
              onImageSelected?.call(image);
              images.add(image);
            }
          } catch (e) {
            print(e);
          }
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
    );
  }

  Widget _buildImagesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: maxImages == 1 ? 1 : 3,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.h,
        mainAxisExtent: maxImages == 1 ? 500.h : null,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.w, bottom: 10.w),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(images[index]),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 5.w,
              child: IconButton(
                icon: Icon(Icons.cancel, color: AppColors.black),
                onPressed: () {
                  images.removeAt(index);
                },
              ),
            ),
          ],
        );
      },
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
