import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/geocode.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/places_textfield.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:map_location_picker/map_location_picker.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../../../../../repository/listing.dart';
import '../../../../global.dart';
import '../../../utility/controller/base_controller.dart';
import '../controllers/addlistings_controller.dart';
import 'package:google_places_flutter/model/prediction.dart' as Predict;

class AddListings extends GetView<AddListingsController> with BaseController {
  const AddListings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Obx(() => switch (controller.addEditListingsState.value) {
                  AddEditListingsState.loaded => _loaded(),
                  AddEditListingsState.loading => _loading(),
                  AddEditListingsState.location_pick => _locationPick()
                })));
  }

  _loaded() {
    return Column(
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
            onChanged: (value) {
              value = value.replaceAll(',', '');
              controller.propertyCostController.text = value.replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},');
            },
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
    );
  }

  _loading() {
    return Center(
      child: GestureDetector(
          onTap: () {
            print("Debug: Checking addListingsState value");
            print(controller.addListingsState.value == AddListingsState.loaded);
          },
          child: CircularProgressIndicator()),
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
        buildWidget(
          'Price per sqm',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            keyboardType: TextInputType.number,
            controller: controller.pricePerSqmController,
            hintText: '100,000',
            maxLines: 1,
            onChanged: (value) {
              value = value.replaceAll(',', '');
              controller.pricePerSqmController.text = value.replaceAllMapped(
                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                  (Match m) => '${m[1]},');
            },
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
            //   focusNode: controller.bathsFocusNode,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.bathsController,
            hintText: '3',
            maxLines: 1,
            keyboardType: TextInputType.number,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
              child: EraText(
                  text: "Listing Location",
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
            ),
            SizedBox(height: 5.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
              width: Get.width,
              child: PlacesTextField(
                focusNode: controller.addressFocusNode,
                onPredict: (Predict.Prediction postalCodeResponse) async {
                  controller.addressController.text =
                      postalCodeResponse.description!;
                  controller.latLng = LatLng(postalCodeResponse.lat!.toDouble(),
                      postalCodeResponse.lng!.toDouble());
                  controller.add = await GeoCode(
                          apiKey: "65d99e660931a611004109ogd35593a",
                          lat: postalCodeResponse.lat!.toDouble(),
                          lng: postalCodeResponse.lng!.toDouble())
                      .reverse();
                },
                textController: controller.addressController,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
        // AddListings.buildWidget(
        //   'Address',
        //   TextformfieldWidget(
        //     controller: controller.addressController,
        //     hintText: 'Address',
        //     maxLines: 1,
        //     keyboardType: TextInputType.text,
        //   ),
        // ),
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
        SizedBox(height: 20.h),
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
          selectedItem: controller.selectedOfferT,
          Types: controller.offerT,
          onChanged: (value) => controller.selectedOfferT.value = value!,
          name: 'Offer Type',
          hintText: 'Select Offer Type',
        ),
        dropDownAddlistings(
          selectedItem: controller.selectedView,
          Types: controller.viewL,
          onChanged: (value) => controller.selectedView.value = value!,
          name: 'View',
          hintText: 'Select View',
        ),
        dropDownAddlistings(
          selectedItem: controller.selectedPropertyT,
          Types: controller.propertyT,
          onChanged: (value) => controller.selectedPropertyT.value = value!,
          name: 'Property Type',
          hintText: 'Select Property Type',
        ),
        dropDownAddlistings(
          selectedItem: controller.selectedPropertySubCategory,
          Types: controller.subCategory,
          onChanged: (value) =>
              controller.selectedPropertySubCategory.value = value!,
          name: 'Sub Category',
          hintText: 'Select Sub Category',
        ),
        // SearchLocationWidget(),
        buildWidget(
          'Description *',
          TextformfieldWidget(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            controller: controller.descController,
            hintText: '',
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 15,
          ),
        ),

        SizedBox(height: 20.h),
        Button.button2(390.w, 50.h, () async {
          print(
              "ERA_listing${(settings!.listingCount! + 1).toString().padLeft(5, '0')}");
          if (controller.propertyNameController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description:
                  "All fields are required! Only Description is optional",
            );
            return;
          }

          if (controller.propertyCostController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }

          if (controller.pricePerSqmController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.bedsController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.bathsController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.addressController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.carsController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.areaController.text.isEmpty) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.latLng == null) {
            showErroDialogs(
              title: "Error",
              description: "Please pick or choose a valid one!",
            );
            return;
          }
          if (controller.selectedOfferT.value == null) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }

          if (controller.selectedView.value == null) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.selectedPropertyT.value == null) {
            showErroDialogs(
              title: "Error",
              description: "All fields are required!",
            );
            return;
          }
          if (controller.selectedPropertySubCategory.value == null) {
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
                name: controller.propertyNameController.text,
                price: controller.propertyCostController.text
                    .replaceAll(',', '')
                    .toDouble(),
                ppsqm: controller.pricePerSqmController.text
                    .replaceAll(',', '')
                    .toDouble(),
                beds: controller.bedsController.text.toInt(),
                baths: controller.bathsController.text.toInt(),
                cars: controller.carsController.text.toInt(),
                area: controller.areaController.text.toInt(),
                status: controller.selectedOfferT.value.toString(),
                // view: controller.selectedView.value.toString(),
                location: controller.add.city,
                type: controller.selectedPropertyT.value.toString(),
                subCategory:
                    controller.selectedPropertySubCategory.value.toString(),
                description: controller.descController.text,
                view: controller.selectedView.value.toString(),
                address: controller.addressController.text,
                propertyId:
                    "ERA_listing${(settings!.listingCount! + 1).toString().padLeft(5, '0')}",
                latLng: [
                  controller.latLng!.latitude,
                  controller.latLng!.longitude
                ]).addListing(controller.images, user!.id);
            settings!.listingCount = settings!.listingCount! + 1;
            await settings!.update();
            controller.showSuccessDialog(
                hitApi: () {
                  Get.offAllNamed(RouteString.agentDashBoard);
                },
                title: "Add Listing Success",
                description: "Listing has been uploaded to the database.");
          } catch (e, ex) {
            print(e);
          }
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
      String text, double fontSize, FontWeight fontWeight, Color color,
      {padding}) {
    return Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w),
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

  static Widget dropDownAddlistings({
    RxnString? selectedItem,
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
}
