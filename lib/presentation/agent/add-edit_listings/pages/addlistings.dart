import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../repository/listing.dart';
import '../controllers/addlistings_controller.dart';

class AddListings extends GetView<AddListingsController> {
  const AddListings({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textBuild('CREATE LISTING', 25.sp, FontWeight.w600, AppColors.blue),
          SizedBox(height: 15.h),
          textBuild('PROPERTY INFORMATION', 25.sp, FontWeight.w600,
              AppColors.kRedColor),
          SizedBox(height: 20.h),
          buildWidget(
            'Property Name',
            TextformfieldWidget(
              controller: controller.propertyNameController,
              hintText: 'Property Name',
              maxLines: 1,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              keyboardType: TextInputType.text,
            ),
          ),
          buildWidget(
            'Property Cost',
            TextformfieldWidget(
              controller: controller.propertyCostController,
              hintText: '100,000,000',
              maxLines: 1,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              keyboardType: TextInputType.number,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textBuild(
                  'UPLOAD PHOTOS', 22.sp, FontWeight.w600, AppColors.kRedColor),
              Obx(() => textBuild('${controller.images.length}/15', 22.sp,
                  FontWeight.w600, Colors.black)),
            ],
          ),
          SizedBox(height: 10.h),
          // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
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
              ],
            ),
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
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: FileImage(controller.images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
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
        buildWidget(
          'Price per sqm',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            keyboardType: TextInputType.number,
            controller: controller.pricePerSqmController,
            hintText: '100',
            maxLines: 1,
          ),
        ),
        buildWidget(
          'Beds',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.bedsController,
            hintText: '2',
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        buildWidget(
          'Baths',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.bathsController,
            hintText: '3',
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        buildWidget(
          'Garage',
          TextformfieldWidget(
            keyboardType: TextInputType.number,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.carsController,
            hintText: '3',
            maxLines: 1,
          ),
        ),
        buildWidget(
          'Area',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.areaController,
            hintText: '150',
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        dropDownAddlistings(
            controller.selectedOfferT,
            controller.offerT,
            (value) => controller.selectedOfferT.value = value!,
            'Offer Type',
            'Select Offer Type'),
        dropDownAddlistings(
            controller.selectedView,
            controller.viewL,
            (value) => controller.selectedView.value = value!,
            'View',
            'Select View'),
        buildWidget(
          'Location',
          TextformfieldWidget(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              controller: controller.locationController,
              hintText: 'Bonifacio Global City, Taguig',
              maxLines: 1),
        ),
        dropDownAddlistings(
            controller.selectedPropertyT,
            controller.propertyT,
            (value) => controller.selectedPropertyT.value = value!,
            'Property Type',
            'Select Property Type'),
        dropDownAddlistings(
            controller.selectedPropertySubCategory,
            controller.subCategory,
            (value) => controller.selectedPropertySubCategory.value = value!,
            'Sub Category',
            'Select Sub Category'),
        buildWidget(
          'Description *',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.descController,
            hintText: '',
            maxLines: 10,
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(height: 20.h),
        Button.button2(390.w, 50.h, () async {
          BaseController().showLoading();
          try {
            await Listing(
              name: controller.propertyNameController.text,
              price: controller.propertyCostController.text.toDouble(),
              ppsqm: controller.pricePerSqmController.text.toDouble(),
              beds: controller.bedsController.text.toInt(),
              baths: controller.bathsController.text.toInt(),
              cars: controller.carsController.text.toInt(),
              area: controller.areaController.text.toInt(),
              status: controller.selectedOfferT.value.toString(),
              // view: controller.selectedView.value.toString(),
              location: controller.locationController.text,
              type: controller.selectedPropertyT.value.toString(),
              subCategory:
                  controller.selectedPropertySubCategory.value.toString(),
              description: controller.descController.text,
              view: controller.selectedView.value.toString(),
            ).addListing(controller.images);
          } catch (e, ex) {
            print(ex);
          }
          BaseController().hideLoading();
        }, 'CREATE LISTING'),
        SizedBox(height: 20.h),
      ],
    );
  }

  static Widget buildWidget(String text, TextformfieldWidget textFormField) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
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

  static Widget textBuild(
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

  static Widget dropDownAddlistings(RxnString selectedItem, List<String> Types,
      Function(String?) onChanged, String name, String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(text: name, fontSize: 18.sp, color: AppColors.black),
          SizedBox(height: 5.h),
          Obx(
            () => DropdownButtonFormField<String>(
              alignment: Alignment.centerLeft,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: AppColors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.black,
                    width: 1.5,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              dropdownColor: AppColors.white,
              focusColor: AppColors.hint,
              value: selectedItem.value,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              isExpanded: true,
              isDense: true,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: EraText(
                  text: hintText,
                  textAlign: TextAlign.center,
                  color: Colors.grey,
                  fontSize: 20.sp,
                ),
              ),
              items: Types.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: EraText(
                    text: value,
                    color: AppColors.black,
                    fontSize: 20.sp,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
