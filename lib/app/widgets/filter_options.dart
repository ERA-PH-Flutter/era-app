import 'dart:ui';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  // Price Range
  var minPrice = 100.0.obs;
  var maxPrice = 1000.0.obs;
  TextEditingController minPriceController = TextEditingController();
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController lotAreaController = TextEditingController();
  TextEditingController floorAreaController = TextEditingController();
  TextEditingController pricePerSqmController = TextEditingController();

  // Rooms and Beds
  var bedrooms = 1.obs;
  var bathrooms = 1.obs;
  var beds = 1.obs;
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController bedsController = TextEditingController();

  // Location
  var beachfront = false.obs;
  var waterfront = false.obs;
  var cityView = false.obs;
  var mountainView = false.obs;
  var sunset = false.obs;
  var sunrise = false.obs;

  // Filter visibility
  var filtersVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    minPriceController.text = minPrice.value.toString();
    maxPriceController.text = maxPrice.value.toString();
    bedroomsController.text = bedrooms.value.toString();
    bathroomsController.text = bathrooms.value.toString();
    bedsController.text = beds.value.toString();
  }

  void resetFilters() {
    minPrice.value = 100.0;
    maxPrice.value = 1000.0;
    bedrooms.value = 1;
    bathrooms.value = 1;
    beds.value = 1;

    beachfront.value = false;
    waterfront.value = false;

    minPriceController.text = minPrice.value.toString();
    maxPriceController.text = maxPrice.value.toString();
    bedroomsController.text = bedrooms.value.toString();
    bathroomsController.text = bathrooms.value.toString();
    bedsController.text = beds.value.toString();
  }

  void toggleFiltersVisibility() {
    filtersVisible.value = !filtersVisible.value;
  }
}

// Reusable Price Range Widget
class PriceRangeFilter extends StatelessWidget {
  final FilterController controller;

  PriceRangeFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.h),
        EraText(text: 'Lot Area', fontSize: 18, color: AppColors.black),
        Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: RangeSlider(
                activeColor: AppColors.blue,
                inactiveColor: AppColors.hint,
                overlayColor: WidgetStatePropertyAll<Color>(AppColors.hint),
                values: RangeValues(
                    controller.minPrice.value, controller.maxPrice.value),
                min: 0,
                max: 2000,
                divisions: 50,
                labels: RangeLabels(
                  '\$${controller.minPrice.value.round()}',
                  '\$${controller.maxPrice.value.round()}',
                ),
                onChanged: (RangeValues values) {},
              ),
            )),
        SizedBox(height: 16.h),
      ],
    );
  }
}

// Reusable Rooms and Beds Widget
class RoomsAndBedsFilter extends StatelessWidget {
  final FilterController controller;

  RoomsAndBedsFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCounterRow('Bedrooms', controller.bedrooms),
        SizedBox(height: 15.h),
        _buildCounterRow('Bathrooms', controller.bathrooms),
        SizedBox(height: 15.h),
        _buildCounterRow('Garage', controller.beds),
      ],
    );
  }

  Widget _buildCounterRow(String label, bedrooms) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EraText(text: label, fontSize: 18, color: AppColors.black),
        Row(
          children: [
            _buildCounterButton(CupertinoIcons.minus, () {
              bedrooms--;
            }),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(
                  () => EraText(
                      text: bedrooms.value.toString(),
                      fontSize: 18,
                      color: AppColors.black),
                )),
            _buildCounterButton(CupertinoIcons.add, () {
              bedrooms++;
            }),
          ],
        ),
      ],
    );
  }

  InkWell _buildCounterButton(IconData icon, onpressed) {
    return InkWell(
      child: IconButton(onPressed: onpressed, icon: Icon(icon)),
    );
  }
}

// Reusable Property Type Widget
class PropertyTypeFilter extends StatelessWidget {
  final FilterController controller;

  const PropertyTypeFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    AddListingsController addListingsController =
        Get.put(AddListingsController());

    return Column(
      children: [
        SharedWidgets.dropDown(
            addListingsController.selectedPropertySubCategory,
            addListingsController.subCategory,
            (value) => addListingsController.selectedPropertySubCategory.value =
                value!,
            'Subcategory',
            'Subcategory'),
      ],
    );
  }
}

Widget _buildFloorAreaFilter({
  String? title,
  String? hintText,
  String? hintText2,
  final TextEditingController? controller,
}) {
  return Column(
    children: [
      EraText(
        text: title ?? 'Lot Area',
        fontSize: 18.sp,
        color: AppColors.black,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EraText(text: 'Min.', fontSize: 18.sp, color: AppColors.black),
              SizedBox(
                width: 180.w,
                child: TextformfieldWidget(
                  hintText: hintText ?? 'sqm',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  keyboardType: TextInputType.number,
                  controller: controller,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EraText(text: 'Max.', fontSize: 18.sp, color: AppColors.black),
              SizedBox(
                width: 180.w,
                child: TextformfieldWidget(
                  hintText: hintText2 ?? 'sqm',
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  keyboardType: TextInputType.number,
                  controller: controller,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

void openFilterDialog() {
  final FilterController controller = Get.put(FilterController());
  Get.dialog(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        insetPadding: REdgeInsets.fromLTRB(10, 10, 10, 10),
        shadowColor: AppColors.black,
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(CupertinoIcons.clear),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 95.w),
                        child: EraText(
                          text: 'Filters',
                          fontSize: 30.sp,
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  //PriceRangeFilter(controller: controller),

                  SizedBox(height: 10.h),
                  // property type
                  EraText(
                    text: 'Property Type',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 10.h),
                  PropertyTypeFilter(controller: controller),
                  //

                  SizedBox(height: 10.h),
                  //rooms and beds

                  SizedBox(height: 10.h),
                  RoomsAndBedsFilter(controller: controller),

                  SizedBox(height: 20.h),
                  _buildFloorAreaFilter(),
                  SizedBox(height: 20.h),

                  _buildFloorAreaFilter(
                    controller: controller.floorAreaController,
                    title: 'Floor Area',
                    hintText: 'sqm',
                    hintText2: 'sqm ',
                  ),
                  SizedBox(height: 20.h),

                  _buildFloorAreaFilter(
                    controller: controller.floorAreaController,
                    title: 'Price per sqm',
                    hintText: 'php',
                    hintText2: 'php',
                  )
                ],
              )),
        ),
      ),
    ),
  );
}
