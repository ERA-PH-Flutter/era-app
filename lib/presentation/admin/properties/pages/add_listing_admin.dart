// ignore_for_file: invalid_use_of_protected_member

import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listing_admin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reorderables/reorderables.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/models/geocode.dart';
import '../../../../app/widgets/era_place_search.dart';
import '../../../../repository/logs.dart';
import '../../../agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
//todo add text

class AddPropertyAdmin extends GetView<ListingsController> {
  const AddPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    //temporary
    //AgentAdminController controllers = Get.put(AgentAdminController());
    AddListingsController addListingsController =
        Get.put(AddListingsController());
    return Obx(() {
      if (controller.state.value == AdminEditState.loaded) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin - 5.w),
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
                  text: 'CREATE LISTING',
                  color: AppColors.black,
                  fontSize: EraTheme.header,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 10.h,
                ),
                AddAgent.buildTextFormField2(
                  'Property Name *',
                  addListingsController.propertyNameController,
                  'Property Cost *',
                  addListingsController.propertyCostController,
                  onChanged: (value) {
                    value = value.replaceAll(',', '');
                    if (value.isNotEmpty) {
                      final formattedValue = value.replaceAllMapped(
                          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},');
                      addListingsController.propertyCostController.value =
                          TextEditingValue(
                        text: formattedValue,
                        selection: TextSelection.collapsed(
                            offset: formattedValue.length),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 10.h,
                ),
                AddAgent.buildTextFormField4(
                    text: 'Price per sqm *',
                    controller: addListingsController.pricePerSqmController,
                    onChanged: (value) {
                      value = value.replaceAll(',', '');

                      if (value.isNotEmpty) {
                        final formattedValue = value.replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},');
                        addListingsController.pricePerSqmController.value =
                            TextEditingValue(
                          text: formattedValue,
                          selection: TextSelection.collapsed(
                              offset: formattedValue.length),
                        );
                      }
                    },
                    text2: 'Area*',
                    controller2: addListingsController.areaController,
                    text3: 'Rooms *',
                    controller3: addListingsController.bedsController,
                    text4: 'Bathrooms *',
                    controller4: addListingsController.bathsController),
                SizedBox(
                  height: 10.h,
                ),
                //with dropdown
                Row(
                  children: [
                    SizedBox(
                      height: 126.h,
                      width: Get.width / 2.5,
                      child: AddListings.dropDownAddlistings(
                          padding: EdgeInsets.zero,
                          selectedItem: addListingsController.selectedPropertyT,
                          Types: addListingsController.propertyT,
                          onChanged: (value) => addListingsController
                              .selectedPropertyT.value = value!,
                          name: 'Property Type *',
                          hintText: 'Edit Property Type'),
                    ),
                    SizedBox(
                      height: 126.h,
                      width: Get.width / 2.46,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 37.h,
                          ),
                          Button(
                            height: 65.h,
                            width: Get.width / 2.2,
                            margin: EdgeInsets.symmetric(
                                horizontal: EraTheme.paddingWidth),
                            fontSize: 20.sp,
                            bgColor: Colors.red,
                            text: 'Pick Address',
                            onTap: () {
                              controller.state.value = AdminEditState.picker;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                        text: "Listing Location ( Search or Pick )",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: Get.width,
                      child: EraPlaceSearch(
                        textFieldController:
                            addListingsController.addressController,
                        callback: (coordinate) async {
                          addListingsController.latLng = coordinate;
                          addListingsController.add = await GeoCode(
                                  apiKey: "65d99e660931a611004109ogd35593a",
                                  lat: coordinate.latitude.toDouble(),
                                  lng: coordinate.longitude.toDouble())
                              .reverse();
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 126.h,
                            width: Get.width / 5.1 - 4.w,
                            child: AddListings.dropDownAddlistings(
                                padding: EdgeInsets.zero,
                                selectedItem:
                                    addListingsController.selectedOfferT,
                                Types: addListingsController.offerT,
                                onChanged: (value) => addListingsController
                                    .selectedOfferT.value = value!,
                                name: 'Offer Type *',
                                hintText: 'Select Offer Type'),
                          ),
                        ],
                      ),
                      sbw25(),
                      SizedBox(
                        height: 126.h,
                        width: Get.width / 5.1 - 4.w,
                        child: AddListings.dropDownAddlistings(
                            padding: EdgeInsets.zero,
                            selectedItem: addListingsController.selectedView,
                            Types: addListingsController.viewL,
                            onChanged: (value) => addListingsController
                                .selectedView.value = value!,
                            name: 'View *',
                            hintText: 'Select View'),
                      ),
                      sbw25(),
                      SizedBox(
                        height: 126.h,
                        width: Get.width / 5.1 - 4.w,
                        child: AddListings.dropDownAddlistings(
                            padding: EdgeInsets.zero,
                            selectedItem: addListingsController
                                .selectedPropertySubCategory,
                            Types: addListingsController.subCategory,
                            onChanged: (value) => addListingsController
                                .selectedPropertySubCategory.value = value!,
                            name: 'Subcategory Type *',
                            hintText: 'Select Subcategory Type'),
                      ),
                      sbw25(),
                      Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EraText(
                              text: 'Parking *',
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              lineHeight: 0.5,
                            ),
                            sb10(),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.w),
                              height: 120.h,
                              width: Get.width / 5.1 - 4.w,
                              child: TextformfieldWidget(
                                controller:
                                    addListingsController.carsController,
                                fontSize: 12.sp,
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                sb30(),
                AddAgent.buildTextFieldFormDesc(
                    'Description *', addListingsController.descController),
                SizedBox(
                  height: 10.h,
                ),

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
                        onPressed: () async {
                          await addListingsController.pickImageFromWeb();
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
                  if (addListingsController.images.isEmpty) {
                    return AddAgent.buildUploadPhoto();
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
                      children: List.generate(
                          addListingsController.images.length, (index) {
                        return Stack(
                          children: [
                            Container(
                              key: ValueKey(index),
                              margin:
                                  EdgeInsets.only(right: 10.w, bottom: 10.w),
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
                                    addListingsController.images
                                        .removeAt(index);
                                  },
                                ))
                          ],
                        );
                      }),
                    );

                    // Container(
                    //     child: GridView.builder(
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 4,
                    //         ),
                    //         shrinkWrap: true,
                    //         //scrollDirection: Axis.horizontal,
                    //         itemCount: addListingsController.images.length,
                    //         itemBuilder: (context, index) {
                    //           return Stack(
                    //             children: [
                    //               Container(
                    //                 margin: EdgeInsets.only(
                    //                     right: 10.w, bottom: 10.w),
                    //                 alignment: Alignment.center,
                    //                 height: 400.h,
                    //                 width: 400.w,
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(10),
                    //                   image: DecorationImage(
                    //                       fit: BoxFit.cover,
                    //                       image: MemoryImage(
                    //                         addListingsController.images[index],
                    //                       )),
                    //                 ),
                    //               ),
                    //               Positioned(
                    //                 top: 5.h,
                    //                 right: 0,
                    //                 child: IconButton(
                    //                   icon: Icon(Icons.cancel),
                    //                   onPressed: () {
                    //                     addListingsController.images
                    //                         .removeAt(index);
                    //                   },
                    //                 ),
                    //               ),
                    //             ],
                    //           );
                    //         }));
                  }
                }),

                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Button(
                      onTap: () async {
                        BaseController().showLoading();
                        if (addListingsController
                            .propertyNameController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description:
                                "All fields are required! Only Description is optional property name",
                          );
                          return;
                        }

                        if (addListingsController
                            .propertyCostController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description:
                                "All fields are required! property cost",
                          );
                          return;
                        }

                        if (addListingsController
                            .pricePerSqmController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description:
                                "All fields are required! price per sqm",
                          );
                          return;
                        }
                        if (addListingsController.bedsController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required! beds",
                          );
                          return;
                        }
                        if (addListingsController
                            .bathsController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required! baths",
                          );
                          return;
                        }
                        if (addListingsController
                            .addressController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required! address",
                          );
                          return;
                        }
                        if (addListingsController.carsController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required!  cars",
                          );
                          return;
                        }
                        if (addListingsController.areaController.text.isEmpty) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required! area",
                          );
                          return;
                        }

                        if (addListingsController.selectedOfferT.value ==
                            null) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required!  offer type",
                          );
                          return;
                        }

                        if (addListingsController.selectedView.value == null) {
                          showErroDialogs(
                            title: "Error",
                            description: "All fields are required! view",
                          );
                          return;
                        }
                        if (addListingsController.selectedPropertyT.value ==
                            null) {
                          showErroDialogs(
                            title: "Error",
                            description:
                                "All fields are required! property type",
                          );
                          return;
                        }
                        if (addListingsController
                                .selectedPropertySubCategory.value ==
                            null) {
                          showErroDialogs(
                            title: "Error",
                            description:
                                "All fields are required! Only Description is optional",
                          );
                          return;
                        }
                        BaseController().showLoading();
                        try {
                          await Listing(
                              by: user!.id,
                              name: addListingsController
                                  .propertyNameController.text,
                              price: addListingsController
                                  .propertyCostController.text
                                  .replaceAll(',', '')
                                  .toDouble(),
                              ppsqm: addListingsController
                                  .pricePerSqmController.text
                                  .replaceAll(',', '')
                                  .toDouble(),
                              beds: addListingsController.bedsController.text
                                  .toInt(),
                              baths: addListingsController.bathsController.text
                                  .toInt(),
                              cars: addListingsController.carsController.text
                                  .toInt(),
                              area: addListingsController.areaController.text
                                  .toDouble(),
                              status: addListingsController.selectedOfferT.value
                                  .toString(),
                              propertyId:
                                  "ERA_listing${(settings!.listingCount! + 1).toString().padLeft(5, "0")}",
                              location: addListingsController.add.city,
                              type: addListingsController.selectedPropertyT.value.toString(),
                              subCategory: addListingsController.selectedPropertySubCategory.value.toString(),
                              description: addListingsController.descController.text,
                              view: addListingsController.selectedView.value.toString(),
                              address: addListingsController.addressController.text,
                              latLng: [
                                addListingsController.latLng!.latitude,
                                addListingsController.latLng!.longitude
                              ]).addListing(
                              addListingsController.images, user!.id);
                          await Logs(
                                  title:
                                      "${user!.firstname} ${user!.lastname} added a listing with ID ERA_listing${(settings!.listingCount! + 1).toString().padLeft(5, "0")}",
                                  type: "listing")
                              .add();
                          settings!.listingCount = settings!.listingCount! + 1;
                          await settings!.update();
                          addListingsController.showSuccessDialog(
                              hitApi: () {
                                BaseController().hideLoading();
                                Get.delete<AddListingsController>();
                                Get.put(AddListingsController());
                                Get.back();
                                Get.back();
                                addListingsController.clearFields();
                              },
                              title: "Add Listing Success",
                              description:
                                  "Listing has been uploaded to the database.");
                        } catch (e, ex) {
                          print(e);
                          print(ex);
                        }
                      },
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
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        );
      } else if (controller.state.value == AdminEditState.picker) {
        return _picker();
      } else {
        return _loading();
      }
    });
  }

  _loading() {
    //controller.loadData();
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static showErroDialogs({
    VoidCallback? onTap,
    String title = 'Error',
    String? description = 'Something went wrong',
  }) {
    showCupertinoDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) => Dialog(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.5),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              EraText(
                text: title,
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: Colors.red,
              ),
              SizedBox(
                height: 10.h,
              ),
              EraText(
                text: description ?? '',
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              Button(
                height: 48.h,
                text: "Okay",
                onTap: () {
                  Get.back();
                  Get.back();
                },
                bgColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _picker() {
    AddListingsController c = Get.find<AddListingsController>();
    return WillPopScope(
      onWillPop: () async {
        controller.state.value = AdminEditState.loaded;
        return Future.value(false);
      },
      child: Obx(() => SizedBox(
          width: 100.w,
          height: Get.height - 112.h,
          child: Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  buildingsEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(14.599512, 120.984222), zoom: 12),
                  markers: c.marker.value,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: true,
                  onTap: (position) async {
                    c.generateMarker(position);
                    c.latLng = position;
                    c.add = (await GeoCode(
                            apiKey: "65d99e660931a611004109ogd35593a",
                            lat: position.latitude,
                            lng: position.longitude)
                        .reverse());
                    c.address.value = c.add.displayName!;
                    c.addressController.text = c.address.value;
                  },
                ),
              ),
              Positioned(
                bottom: 100.h,
                child: Container(
                  width: Get.width - 270.w,
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidthSmall, vertical: 10.h),
                  margin:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Obx(() => EraText(
                        text: "Address: ${c.address.value}",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      )),
                ),
              ),
              Positioned(
                bottom: 21.w,
                child: Container(
                  alignment: Alignment.center,
                  width: Get.width - 270.w,
                  margin:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  height: 50.h,
                  child: Button(
                    width: Get.width - (EraTheme.paddingWidth * 2),
                    onTap: () {
                      controller.state.value = AdminEditState.loaded;
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
}
