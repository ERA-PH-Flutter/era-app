import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listing_admin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../app/models/geocode.dart';

//todo add new controller
//done
class EditPropertyAdmin extends GetView<ListingsController> {
  const EditPropertyAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    //  Get.find<LandingPageController>().arguments;
    return Obx(() => switch (controller.state.value) {
          AdminEditState.loading => _loading(),
          AdminEditState.loaded => _loaded(),
          AdminEditState.picker => _picker(),
        });
  }

  _loading() {
    //controller.loadData();
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _loaded() {
    Get.put(AddListingsController());
    AddListingsController addListingsController =
        Get.find<AddListingsController>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
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
              text: 'EDIT LISTING',
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
            ),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFormField4(
                text: 'Price per sqm *',
                controller: addListingsController.pricePerSqmController,
                text2: 'Area *',
                controller2: addListingsController.areaController,
                text3: 'Rooms *',
                controller3: addListingsController.bedsController,
                text4: 'Bathrooms *',
                controller4: addListingsController.bathsController),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                children: [
                  Container(
                    height: 126.h,
                    width: Get.width / 2.5,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: addListingsController.selectedPropertyT,
                        Types: addListingsController.propertyT,
                        onChanged: (value) =>
                            addListingsController.selectedPropertyT.value,
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
            ),

            AddListings.buildWidget(
              'Address',
              TextformfieldWidget(
                controller: addListingsController.addressController,
                hintText: 'Address',
                maxLines: 1,
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: 10.h,
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
                      Container(
                        height: 126.h,
                        width: Get.width / 5.1 - 4.w,
                        child: AddListings.dropDownAddlistings(
                            padding: EdgeInsets.zero,
                            selectedItem: addListingsController.selectedOfferT,
                            Types: addListingsController.offerT,
                            onChanged: (value) =>
                                addListingsController.selectedOfferT.value,
                            name: 'Offer Type *',
                            hintText: 'Edit Offer Type'),
                      ),
                    ],
                  ),
                  sbw25(),
                  Container(
                    height: 126.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: addListingsController.selectedView,
                        Types: addListingsController.viewL,
                        onChanged: (value) =>
                            addListingsController.selectedView.value,
                        name: 'View *',
                        hintText: 'Edit View'),
                  ),
                  sbw25(),
                  Container(
                    height: 126.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem:
                            addListingsController.selectedPropertySubCategory,
                        Types: addListingsController.subCategory,
                        onChanged: (value) => addListingsController
                            .selectedPropertySubCategory.value,
                        name: 'Subcategory Type *',
                        hintText: 'Edit Subcategory Type'),
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
                          height: 60.h,
                          width: Get.width / 5.1 - 4.w,
                          child: TextformfieldWidget(
                            controller: addListingsController.carsController,
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
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFieldFormDesc(
                'Description *', addListingsController.descController),
            SizedBox(
              height: 10.h,
            ),
            // AddAgent.buildUploadPhoto(),
            // SizedBox(
            //   height: 10.h,
            // ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  onTap: () async {
                    try {
                      await addListingsController.updateListing();
                      Get.delete<AddListingsController>();
                      Get.find<LandingPageController>().onSectionSelected(5);
                    } catch (e) {}
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