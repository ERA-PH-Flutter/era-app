import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
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

  // Rooms and Beds
  var bedrooms = 1.obs;
  var bathrooms = 1.obs;
  var beds = 1.obs;
  TextEditingController bedroomsController = TextEditingController();
  TextEditingController bathroomsController = TextEditingController();
  TextEditingController bedsController = TextEditingController();

  // Property Types
  var propertyType = [
    'House',
    'Apartment',
    'Condominium',
    'Townhouse',
    'Land',
    'Commercial',
  ];
  var selectedPropertyType = RxnString();

  // Amenities
  var wifi = false.obs;
  var kitchen = false.obs;
  var washer = false.obs;
  var dryer = false.obs;
  var airConditioning = false.obs;
  var tv = false.obs;

  // Location
  var beachfront = false.obs;
  var waterfront = false.obs;

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
    propertyType = [
      'House',
      'Apartment',
      'Condominium',
      'Townhouse',
      'Land',
      'Commercial',
    ];
    wifi.value = false;
    kitchen.value = false;
    washer.value = false;
    dryer.value = false;
    airConditioning.value = false;
    tv.value = false;
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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.minPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Min Price'),
                onChanged: (value) {
                  controller.minPrice.value = double.tryParse(value) ?? 0.0;
                },
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller.maxPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Max Price'),
                onChanged: (value) {
                  controller.maxPrice.value = double.tryParse(value) ?? 0.0;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Obx(() => RangeSlider(
              activeColor: AppColors.blue,
              inactiveColor: AppColors.hint,
              overlayColor: WidgetStatePropertyAll<Color>(AppColors.hint),
              values: RangeValues(
                  controller.minPrice.value, controller.maxPrice.value),
              min: 0,
              max: 2000,
              divisions: 40,
              labels: RangeLabels(
                '\$${controller.minPrice.value.round()}',
                '\$${controller.maxPrice.value.round()}',
              ),
              onChanged: (RangeValues values) {},
            )),
        SizedBox(height: 16.h),
      ],
    );
  }
}

// Reusable Rooms and Beds Widget
class RoomsAndBedsFilter extends StatelessWidget {
  final FilterController controller;

  const RoomsAndBedsFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCounterRow('Bedrooms'),
        SizedBox(height: 15.h),
        _buildCounterRow('Beds'),
        SizedBox(height: 15.h),
        _buildCounterRow('Bathrooms'),
      ],
    );
  }

  Widget _buildCounterRow(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        EraText(text: label, fontSize: 18, color: AppColors.black),
        Row(
          children: [
            _buildCounterButton(CupertinoIcons.minus),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: EraText(text: '0', fontSize: 18, color: AppColors.black),
            ),
            _buildCounterButton(CupertinoIcons.add),
          ],
        ),
      ],
    );
  }

  InkWell _buildCounterButton(IconData icon) {
    return InkWell(
      child: Container(
        child: Icon(icon),
      ),
    );
  }
}

// Reusable Property Type Widget
class PropertyTypeFilter extends StatelessWidget {
  final FilterController controller;

  const PropertyTypeFilter({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedWidgets.dropDown(
            controller.selectedPropertyType,
            controller.propertyType,
            (value) => controller.selectedPropertyType.value = value!,
            'Property Type',
            'Property Type'),
      ],
    );
  }
}

// Reusable Amenities Widget
class AmenitiesFilter extends StatelessWidget {
  final FilterController controller;

  AmenitiesFilter({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildAmenityButton('Wifi', controller.wifi),
              SizedBox(width: 10.w),
              _buildAmenityButton('Kitchen', controller.kitchen),
              SizedBox(width: 10.w),
              _buildAmenityButton('Washer', controller.washer),
              SizedBox(width: 10.w),
              _buildAmenityButton('Dryer', controller.dryer),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              _buildAmenityButton(
                  'Air conditioning', controller.airConditioning),
              SizedBox(width: 10.w),
              _buildAmenityButton('TV', controller.tv),
              SizedBox(width: 10.w),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              AmenitiesFilter._buildAmenityButton(
                  'Beachfront', controller.beachfront),
              SizedBox(width: 10.w),
              AmenitiesFilter._buildAmenityButton(
                  'City View', controller.waterfront),
              SizedBox(width: 10.w),
              AmenitiesFilter._buildAmenityButton(
                  'Mountain View', controller.waterfront),
              SizedBox(width: 10.w),
              AmenitiesFilter._buildAmenityButton(
                  'Sunset', controller.waterfront),
              SizedBox(width: 10.w),
              AmenitiesFilter._buildAmenityButton(
                  'Sunrise', controller.waterfront),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildAmenityButton(String label, RxBool value) {
    return Obx(
      () => ElevatedButton(
        onPressed: () => value.value = !value.value,
        style: ElevatedButton.styleFrom(
          backgroundColor:
              value.value ? AppColors.hint.withOpacity(0.5) : AppColors.white,
          side: BorderSide(color: AppColors.black, width: 1.0),
        ),
        child: EraText(
          text: label,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

void openFilterDialog() {
  final FilterController controller = Get.put(FilterController());
  Get.dialog(
    Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: EdgeInsets.all(20.sp),
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
                      padding: EdgeInsets.only(
                        left: 50.sp,
                      ),
                      child: EraText(
                        text: 'Filters',
                        fontSize: 30.sp,
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                //  Price Range Filter
                EraText(
                  text: 'Price Range',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 10.h),
                PriceRangeFilter(controller: controller),
                EraText(
                  text: 'Rooms and Beds',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 10.h),

                RoomsAndBedsFilter(controller: controller),
                SizedBox(height: 10.h),

                EraText(
                  text: 'Property Type',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 10.h),

                PropertyTypeFilter(controller: controller),
                SizedBox(height: 10.h),
                EraText(
                  text: 'Amenities',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                SizedBox(height: 10.h),

                AmenitiesFilter(controller: controller),
                SizedBox(height: 10),
              ],
            )),
      ),
    ),
  );
}
