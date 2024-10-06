import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:map_location_picker/map_location_picker.dart';
import '../../../../../app/constants/screens.dart';
import '../../../../../app/models/geocode.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../../../../../app/widgets/era_place_search.dart';
import '../controllers/addlistings_controller.dart';
import 'addlistings.dart';

class EditListing extends GetView<AddListingsController> {
  const EditListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SafeArea(
              child: Obx(() => switch (controller.addEditListingsState.value) {
                    AddEditListingsState.loading => _loading(),
                    AddEditListingsState.loaded => _loaded(),
                    AddEditListingsState.location_pick => _locationPick()
                  }),
            )));
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return Column(
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
          TextformfieldWidget(
            hintText: 'Property Name',
            maxLines: 1,
            controller: controller.propertyNameController,
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Property Name is required';
              }
              return null;
            },
          ),
        ),
        AddListings.buildWidget(
          'Property Cost',
          TextformfieldWidget(
            hintText: 'Php 100,000,000',
            maxLines: 1,
            controller: controller.propertyCostController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              value = value.replaceAll(',', '');
              controller.propertyCostController.text = value.replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Property Cost is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
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
                              onTap: () async {
                                //controller.listing?.photos![index];
                                await FirebaseStorage.instance
                                    .ref(controller.listing?.photos![index])
                                    .delete();
                                controller.listing?.photos?.removeAt(index);
                                await controller.listing?.updateListing();
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
    );
  }

  _locationPick() {
    return WillPopScope(
      onWillPop: () async {
        controller.addEditListingsState.value = AddEditListingsState.loaded;
        return Future.value(false);
      },
      child: Obx(() => SizedBox(
          width: Get.width,
          height: Get.height - 212.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(14.599512, 120.984222), zoom: 12),
                  markers: controller.marker.value,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: true,
                  onTap: (position) async {
                    controller.generateMarker(position);
                    controller.latLng = position;
                    controller.add = (await GeoCode(
                            apiKey: "65d99e660931a611004109ogd35593a",
                            lat: position.latitude,
                            lng: position.longitude)
                        .reverse());
                    controller.address.value = controller.add.displayName!;
                    controller.addressController.text =
                        controller.address.value;
                    //search for location
                  },
                ),
              ),
              Positioned(
                bottom: 75.h,
                child: Container(
                  width: Get.width - EraTheme.paddingWidth * 2,
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidthSmall, vertical: 10.h),
                  margin:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Obx(() => EraText(
                        text: "Address: ${controller.address.value}",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      )),
                ),
              ),

              Positioned(
                bottom: 21.w,
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width - (EraTheme.paddingWidth * 2),
                  margin:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  height: 35.h,
                  child: Button(
                    width: Get.width - (EraTheme.paddingWidth * 2),
                    onTap: () {
                      controller.addEditListingsState.value =
                          AddEditListingsState.loaded;
                    },
                    bgColor: AppColors.kRedColor,
                    text: "Select Location",
                  ),
                ),
              ),
              //widget that display location text
            ],
          ))),
    );
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
            maxLines: 1,
            onChanged: (value) {
              value = value.replaceAll(',', '');
              controller.pricePerSqmController.text = value.replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},');
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Price per sqm is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
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
            maxLines: 1,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Beds is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        AddListings.buildWidget(
          'Baths',
          TextformfieldWidget(
            controller: controller.bathsController,
            hintText: '3',
            maxLines: 1,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Baths is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        // AddListings.buildWidget(
        //   'Address',
        //   TextformfieldWidget(
        //     controller: controller.addressController,
        //     hintText: 'Address',
        //     maxLines: 1,
        //     keyboardType: TextInputType.text,
        //     validator: (value) {
        //       if (value == null || value.isEmpty) {
        //         return 'Address is required';
        //       }
        //
        //       return null;
        //     },
        //   ),
        // ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
              child: EraText(
                  text: "Listing Location ( Search or Pick )",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
            ),
            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
              width: Get.width,
              child: EraPlaceSearch(
                textFieldController: controller.addressController,
                callback: (coordinate)async{
                  controller.latLng = coordinate;
                  controller.add = await GeoCode(
                      apiKey: "65d99e660931a611004109ogd35593a",
                      lat: coordinate.latitude.toDouble(),
                      lng: coordinate.longitude.toDouble()).reverse();
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
        SizedBox(
          height: 48.h,
          width: Get.width,
          child: Button(
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            bgColor: Colors.red,
            text: 'Pick Address',
            onTap: () {
              controller.addEditListingsState.value =
                  AddEditListingsState.location_pick;
            },
          ),
        ),
        AddListings.buildWidget(
          'Garage',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.carsController,
            hintText: '3',
            maxLines: 1,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Garage is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        AddListings.buildWidget(
          'Area',
          TextformfieldWidget(
            controller: controller.areaController,
            hintText: '150 sqm',
            maxLines: 1,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Area is required';
              }
              if (double.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
          ),
        ),
        AddListings.dropDownAddlistings(
          selectedItem: controller.selectedOfferT,
          Types: controller.offerT,
          onChanged: (value) => controller.selectedOfferT.value = value!,
          name: 'Offer Type',
          hintText: 'Edit Offer Type',
        ),
        AddListings.dropDownAddlistings(
          selectedItem: controller.selectedView,
          Types: controller.viewL,
          onChanged: (value) => controller.selectedView.value = value!,
          name: 'View',
          hintText: 'Edit View',
        ),

        AddListings.dropDownAddlistings(
          selectedItem: controller.selectedPropertyT,
          Types: controller.propertyT,
          onChanged: (value) => controller.selectedPropertyT.value = value!,
          name: 'Property Type',
          hintText: 'Edit Property Type',
        ),

        AddListings.dropDownAddlistings(
          selectedItem: controller.selectedPropertySubCategory,
          Types: controller.subCategory,
          onChanged: (value) =>
              controller.selectedPropertySubCategory.value = value!,
          name: 'Sub Category',
          hintText: 'Edit Sub Category',
        ),
        AddListings.buildWidget(
          'Description *',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.descController,
            hintText: '',
            maxLines: 10,
            keyboardType: TextInputType.text,
            validator: (value) =>
                value!.isEmpty ? 'Description is required' : null,
          ),
        ),

        SizedBox(height: 20.h),
        Button.button2(390.w, 50.h, () async {
          controller.updateListing();
          BaseController().showSuccessDialog(
              description: "Edit Listing Success",
              hitApi: (){
                Get.back();
              }
          );
        }, 'UPDATE LISTING'),
        SizedBox(height: 20.h),
      ],
    );
  }
}
