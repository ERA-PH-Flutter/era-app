import 'dart:ui';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';

import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/global.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  const PropertyTypeFilter({super.key});

  @override
  Widget build(BuildContext context) {
    AddListingsController addListingsController =
        Get.put(AddListingsController());

    return Column(
      children: [
        SharedWidgets.dropDown(
            addListingsController.selectedPropertySubCategory,
            subCategory,
            (value) => addListingsController.selectedPropertySubCategory.value =
                value!,
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
  final Rx<TextEditingController> minController;
  final Rx<TextEditingController> maxController;
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
      String value, Rx<TextEditingController> controller, RxString observable) {
    value = value.replaceAll(',', '');
    if (value.isNotEmpty) {
      try {
        final formattedValue = value.replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
        controller.value.text = formattedValue;
        controller.value.selection =
            TextSelection.collapsed(offset: formattedValue.length);
      } catch (e) {
        print("check error: $e");
      }
      observable.value = value;
    }
  }

  Widget _buildInputColumn({
    required String label,
    required String hintText,
    required Rx<TextEditingController> controller,
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
          child: Obx(
            () => TextformfieldWidget(
              onChanged: (value) => _formatInput(value, controller, observable),
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              keyboardType: TextInputType.number,
              controller: controller.value,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}

// Widget _buildFloorAreaFilter({
//   String? title,
//   String? hintText,
//   String? hintText2,
//   required Rx<TextEditingController> min,
//   required Rx<TextEditingController> max,
// }) {
//   return Column(
//     children: [
//       EraText(
//         text: title ?? 'Lot Area',
//         fontSize: 18.sp,
//         color: AppColors.black,
//       ),
//       Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               EraText(text: 'Min.', fontSize: 18.sp, color: AppColors.black),
//               SizedBox(
//                   width: Get.width / 2 - 25.w,
//                   child: Obx(
//                     () => TextformfieldWidget(
//                       onChanged: (value) {
//                         String noVariable = '';

//                         value = value.replaceAll(',', '');
//                         if (value.isNotEmpty) {
//                           try {
//                             final formattedValue = value.replaceAllMapped(
//                                 RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                                 (Match m) => '${m[1]},');
//                             min.value.text = formattedValue;
//                             min.value.selection = TextSelection.collapsed(
//                                 offset: formattedValue.length);
//                           } catch (e) {
//                             print("errorr: $e");
//                           }
//                         }
//                         noVariable = value;
//                       },
//                       hintText: hintText ?? 'sqm',
//                       contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
//                       keyboardType: TextInputType.number,
//                       controller: min.value,
//                       maxLines: 1,
//                     ),
//                   )),
//             ],
//           ),
//           SizedBox(width: 10.w),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               EraText(text: 'Max.', fontSize: 18.sp, color: AppColors.black),
//               SizedBox(
//                   width: Get.width / 2 - 25.w,
//                   child: Obx(
//                     () => TextformfieldWidget(
//                       onChanged: (value) {
//                         RxString noVariable = ''.obs;
//                         value = value.replaceAll(',', '');
//                         if (value.isNotEmpty) {
//                           try {
//                             final formattedValue = value.replaceAllMapped(
//                                 RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                                 (Match m) => '${m[1]},');
//                             max.value.text = formattedValue;
//                             max.value.selection = TextSelection.collapsed(
//                                 offset: formattedValue.length);
//                           } catch (e) {
//                             print("errorrr $e");
//                           }
//                         }
//                         noVariable.value = value;
//                       },
//                       hintText: hintText2 ?? 'sqm',
//                       contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
//                       keyboardType: TextInputType.number,
//                       controller: max.value,
//                       maxLines: 1,
//                     ),
//                   )),
//             ],
//           ),
//         ],
//       ),
//     ],
//   );
// }

Future openFilterDialog({
  required subcategory,
  required bedrooms,
  required bathrooms,
  required garage,
  required Rx<TextEditingController> floorAreaMin,
  required Rx<TextEditingController> floorAreaMax,
  required Rx<TextEditingController> ppsqmMin,
  required Rx<TextEditingController> ppsqmMax,
  required Rx<TextEditingController> lotAreaMin,
  required Rx<TextEditingController> lotAreaMax,
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
                  PropertyTypeFilter(),
                  //
                  SizedBox(height: 10.h),
                  //rooms and beds
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
                    maxObservable: lotAreaMax.value.text.obs,
                    minObservable: lotAreaMin.value.text.obs,
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
                    minObservable: floorAreaMin.value.text.obs,
                    maxObservable: floorAreaMax.value.text.obs,
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
                    minObservable: ppsqmMin.value.text.obs,
                    maxObservable: ppsqmMax.value.text.obs,
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
                                'ppsqm: ${ppsqmMin.value.text.obs}, ppsqm: ${ppsqmMax.value.text.obs}');

                            try {
                              if (lotAreaMin.value.text.obs.isNotEmpty &&
                                  lotAreaMax.value.text.obs.isNotEmpty) {
                                if (int.parse(lotAreaMin.value.text
                                        .replaceAll(',', '')) >
                                    int.parse(lotAreaMax.value.text
                                        .replaceAll(',', ''))) {
                                  Get.showSnackbar(GetSnackBar(
                                    message:
                                        'Min Area should be less than Max Area',
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }
                              }
                              if (floorAreaMin.value.text.obs.isNotEmpty &&
                                  floorAreaMax.value.text.obs.isNotEmpty) {
                                if (int.parse(floorAreaMin.value.text
                                        .replaceAll(',', '')) >
                                    int.parse(floorAreaMax.value.text
                                        .replaceAll(',', ''))) {
                                  Get.showSnackbar(GetSnackBar(
                                    message:
                                        'Min Floor Area should be less than Max Floor Area',
                                    duration: Duration(seconds: 2),
                                  ));
                                  return;
                                }
                              }
                              if (ppsqmMin.value.text.obs.isNotEmpty &&
                                  ppsqmMax.value.text.obs.isNotEmpty) {
                                if (int.parse(ppsqmMin.value.text
                                        .replaceAll(',', '')) >
                                    int.parse(ppsqmMax.value.text
                                        .replaceAll(',', ''))) {
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
