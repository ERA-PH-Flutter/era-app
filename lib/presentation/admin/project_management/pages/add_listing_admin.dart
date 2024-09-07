import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
//todo add text

class AddPropertyAdmin extends GetView<ListingsAdminController> {
  const AddPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    //temporary
    //AgentAdminController controllers = Get.put(AgentAdminController());
    AddListingsController controller = Get.put(AddListingsController());
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
              controller.propertyNameController,
              'Property Cost *',
              controller.propertyCostController,
            ),
            SizedBox(
              height: 10.h,
            ),
            AddAgent.buildTextFormField4(
                text: 'Price per sqm *',
                controller: controller.pricePerSqmController,
                text2: 'Area*',
                controller2: controller.areaController,
                text3: 'Rooms *',
                controller3: controller.bedsController,
                text4: 'Bathrooms *',
                controller4: controller.bathsController),
            SizedBox(
              height: 10.h,
            ),
            //with dropdown
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
                        controller: controller.locationController,
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
                      controller.selectedPropertyT,
                      controller.propertyT,
                      (value) => controller.selectedPropertyT,
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
                        controller.selectedOfferT,
                        controller.offerT,
                        (value) => controller.selectedOfferT,
                        'Offer Type *',
                        'Selected Offer Type'),
                  ),
                  SizedBox(width: 20.w),
                  SizedBox(
                    height: 95.h,
                    width: Get.width / 5.1 - 3.w,
                    child: SharedWidgets.dropDown(
                        controller.selectedView,
                        controller.viewL,
                        (value) => controller.selectedOfferT,
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
                              controller.selectedPropertySubCategory,
                              controller.subCategory,
                              (value) => controller.selectedOfferT,
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
                                controller: controller.carsController,
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
            sb30(),
            AddAgent.buildTextFieldFormDesc(
                'Description *', controller.descController),
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
