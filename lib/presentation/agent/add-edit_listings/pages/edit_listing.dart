import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../repository/listing.dart';
import '../controllers/addlistings_controller.dart';
import 'addlistings.dart';

class EditListing extends GetView<AddListingsController> {
  const EditListing({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AddListings.textBuild(
              'EDIT LISTING', 25.sp, FontWeight.w600, AppColors.blue),
          SizedBox(height: 15.h),
          AddListings.textBuild('PROPERTY INFORMATION', 25.sp, FontWeight.w600,
              AppColors.kRedColor),
          SizedBox(height: 20.h),
          AddListings.buildWidget(
            'Property Name',
            TextformfieldWidget(hintText: 'Property Name', maxLines: 1),
          ),
          AddListings.buildWidget(
            'Property Cost',
            TextformfieldWidget(hintText: 'Php 100,000,000', maxLines: 1),
          ),
          AddListings.buildWidget(
            'Owner Listing',
            TextformfieldWidget(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                controller: controller.areaController,
                hintText: '',
                maxLines: 1),
          ),
          AddListings.textBuild(
              'UPLOAD PHOTOS', 22.sp, FontWeight.w600, AppColors.kRedColor),
          SizedBox(height: 10.h),
          // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shadowColor: Colors.transparent,
                  side: BorderSide(
                      color: AppColors.hint.withOpacity(0.1), width: 1),
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
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    shadowColor: Colors.transparent,
                    side: BorderSide(
                        color: AppColors.hint.withOpacity(0.1), width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (controller.images.isNotEmpty) {
                      controller.removeMode();
                    } else {
                      BaseController().showSuccessDialog(
                          title: "Error!",
                          description: "You have selected 0 image!");
                    }
                  },
                  icon: Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: AppColors.white,
                  ),
                  label: Obx(
                    () => EraText(
                      text: controller.removeImage.value &&
                              controller.images.isNotEmpty
                          ? 'Cancel'
                          : 'Remove',
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
            ],
          ),

          SizedBox(height: 10.h),
          Obx(() {
            if (controller.images.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Image.asset(
                  AppEraAssets.uploadphoto,
                ),
              );
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
                    return Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(controller.images[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.removeImage.value,
                            child: Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  controller.removeAt(index);
                                },
                                child: Icon(
                                  CupertinoIcons.xmark_circle_fill,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
            }
          }),

          SizedBox(height: 5.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
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
        AddListings.buildWidget(
          'Price per sqm',
          TextformfieldWidget(
              keyboardType: TextInputType.number,
              controller: controller.pricePerSqmController,
              hintText: 'Php 100,000',
              maxLines: 1),
        ),
        // AddListings.buildWidget(
        //   'Floor Area',
        //   TextformfieldWidget(
        //       keyboardType: TextInputType.number,
        //       controller: controller.floorAreaController,
        //       hintText: '151 sqm',
        //       maxLines: 1),
        // ),
        AddListings.buildWidget(
          'Beds',
          TextformfieldWidget(
              controller: controller.bedsController,
              hintText: '2',
              maxLines: 1),
        ),
        AddListings.buildWidget(
          'Baths',
          TextformfieldWidget(
              controller: controller.bathsController,
              hintText: '3',
              maxLines: 1),
        ),
        AddListings.buildWidget(
          'Area',
          TextformfieldWidget(
              controller: controller.areaController,
              hintText: '150 sqm',
              maxLines: 1),
        ),
        AddListings.dropDownAddlistings(
            controller.selectedOfferT,
            controller.offerT,
            (value) => controller.selectedOfferT.value = value!,
            'Offer Type',
            'Offer Type'),

        AddListings.buildWidget(
          'View',
          TextformfieldWidget(
              controller: controller.viewController,
              hintText: 'Sunrise',
              maxLines: 1),
        ),
        AddListings.buildWidget(
          'Location',
          TextformfieldWidget(
              controller: controller.locationController,
              hintText: 'Bonifacio Global City, Taguig',
              maxLines: 1),
        ),
        AddListings.dropDownAddlistings(
            controller.selectedPropertyT,
            controller.propertyT,
            (value) => controller.selectedPropertyT.value = value!,
            'Property Type',
            'Property Type'),

        AddListings.dropDownAddlistings(
            controller.selectedPropertySubCategory,
            controller.subCategory,
            (value) => controller.selectedPropertySubCategory.value = value!,
            'Sub Category',
            'Sub Category'),
        SizedBox(height: 20.h),
        Button.button2(390.w, 50.h, () async {
          BaseController().showLoading();
          await Listing(
                  name: controller.propertyNameController.text,
                  price: controller.propertyCostController.text.toDouble(),
                  photos: controller.images,
                  ppsqm: controller.pricePerSqmController.text.toDouble(),
                  // floorArea: controller.floorAreaController.text.toDouble(),
                  beds: controller.bedsController.text.toInt(),
                  baths: controller.bathsController.text.toInt(),
                  area: controller.areaController.text.toInt(),
                  // all the dropdown is not working
                  status: controller.selectedOfferT.value.toString(),
                  view: controller.viewController.text,
                  location: controller.locationController.text,
                  //not working
                  type: controller.selectedPropertyT.value,
                  //not working
                  subCategory:
                      controller.selectedPropertySubCategory.value.toString())
              .updateListing();
          BaseController().hideLoading();
        }, 'UPDATE LISTING'),
        SizedBox(height: 20.h),
      ],
    );
  }
}
