import 'dart:ui';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';

import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RoomsAndBedsFilter extends StatelessWidget {
  final RxInt bedrooms;
  final RxInt bathrooms;
  final RxInt garage;

  const RoomsAndBedsFilter(
      {super.key,
      required this.bedrooms,
      required this.bathrooms,
      required this.garage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCounterRow('Bedrooms', bedrooms),
        SizedBox(height: 15.h),
        _buildCounterRow('Bathrooms', bathrooms),
        SizedBox(height: 15.h),
        _buildCounterRow('Garage', garage),
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

class PropertyTypeFilter extends StatelessWidget {
  var selectedPropertySubCategory = RxnString();

  PropertyTypeFilter({super.key, required this.selectedPropertySubCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedWidgets.dropDown(
            selectedPropertySubCategory,
            subCategory,
            (value) => selectedPropertySubCategory.value = value!,
            'Subcategory',
            'Subcategory'),
      ],
    );
  }
}

class FilterInputWidget extends StatelessWidget {
  final String title;
  final String minLabel;
  final String maxLabel;
  final String minHintText;
  final String maxHintText;
  final TextEditingController minController;
  final TextEditingController maxController;
  final RxString minObservable;
  final RxString maxObservable;
  const FilterInputWidget({
    super.key,
    required this.title,
    required this.minLabel,
    required this.maxLabel,
    required this.minHintText,
    required this.maxHintText,
    required this.minController,
    required this.maxController,
    required this.minObservable,
    required this.maxObservable,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInputColumn(
              label: minLabel,
              hintText: minHintText,
              controller: minController,
              observable: minObservable,
            ),
            SizedBox(width: 10.w),
            _buildInputColumn(
                label: maxLabel,
                hintText: maxHintText,
                controller: maxController,
                observable: maxObservable),
          ],
        ),
      ],
    );
  }

  void _formatInput(
      String value, TextEditingController controller, RxString observable) {
    value = value.replaceAll(',', '');
    if (value.isNotEmpty) {
      try {
        final formattedValue = value.replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
        controller.value = controller.value.copyWith(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      } catch (e) {
        print("check error: $e");
      }
      observable.value = value;
    }
  }

  Widget _buildInputColumn({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required RxString observable,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        EraText(
          text: label,
          fontSize: 18.sp,
          color: AppColors.black,
        ),
        SizedBox(
          width: Get.width / 2 - 25.w,
          child: TextformfieldWidget(
            inputFormatterss: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) => _formatInput(value, controller, observable),
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            keyboardType: TextInputType.number,
            controller: controller,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}

Future openFilterDialog({
  required RxnString subcategory,
  required bedrooms,
  required bathrooms,
  required garage,
  required TextEditingController floorAreaMin,
  required TextEditingController floorAreaMax,
  required TextEditingController ppsqmMin,
  required TextEditingController ppsqmMax,
  required TextEditingController lotAreaMin,
  required TextEditingController lotAreaMax,
  required RxString floorAreaMinObservable,
  required RxString floorAreaMaxObservable,
  required RxString ppsqmMinObservable,
  required RxString ppsqmMaxObservable,
  required RxString lotAreaMinObservable,
  required RxString lotAreaMaxObservable,
}) async {
  await Get.dialog(
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
                  SizedBox(height: 10.h),
                  EraText(
                    text: 'Property Type',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  SizedBox(height: 10.h),
                  PropertyTypeFilter(
                    selectedPropertySubCategory: subcategory,
                  ),
                  SizedBox(height: 10.h),
                  RoomsAndBedsFilter(
                    bedrooms: bedrooms,
                    bathrooms: bathrooms,
                    garage: garage,
                  ),
                  SizedBox(height: 20.h),
                  FilterInputWidget(
                    title: 'Lot Area',
                    minLabel: 'Min.',
                    maxLabel: 'Max.',
                    minHintText: 'sqm',
                    maxHintText: 'sqm',
                    minController: lotAreaMin,
                    maxController: lotAreaMax,
                    maxObservable: lotAreaMaxObservable,
                    minObservable: lotAreaMinObservable,
                  ),
                  SizedBox(height: 20.h),
                  FilterInputWidget(
                    title: 'Floor Area',
                    minLabel: 'Min.',
                    maxLabel: 'Max.',
                    minHintText: 'sqm',
                    maxHintText: 'sqm',
                    minController: floorAreaMin,
                    maxController: floorAreaMax,
                    minObservable: floorAreaMinObservable,
                    maxObservable: floorAreaMaxObservable,
                  ),
                  SizedBox(height: 20.h),
                  FilterInputWidget(
                    title: 'Price per sqm',
                    minLabel: 'Min.',
                    maxLabel: 'Max.',
                    minHintText: 'Php',
                    maxHintText: 'Php',
                    minController: ppsqmMin,
                    maxController: ppsqmMax,
                    minObservable: ppsqmMinObservable,
                    maxObservable: ppsqmMaxObservable,
                  ),
                  sb20(),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Button(
                          width: Get.width,
                          onTap: () {
                            print(
                                'ppsqm: ${ppsqmMinObservable.value}, ppsqm: ${ppsqmMaxObservable.value}');

                            try {
                              if (lotAreaMin.text.isNotEmpty &&
                                  lotAreaMax.text.isNotEmpty) {
                                if (int.parse(
                                        lotAreaMin.text.replaceAll(',', '')) >
                                    int.parse(
                                        lotAreaMax.text.replaceAll(',', ''))) {
                                  Get.showSnackbar(GetSnackBar(
                                    message:
                                        'Min Area should be less than Max Area',
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }
                              }
                              if (floorAreaMin.text.isNotEmpty &&
                                  floorAreaMax.text.isNotEmpty) {
                                if (int.parse(
                                        floorAreaMin.text.replaceAll(',', '')) >
                                    int.parse(floorAreaMax.text
                                        .replaceAll(',', ''))) {
                                  Get.showSnackbar(GetSnackBar(
                                    message:
                                        'Min Floor Area should be less than Max Floor Area',
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }
                              }
                              if (ppsqmMin.text.isNotEmpty &&
                                  ppsqmMax.text.isNotEmpty) {
                                if (int.parse(
                                        ppsqmMin.text.replaceAll(',', '')) >
                                    int.parse(
                                        ppsqmMax.text.replaceAll(',', ''))) {
                                  Get.showSnackbar(GetSnackBar(
                                    message:
                                        'Min Price per sqm should be less than Max Price per sqm',
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }
                              }

                              // Apply Filters Logic
                              Get.back();
                              Get.showSnackbar(GetSnackBar(
                                padding: EdgeInsets.symmetric(
                                    horizontal: EraTheme.paddingWidth,
                                    vertical: 10.h),
                                backgroundColor: AppColors.kRedColor,
                                title: 'Success',
                                message: 'Filter Applied',
                                duration: Duration(seconds: 2),
                              ));
                            } catch (e) {
                              Get.showSnackbar(GetSnackBar(
                                message:
                                    'An error occurred. Please check your inputs.',
                                duration: Duration(seconds: 2),
                              ));
                              print('Error: $e');
                            }
                          },
                          text: 'Apply Filters',
                          bgColor: AppColors.blue,
                          fontSize: 20.sp,
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ],
              )),
        ),
      ),
    ),
  );
}
