import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditPropertyAdmin extends GetView<ListingsAdminController> {
  const EditPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    AddListingsController addListingsController =
        Get.put(AddListingsController());

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
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
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                      text: '  Location *',
                      fontSize: 18.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.w),
                      height: 60.h,
                      width: Get.width / 2.5 + 9.w,
                      child: TextformfieldWidget(
                        controller: addListingsController.locationController,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 25.w,
                ),
                Container(
                  padding: EdgeInsets.only(right: 5.w),
                  height: 95.h,
                  width: Get.width / 2.5.w,
                  child: SharedWidgets.dropDown(
                      addListingsController.selectedPropertyT,
                      addListingsController.propertyT,
                      (value) => addListingsController.selectedPropertyT,
                      'Property Type',
                      'Select Property Type'),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  SizedBox(
                    height: 95.h,
                    width: Get.width / 5.1 - 3.w,
                    child: SharedWidgets.dropDown(
                        addListingsController.selectedOfferT,
                        addListingsController.offerT,
                        (value) => addListingsController.selectedOfferT,
                        'Offer Type *',
                        'Selected Offer Type'),
                  ),
                  SizedBox(width: 20.w),
                  SizedBox(
                    height: 95.h,
                    width: Get.width / 5.1 - 3.w,
                    child: SharedWidgets.dropDown(
                        addListingsController.selectedView,
                        addListingsController.viewL,
                        (value) => addListingsController.selectedOfferT,
                        'View *',
                        'Selected View'),
                  ),
                  sb10(),
                  sbw15(),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 95.h,
                          width: Get.width / 5.1 - 3.w,
                          child: SharedWidgets.dropDown(
                              addListingsController.selectedPropertySubCategory,
                              addListingsController.subCategory,
                              (value) => addListingsController.selectedOfferT,
                              'Subcategory *',
                              'Selected Subcategory'),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EraText(
                              text: 'Parking *',
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                            ),
                            sb10(),
                            Container(
                              margin: EdgeInsets.only(bottom: 15.w),
                              height: 50.h,
                              width: Get.width / 5.1 - 3.w,
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
            AddAgent.buildUploadPhoto(),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
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
}
