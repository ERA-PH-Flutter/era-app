import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class AddAgent extends GetView<AgentAdminController> {
  const AddAgent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 75.w),
            child: EraText(
              text: 'ADD AGENT',
              fontSize: 20.sp,
              color: AppColors.black,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.fNameA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'First Name *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.lNameA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'Last Name *',
                      60.h),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.emailAdressA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'Email Address *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.dateBirthA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 5.1 - 3.w,
                      'Date of Birth *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.sexA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 5.1 - 3.w,
                      'Gender *',
                      60.h),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.locationA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'Office Location *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.licenseNA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 2.5,
                      'License Number *',
                      60.h),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.phoneNA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      // Get.width / 3.8,
                      Get.width / 5 - 10.w,
                      'Phone Number *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.positionA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 5 - 10.w,
                      'Position *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.passwordA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 5 - 10.w,
                      'Password *',
                      60.h),
                  SizedBox(
                    width: 20.w,
                  ),
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.confirmPA,
                        fontSize: 12.sp,
                        maxLines: 1,
                      ),
                      Get.width / 5 - 10.w,
                      'Confirm Password *',
                      60.h),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTextFormField(
                      TextformfieldWidget(
                        controller: controller.descriptionA,
                        fontSize: 12.sp,
                        maxLines: 50,
                      ),
                      Get.width / 1.2 - 45.w,
                      'Description *',
                      200.h),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Upload Photo *',
                    fontSize: 18.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    width: Get.width / 1.2 - 45.w,
                    height: 250.h,
                    decoration: BoxDecoration(
                      color: AppColors.hint.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.hint.withOpacity(0.9),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(AppEraAssets.uploadAdmin),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 80.w),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Button(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 150.w,
                    height: 35.h,
                    text: 'SUBMIT',
                    bgColor: AppColors.blue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  Button(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    width: 150.w,
                    height: 35.h,
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
          )
        ],
      ),
    );
  }




  Widget _buildTextFormField(
      Widget child, double width, String text, double height) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: text,
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              height: height,
              width: width,
              child: child,
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ],
    );
  }
}
// class AddListings extends GetView<AddListingsController> {
//   const AddListings({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BaseScaffold(
//         body: SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: SafeArea(
//           child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           textBuild('CREATE LISTING', 25.sp, FontWeight.w600, AppColors.blue),
//           SizedBox(height: 15.h),
//           textBuild('PROPERTY INFORMATION', 25.sp, FontWeight.w600,
//               AppColors.kRedColor),
//           SizedBox(height: 20.h),
//           buildWidget(
//             'Property Name',
//             TextformfieldWidget(hintText: 'Property Name', maxLines: 1),
//           ),
//           buildWidget(
//             'Property Cost',
//             TextformfieldWidget(hintText: 'Php 100,000,000', maxLines: 1),
//           ),
//           textBuild(
//               'UPLOAD PHOTOS', 22.sp, FontWeight.w600, AppColors.kRedColor),
//           SizedBox(height: 10.h),
//           // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ElevatedButton.icon(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.blue,
//                     shadowColor: Colors.transparent,
//                     side: BorderSide(
//                         color: AppColors.hint.withOpacity(0.1), width: 1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   onPressed: () {
//                     controller.getImageGallery();
//                   },
//                   icon: Icon(
//                     CupertinoIcons.photo_fill_on_rectangle_fill,
//                     color: AppColors.white,
//                   ),
//                   label: EraText(
//                     text: 'Select Photos',
//                     color: AppColors.white,
//                     fontSize: 20.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 // ElevatedButton.icon(
//                 //     style: ElevatedButton.styleFrom(
//                 //       backgroundColor: AppColors.blue,
//                 //       shadowColor: Colors.transparent,
//                 //       side: BorderSide(
//                 //           color: AppColors.hint.withOpacity(0.1), width: 1),
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(10),
//                 //       ),
//                 //     ),
//                 //     onPressed: () {
//                 //       if (controller.images.isNotEmpty) {
//                 //         controller.removeMode();
//                 //       } else {
//                 //         BaseController().showSuccessDialog(
//                 //             title: "Error!",
//                 //             description: "You have selected 0 image!");
//                 //       }
//                 //     },
//                 //     icon: Icon(
//                 //       CupertinoIcons.photo_fill_on_rectangle_fill,
//                 //       color: AppColors.white,
//                 //     ),
//                 //     label: Obx(
//                 //       () => EraText(
//                 //         text: controller.removeImage.value &&
//                 //                 controller.images.isNotEmpty
//                 //             ? 'Cancel'
//                 //             : 'Remove',
//                 //         color: AppColors.white,
//                 //         fontSize: 20.sp,
//                 //         fontWeight: FontWeight.w500,
//                 //       ),
//                 //     )),
//               ],
//             ),
//           ),

