import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listing_admin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//todo add new controller
//done
class EditPropertyAdmin extends GetView<ListingsController> {
  const EditPropertyAdmin({super.key});
  @override
  Widget build(BuildContext context) {
    AddListingsController addListingsController =
        Get.put(AddListingsController());
    //  Get.find<LandingPageController>().arguments;
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
            Wrap(
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
                      padding: EdgeInsets.only(left: 10.w, top: 5.h),
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
                sbw25(),
                Container(
                  height: 125.h,
                  width: Get.width / 2.5,
                  child: AddListings.dropDownAddlistings(
                      padding: EdgeInsets.zero,
                      selectedItem: addListingsController.selectedPropertyT,
                      Types: addListingsController.propertyT,
                      onChanged: (value) =>
                          addListingsController.selectedPropertyT,
                      name: 'Property Type *',
                      hintText: 'Edit Property Type'),
                ),
              ],
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
                        height: 125.h,
                        width: Get.width / 5.1 - 4.w,
                        child: AddListings.dropDownAddlistings(
                            padding: EdgeInsets.zero,
                            selectedItem: addListingsController.selectedOfferT,
                            Types: addListingsController.offerT,
                            onChanged: (value) =>
                                addListingsController.selectedOfferT,
                            name: 'Offer Type *',
                            hintText: 'Edit Offer Type'),
                      ),
                    ],
                  ),
                  sbw25(),
                  Container(
                    height: 125.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: addListingsController.selectedView,
                        Types: addListingsController.viewL,
                        onChanged: (value) =>
                            addListingsController.selectedView,
                        name: 'View *',
                        hintText: 'Edit View'),
                  ),
                  sbw25(),
                  Container(
                    height: 125.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem:
                            addListingsController.selectedPropertySubCategory,
                        Types: addListingsController.subCategory,
                        onChanged: (value) =>
                            addListingsController.selectedPropertySubCategory,
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
