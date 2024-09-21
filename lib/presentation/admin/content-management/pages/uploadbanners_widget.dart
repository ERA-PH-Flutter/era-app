import 'dart:typed_data';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/constants/theme.dart';

class UploadBannersWidget extends StatelessWidget {
  final String? text;
  final int maxImages;
  final EdgeInsets? padding;
  final Function(Uint8List)? onImageSelected;
  final Function(List<Uint8List>)? onImageSelectedMany;
  const UploadBannersWidget(
      {super.key, this.text, required this.maxImages, this.onImageSelected,this.padding,this.onImageSelectedMany});

  @override
  Widget build(BuildContext context) {
    Get.delete<AddListingsController>();
    AddListingsController addListingsController =
        Get.put(AddListingsController());
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Reusing textBuild function
              AddListings.textBuild(text ?? 'UPLOAD BANNERS', EraTheme.header,
                  FontWeight.w600, AppColors.black,padding: EdgeInsets.zero),
              Obx(() => AddListings.textBuild(
                  '${addListingsController.images.length}/$maxImages',
                  22.sp,
                  FontWeight.w600,
                  Colors.black)),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
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
                onPressed: () async {
                  if (maxImages != 1) {
                    await addListingsController.pickImageFromWeb();
                    if (onImageSelectedMany != null) {
                      List<Uint8List> listUint = [];
                      addListingsController.images.forEach((image){
                        listUint.add(image);
                      });
                      onImageSelectedMany!(listUint);
                      return;
                    }
                  } else {
                    try {
                      final imagePick = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      var image = await imagePick!.readAsBytes();
                      if (onImageSelected != null) {
                        onImageSelected!(image);
                        return;
                      }
                      //con.selectedImage = image;
                      addListingsController.images.value = [image];
                    } catch (e) {
                      print(e);
                    }
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
            ],
          ),
          SizedBox(height: 10.h),
          Obx(() {
            if (addListingsController.images.isEmpty) {
              return _buildUploadPhoto();
            } else {
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
                itemCount: addListingsController.images.length,
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
                              image: MemoryImage(
                                addListingsController.images[index],
                              )),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 5.w,
                        child: IconButton(
                          icon: Icon(
                            Icons.cancel,
                            color: AppColors.black,
                          ),
                          onPressed: () {
                            addListingsController.images.removeAt(index);
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          }),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20.w),
          //   child: EraText(
          //     text: 'Photo must be at least 300px X 300px',
          //     fontSize: 15.sp,
          //     color: AppColors.hint,
          //   ),
          // ),
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