//           SizedBox(height: 10.h),
//           Obx(() {
//             if (controller.images.isEmpty) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 child: Image.asset(
//                   AppEraAssets.uploadphoto,
//                 ),
//               );
//             } else {
//               return GridView.builder(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.symmetric(horizontal: 20.w),
//                   physics: NeverScrollableScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     mainAxisSpacing: 10.h,
//                     crossAxisSpacing: 10.h,
//                   ),
//                   itemCount: controller.images.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         image: DecorationImage(
//                           image: FileImage(controller.images[index]),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   });
//             }
//           }),

//           SizedBox(height: 5.h),

//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: EraText(
//                 text: 'Photo must be at least 300px X 300px',
//                 fontSize: 15.sp,
//                 color: AppColors.hint),
//           ),
//           paddintText2(),
//         ],
//       )),
//     ));
//   }

//   Widget paddintText2() {
//     return Column(
//       children: [
//         SizedBox(height: 20.h),
//         buildWidget(
//           'Price per sqm',
//           TextformfieldWidget(
//               keyboardType: TextInputType.number,
//               controller: controller.pricePerSqmController,
//               hintText: 'Php 100,000',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Floor Area',
//           TextformfieldWidget(
//               keyboardType: TextInputType.number,
//               controller: controller.floorAreaController,
//               hintText: '151 sqm',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Beds',
//           TextformfieldWidget(
//               controller: controller.bedsController,
//               hintText: '2',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Baths',
//           TextformfieldWidget(
//               controller: controller.bathsController,
//               hintText: '3',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Area',
//           TextformfieldWidget(
//               controller: controller.areaController,
//               hintText: '150 sqm',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Offer Type',
//           TextformfieldWidget(
//               controller: controller.offerTypeController,
//               hintText: 'Sale',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'View',
//           TextformfieldWidget(
//               controller: controller.viewController,
//               hintText: 'Sunrise',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Location',
//           TextformfieldWidget(
//               controller: controller.locationController,
//               hintText: 'Bonifacio Global City, Taguig',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Property Type',
//           TextformfieldWidget(
//               controller: controller.propertyTypeController,
//               hintText: 'Condominium',
//               maxLines: 1),
//         ),
//         buildWidget(
//           'Subcatergory',
//           TextformfieldWidget(
//               controller: controller.propertySubCategoryController,
//               hintText: 'Penthouse',
//               maxLines: 1),
//         ),
//         SizedBox(height: 20.h),
//         Button.button2(390.w, 50.h, () async {
//           BaseController.showLoading();
//           await Listing(
//               name: controller.propertyNameController.text,
//               price: controller.propertyCostController.text.toDouble(),
//               photos: controller.images,
//               ppsqm: controller.pricePerSqmController.text.toDouble(),
//               floorArea: controller.floorAreaController.text.toDouble(),
//               beds: controller.bedsController.text.toInt(),
//               baths: controller.bathsController.text.toInt(),
//               area: controller.areaController.text.toInt(),
//               status: controller.offerTypeController.text,
//               view: controller.viewController.text,
//               location: controller.locationController.text,
//               type: controller.propertyTypeController.text,
//               subCategory: controller.propertySubCategoryController.text
//           ).addListing();
//           BaseController.hideLoading();
//         }, 'CREATE LISTING'),
//         SizedBox(height: 20.h),
//       ],
//     );
//   }

//   static Widget buildWidget(String text, TextformfieldWidget textFormField) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           EraText(
//               text: text,
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w500,
//               color: AppColors.black),
//           SizedBox(height: 5.h),
//           textFormField,
//           SizedBox(height: 20.h),
//         ],
//       ),
//     );
//   }

//   static Widget textBuild(
//       String text, double fontSize, FontWeight fontWeight, Color color) {
//     return Padding(
//         padding: EdgeInsets.symmetric(horizontal: 20.w),
//         child: Column(
//           children: [
//             EraText(
//               text: text,
//               fontSize: fontSize,
//               fontWeight: fontWeight,
//               color: color,
//             ),
//           ],
//         ));
//   }
// }
