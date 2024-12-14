import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/geocode.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/era_place_search.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/controllers/listing_web_controller.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:reorderables/reorderables.dart';

import '../../../../../../app/constants/screens.dart';
import '../../../../../../app/widgets/custom_appbar.dart';
import '../../../../../../repository/listing.dart';
import '../../../../../../repository/logs.dart';
import '../../../../../agent/utility/controller/base_controller.dart';
import '../../../../landingpage/controller/homs_controller.dart';
import '../controllers/addlistings_controller.dart';

class EditListingWeb extends GetView<ListingsController> with BaseController {
  const EditListingWeb({super.key});

  @override

  // Get.put(AddListingsController());
  Widget build(BuildContext context) {
    //  Get.find<LandingPageController>().arguments;
    Get.put(ListingsController());

    return SizedBox(
      child: Obx(() => switch (controller.state.value) {
            AdminEditState.loading => _loading(),
            AdminEditState.loaded => _loaded(),
            AdminEditState.picker => _picker(),
          }),
    );
  }

  _loaded() {
    AddListingsController addListingsController =
        Get.find<AddListingsController>();
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.arrow_back)),
                sbw10(),
                EraText(
                  text: 'PROPERTY INFORMATION',
                  color: AppColors.black,
                  fontSize: EraTheme.header,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            EraText(
              text: 'EDIT LISTING',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w600,
            ),
            propertyWidgetDetails(),
            sb20(),
            detailsWidget(),
            sb40(),
            dropdownWidget(),
            sb20(),
            SharedWidgets.textFormfield(
              controller: addListingsController.descController,
              hintText: 'Description',
              MaxLines: 15,
              textInputType: TextInputType.multiline,
            ),
            sb20(),
            uploadPhotos(),
            sb20(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                    text: "Listing Location ( Search or Pick )",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(height: 5.h),
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
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
                  ),
                  Expanded(
                    flex: 1,
                    child: Button(
                      height: 65.h,
                      width: Get.width / 2.2,
                      margin: EdgeInsets.symmetric(
                          horizontal: EraTheme.paddingWidth),
                      fontSize: 20.sp,
                      bgColor: Colors.red,
                      text: 'Pick Address',
                      onTap: () {
                        ListingsController listingsController =
                            Get.find<ListingsController>();

                        listingsController.state.value = AdminEditState.picker;
                      },
                    ),
                  )
                ]),
              ],
            ),
            sb20(),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  onTap: () async {
                    try {
                      BaseController().showLoading();
                      await addListingsController.updateListing();
                      await Logs(
                              title:
                                  "${user!.firstname} ${user!.lastname} edited a listing with ID ${controller.listing!.propertyId}",
                              type: "listing")
                          .add();
                      BaseController().showSuccessDialog(
                          description: "Edit Listing Success",
                          hitApi: () {
                            Get.back();
                            Get.back();
                            Get.delete<AddListingsController>();
                            selectedIndex.value = 17;
                            Get.find<HomsController>().onNavbarItemSelected(17);
                            // Get.find<LandingPageController>()
                            //     .onSectionSelected(5);
                          });
                    } catch (e) {
                      BaseController().showErroDialog(
                          description: e.toString(), onTap: () {});
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
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _locationPick() {
    AddListingsController addListingsController =
        Get.find<AddListingsController>();
    return WillPopScope(
      onWillPop: () async {
        addListingsController.addEditListingsState.value =
            AddEditListingsState.loaded;
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
                  markers: addListingsController.marker.value,
                  mapToolbarEnabled: false,
                  myLocationButtonEnabled: true,
                  onTap: (position) async {
                    addListingsController.generateMarker(position);
                    addListingsController.latLng = position;
                    addListingsController.add = (await GeoCode(
                            apiKey: "65d99e660931a611004109ogd35593a",
                            lat: position.latitude,
                            lng: position.longitude)
                        .reverse());
                    addListingsController.address.value =
                        addListingsController.add.displayName!;
                    addListingsController.addressController.text =
                        addListingsController.address.value;
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
                        text: "Address: ${addListingsController.address.value}",
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
                      addListingsController.addEditListingsState.value =
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

  static Widget dropDownAddlistings({
    RxnString? selectedItem,
    // ignore: non_constant_identifier_names
    List<String>? Types,
    Function(String?)? onChanged,
    String? name,
    String? hintText,
    Color? color,
    EdgeInsets? padding,
  }) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
              text: name!, fontSize: 18.sp, color: color ?? AppColors.black),
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
              value: selectedItem!.value,
              style: TextStyle(color: Colors.white),
              iconEnabledColor: Colors.black,
              isExpanded: true,
              isDense: true,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: EraText(
                  text: hintText!,
                  textAlign: TextAlign.center,
                  color: Colors.grey,
                  fontSize: 20.sp,
                ),
              ),
              items: Types!.map<DropdownMenuItem<String>>((String value) {
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

  static Widget dropDownAddlistings1({
    RxnString? selectedItem,
    // ignore: non_constant_identifier_names
    List<String>? Types,
    Function(String?)? onChanged,
    String? name,
    String? hintText,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(text: name!, fontSize: 18.sp, color: color ?? AppColors.black),
        SizedBox(height: 5.h),
        Obx(
          () => Container(
            height: 50.h,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 21.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(99),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                //borderRadius: BorderRadius.circular(99),
                alignment: Alignment.centerLeft,
                dropdownColor: AppColors.white,
                focusColor: AppColors.hint,
                value: selectedItem!.value,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                isExpanded: true,
                isDense: true,
                hint: Align(
                  alignment: Alignment.centerLeft,
                  child: EraText(
                    text: hintText!,
                    textAlign: TextAlign.center,
                    color: Colors.grey,
                    fontSize: 20.sp,
                  ),
                ),
                items: Types!.map<DropdownMenuItem<String>>((String value) {
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
          ),
        ),
        SizedBox(height: 20.h),
      ],
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
                  // if (hitApi != null) {

                  // }
                  // if (Get.isDialogOpen!)
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

  Widget propertyWidgetDetails() {
    AddListingsController addListingsController =
        Get.find<AddListingsController>();
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: SharedWidgets.textFormfield(
              controller: addListingsController.propertyNameController,
              hintText: 'Property Name',
            )),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.textFormfield(
            controller: addListingsController.propertyCostController,
            hintText: 'Property Cost',
            textInputType: TextInputType.number,
            onChanged: (value) {
              value = value.replaceAll(',', '');
              if (value.isNotEmpty) {
                final formattedValue = value.replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},');
                addListingsController.propertyCostController.value =
                    TextEditingValue(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget uploadPhotos() {
    AddListingsController addListingsController =
        Get.find<AddListingsController>();
    return Column(
      children: [
        Row(
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
        SizedBox(height: 10.h),
        Obx(() {
          if (addListingsController.images.isEmpty) {
            return buildUploadPhoto();
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
                } else {}
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
                      width: 350.w,
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
    );
    //  Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     textBuild('UPLOAD PHOTOS', 22.sp, FontWeight.w600, AppColors.kRedColor),
    //     Obx(() => textBuild('${controller.images.length}/15', 22.sp,
    //         FontWeight.w600, Colors.black)),
    //   ],
    // );
  }

  Widget dropdownWidget() {
    AddListingsController controller = Get.find<AddListingsController>();
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SharedWidgets.dropDownListings(
              selectedItem: controller.selectedPropertyT,
              Types: propertyT,
              onChanged: (value) => controller.selectedPropertyT.value = value!,
              hintText: 'Select Property Type'),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.dropDownListings(
              selectedItem: controller.selectedPropertySubCategory,
              Types: subCategory,
              onChanged: (value) =>
                  controller.selectedPropertySubCategory.value = value!,
              hintText: 'Select Subcategory Type'),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.dropDownListings(
              selectedItem: controller.selectedView,
              Types: controller.viewL,
              onChanged: (value) => controller.selectedView.value = value!,
              hintText: 'Select View'),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.dropDownListings(
            selectedItem: controller.selectedOfferT,
            Types: controller.offerT,
            onChanged: (value) => controller.selectedOfferT.value = value!,
            hintText: 'Select Offer Type',
          ),
        ),
      ],
    );
  }

  Widget detailsWidget() {
    AddListingsController controller = Get.find<AddListingsController>();
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: SharedWidgets.textFormfield(
              controller: controller.pricePerSqmController,
              hintText: 'Price Per Sqm',
              onChanged: (value) {
                value = value.replaceAll(',', '');
                controller.pricePerSqmController.text = value.replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (Match m) => '${m[1]},');
                controller.pricePerSqmController.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length));
              },
            )),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.textFormfield(
            controller: controller.floorArea,
            hintText: 'Floor Area',
            textInputType: TextInputType.number,
          ),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.textFormfield(
            controller: controller.areaController,
            hintText: 'Lot Area',
            textInputType: TextInputType.number,
          ),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.textFormfield(
            controller: controller.bedsController,
            hintText: 'Bedrooms',
            textInputType: TextInputType.number,
          ),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.textFormfield(
            controller: controller.bathsController,
            hintText: 'Batrooms',
            textInputType: TextInputType.number,
          ),
        ),
        sbw10(),
        Expanded(
          flex: 1,
          child: SharedWidgets.textFormfield(
            controller: controller.carsController,
            hintText: 'Garage',
            textInputType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  _picker() {
    AddListingsController c = Get.find<AddListingsController>();
    return WillPopScope(
      onWillPop: () async {
        ListingsController listingsController = Get.find<ListingsController>();

        listingsController.state.value = AdminEditState.loaded;
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
                      ListingsController listingsController =
                          Get.find<ListingsController>();

                      listingsController.state.value = AdminEditState.loaded;
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

  Widget buildUploadPhoto({text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: text ?? ' Upload Photo *',
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
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
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
