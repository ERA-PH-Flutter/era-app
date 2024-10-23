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
import 'package:image_picker/image_picker.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../app/constants/theme.dart';

class UploadBannersWidget extends StatelessWidget {
  final String? text;
  final int maxImages;
  final EdgeInsets? padding;
  final Function(Uint8List)? onImageSelected;
  final Function(List<Uint8List>)? onImageSelectedMany;

  const UploadBannersWidget({
    super.key,
    this.text,
    required this.maxImages,
    this.onImageSelected,
    this.padding,
    this.onImageSelectedMany,
  });

  @override
  Widget build(BuildContext context) {
    Get.delete<AddListingsController>();
    AddListingsController addListingsController =
        Get.put(AddListingsController());

    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AddListings.textBuild(text ?? 'UPLOAD BANNERS', EraTheme.header,
                  FontWeight.w600, AppColors.black,
                  padding: EdgeInsets.zero),
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
                  try {
                    if (maxImages != 1) {
                      await addListingsController.pickImageFromWeb();
                      if (onImageSelectedMany != null) {
                        List<Uint8List> listUint = [];
                        for (var image in addListingsController.images) {
                          listUint.add(image);
                        }
                        onImageSelectedMany!(listUint);
                        return;
                      }
                    } else {
                      final imagePick = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (imagePick != null) {
                        var image = await imagePick.readAsBytes();
                        if (onImageSelected != null) {
                          onImageSelected!(image);
                        }
                        addListingsController.images.value = [
                          image
                        ]; // Add selected image
                      }
                    }
                  } catch (e) {
                    print('Error picking image: $e'); // Error handling
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

          // Image GridView
          Obx(() {
            if (addListingsController.images.isEmpty) {
              return _buildUploadPhoto();
            } else {
              return ReorderableWrap(
                onReorder: (oldIndex, newIndex) {
                  // if (oldIndex < newIndex) {
                  //   newIndex -= 1;
                  // }
                  //testing
                  if (oldIndex != newIndex) {
                    var oldImage = addListingsController.images[oldIndex];
                    var newImage = addListingsController.images[newIndex];
                    addListingsController.images[oldIndex] = newImage;
                    addListingsController.images[newIndex] = oldImage;
                  } else {
                    print('No change in order, indices are the same.');
                  }
                },
                children:
                    List.generate(addListingsController.images.length, (index) {
                  return Stack(
                    children: [
                      Container(
                        key: ValueKey(index),
                        margin: EdgeInsets.only(right: 10.w, bottom: 10.w),
                        alignment: Alignment.center,
                        height: 400.h,
                        width: 500.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(
                              addListingsController.images[index],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 5.h,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              addListingsController.images.removeAt(index);
                            },
                          ))
                    ],
                  );
                }),
              );
            }
          }),
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
        SizedBox(height: 20.h),
      ],
    );
  }
}
