import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
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
                        controller: controller.locationController,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                sbw25(),
                Container(
                  height: 126.h,
                  width: Get.width / 2.5,
                  child: AddListings.dropDownAddlistings(
                      padding: EdgeInsets.zero,
                      selectedItem: controller.selectedPropertyT,
                      Types: controller.propertyT,
                      onChanged: (value) => controller.selectedPropertyT,
                      name: 'Property Type *',
                      hintText: 'Select Property Type'),
                ),
              ],
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
                            selectedItem: controller.selectedOfferT,
                            Types: controller.offerT,
                            onChanged: (value) => controller.selectedOfferT,
                            name: 'Offer Type *',
                            hintText: 'Select Offer Type'),
                      ),
                    ],
                  ),
                  sbw25(),
                  Container(
                    height: 126.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: controller.selectedView,
                        Types: controller.viewL,
                        onChanged: (value) => controller.selectedView,
                        name: 'View *',
                        hintText: 'Select View'),
                  ),
                  sbw25(),
                  Container(
                    height: 126.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: controller.selectedPropertySubCategory,
                        Types: controller.subCategory,
                        onChanged: (value) =>
                            controller.selectedPropertySubCategory,
                        name: 'Subcategory Type *',
                        hintText: 'Select Subcategory Type'),
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
                          height: 120.h,
                          width: Get.width / 5.1 - 4.w,
                          child: TextformfieldWidget(
                            controller: controller.carsController,
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

            sb30(),
            AddAgent.buildTextFieldFormDesc(
                'Description *', controller.descController),
            SizedBox(
              height: 10.h,
            ),

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
                return AddAgent.buildUploadPhoto();
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

            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Button(
                  onTap: () async {
                    BaseController().showLoading();
                    try {
                      await Listing(
                          name: controller.propertyNameController.text,
                          price: controller.propertyCostController.text
                              .replaceAll(',', '')
                              .toDouble(),
                          ppsqm:
                              controller.pricePerSqmController.text.toDouble(),
                          beds: controller.bedsController.text.toInt(),
                          baths: controller.bathsController.text.toInt(),
                          cars: controller.carsController.text.toInt(),
                          area: controller.areaController.text.toInt(),
                          status: controller.selectedOfferT.value.toString(),
                          // view: controller.selectedView.value.toString(),
                          location: controller.add.city,
                          type: controller.selectedPropertyT.value.toString(),
                          subCategory: controller
                              .selectedPropertySubCategory.value
                              .toString(),
                          description: controller.descController.text,
                          view: controller.selectedView.value.toString(),
                          address: controller.addressController.text,
                          latLng: [
                            controller.latLng!.latitude,
                            controller.latLng!.longitude
                          ]).addListing(controller.images, user!.id);

                      controller.showSuccessDialog(
                          hitApi: () {
                            //todo trigger referesh in dashboard
                            // Get.offAllNamed(RouteString.agentDashBoard);
                          },
                          title: "Add Listing Success",
                          description:
                              "Listing has been uploaded to the database.");
                    } catch (e, ex) {
                      print(e);
                      print(ex);
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
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
