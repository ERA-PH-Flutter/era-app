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
import '../controllers/listing_admin_controller.dart';
//todo add text

class AddPropertyAdmin extends GetView<ListingsController> {
  const AddPropertyAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    //temporary
    //AgentAdminController controllers = Get.put(AgentAdminController());
    AddListingsController addListingsController = Get.put(AddListingsController());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
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
                text2: 'Area*',
                controller2: addListingsController.areaController,
                text3: 'Rooms *',
                controller3: addListingsController.bedsController,
                text4: 'Bathrooms *',
                controller4: addListingsController.bathsController),
            SizedBox(
              height: 10.h,
            ),
            //with dropdown
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
                        addListingsController.selectedPropertyT,
                        name: 'Property Type *',
                        hintText: 'Edit Property Type'),
                  ),
                  SizedBox(
                    height: 126.h,
                    width: Get.width / 2.46,
                    child: Column(
                      children: [
                        SizedBox(height: 37.h,),
                        Button(
                          height: 65.h,
                          width: Get.width / 2.2,
                          margin: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
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
                            onChanged: (value) => addListingsController.selectedOfferT,
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
                        selectedItem: addListingsController.selectedView,
                        Types: addListingsController.viewL,
                        onChanged: (value) => addListingsController.selectedView,
                        name: 'View *',
                        hintText: 'Select View'),
                  ),
                  sbw25(),
                  Container(
                    height: 126.h,
                    width: Get.width / 5.1 - 4.w,
                    child: AddListings.dropDownAddlistings(
                        padding: EdgeInsets.zero,
                        selectedItem: addListingsController.selectedPropertySubCategory,
                        Types: addListingsController.subCategory,
                        onChanged: (value) =>
                        addListingsController.selectedPropertySubCategory,
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

            sb30(),
            AddAgent.buildTextFieldFormDesc(
                'Description *', addListingsController.descController),
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
                    onPressed: ()async{
                      await addListingsController.pickImageFromWeb();
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
              if (addListingsController.images.isEmpty) {
                return AddAgent.buildUploadPhoto();
              } else {
                return Container(
                  height: 100.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: addListingsController.images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                          height: 400.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),

                        ),
                       child: Image.memory(addListingsController.images[index])

                      );
                    }
                  )
                );
                //return Image.memory(addListingsController.images.first);
                // return GridView.builder(
                //     shrinkWrap: true,
                //     padding: EdgeInsets.symmetric(horizontal: 20.w),
                //     physics: NeverScrollableScrollPhysics(),
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       mainAxisSpacing: 10.h,
                //       crossAxisSpacing: 10.h,
                //     ),
                //     itemCount: addListingsController.images.length,
                //     itemBuilder: (context, index) {
                //       return Container(
                //
                //       );
                //     });
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
                          name: addListingsController.propertyNameController.text,
                          price: addListingsController.propertyCostController.text
                              .replaceAll(',', '')
                              .toDouble(),
                          ppsqm:
                          addListingsController.pricePerSqmController.text.toDouble(),
                          beds: addListingsController.bedsController.text.toInt(),
                          baths: addListingsController.bathsController.text.toInt(),
                          cars: addListingsController.carsController.text.toInt(),
                          area: addListingsController.areaController.text.toInt(),
                          status: addListingsController.selectedOfferT.value.toString(),
                          // view: controller.selectedView.value.toString(),
                          location: addListingsController.add.city,
                          type: addListingsController.selectedPropertyT.value.toString(),
                          subCategory: addListingsController
                              .selectedPropertySubCategory.value
                              .toString(),
                          description: addListingsController.descController.text,
                          view: addListingsController.selectedView.value.toString(),
                          address: addListingsController.addressController.text,
                          latLng: [
                            addListingsController.latLng!.latitude,
                            addListingsController.latLng!.longitude
                          ]).addListing(addListingsController.images, user!.id);
                      addListingsController.showSuccessDialog(
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
