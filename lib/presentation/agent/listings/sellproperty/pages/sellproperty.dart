
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/custom_appbar.dart';
import '../../../utility/controller/base_controller.dart';
import '../controllers/sellproperty_controller.dart';
//todo add text

class SellProperty extends GetView<SellPropertyController> {
  const SellProperty({super.key});

  @override
  Widget build(BuildContext context) {
    // final AddListingsController addListingsC = Get.put(AddListingsController());
    return Scaffold(
        appBar: CustomAppbar(),
        body: SafeArea(
          child: WillPopScope(
            onWillPop: () async {
              // selectedIndex.value = 0;
              // pageViewController = PageController(initialPage: 0);
              // currentRoute = '/home';
              // Get.offAll(BaseScaffold(),binding: HomeBinding());
              Get.back();
              return Future.value(false);
            },
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: EraTheme.paddingWidth, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    title(),
                    SizedBox(height: 20.h),
                    SharedWidgets.textFormfield(
                        name: 'Name',
                        textInputType: TextInputType.text,
                        hintText: 'Name',
                        controller: controller.name),
                    SizedBox(height: 20.h),
                    SharedWidgets.textFormfield(
                        name: 'Phone Number',
                        textInputType: TextInputType.number,
                        hintText: 'Phone Number',
                        controller: controller.phoneNum),
                    SizedBox(height: 20.h),
                    SharedWidgets.textFormfield(
                        name: 'Email Address',
                        textInputType: TextInputType.text,
                        hintText: 'Email Address',
                        controller: controller.emailAd),
                    SizedBox(height: 20.h),
                    SharedWidgets.dropDown(
                      controller.selectedProperty,
                      controller.propertyTypes,
                      (value) => controller.selectedProperty.value = value!,
                      'Property Type',
                      'Property Type',
                    ),
                    SizedBox(height: 20.h),
                    SharedWidgets.textFormfield(
                        name: 'Property Location',
                        textInputType: TextInputType.text,
                        hintText: 'Property Location',
                        controller: controller.propertyLocation),
                    SizedBox(height: 20.h),
                    SharedWidgets.textFormfield(
                        name: 'Price',
                        textInputType: TextInputType.number,
                        hintText: 'Price',
                        controller: controller.price),
                    sb30(),
                    // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     EraText(
                    //       text: 'UPLOAD PHOTOS',
                    //       fontSize: 22.sp,
                    //       fontWeight: FontWeight.w600,
                    //       color: AppColors.kRedColor,
                    //     ),
                    //     Obx(() => EraText(
                    //           text: '${controller.images.length}/15',
                    //           fontSize: 22.sp,
                    //           fontWeight: FontWeight.w600,
                    //           color: Colors.black,
                    //         )),
                    //   ],
                    // ),
                    // SizedBox(height: 10.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     ElevatedButton.icon(
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: AppColors.blue,
                    //         shadowColor: Colors.transparent,
                    //         side: BorderSide(
                    //             color: AppColors.hint.withOpacity(0.1), width: 1),
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //       ),
                    //       onPressed: () {
                    //         addListingsC.getImageGallery();
                    //       },
                    //       icon: Icon(
                    //         CupertinoIcons.photo_fill_on_rectangle_fill,
                    //         color: AppColors.white,
                    //       ),
                    //       label: EraText(
                    //         text: 'Select Photos',
                    //         color: AppColors.white,
                    //         fontSize: 20.sp,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(height: 10.h),
                    // Obx(() {
                    //   if (controller.images.isEmpty) {
                    //     return Image.asset(
                    //       AppEraAssets.uploadphoto,
                    //     );
                    //   } else {
                    //     return GridView.builder(
                    //         shrinkWrap: true,
                    //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                    //         physics: NeverScrollableScrollPhysics(),
                    //         gridDelegate:
                    //             SliverGridDelegateWithFixedCrossAxisCount(
                    //           crossAxisCount: 3,
                    //           mainAxisSpacing: 10.h,
                    //           crossAxisSpacing: 10.h,
                    //         ),
                    //         itemCount: controller.images.length,
                    //         itemBuilder: (context, index) {
                    //           return Container(
                    //             decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               image: DecorationImage(
                    //                 image: FileImage(controller.images[index]),
                    //                 fit: BoxFit.cover,
                    //               ),
                    //             ),
                    //           );
                    //         });
                    //   }
                    // }),
                    //
                    // SizedBox(height: 5.h),
                    //
                    // EraText(
                    //     text: 'Photo must be at least 300px X 300px',
                    //     fontSize: 15.sp,
                    //     color: AppColors.hint),
                    //sb20(),
                    EraText(
                      text: 'Description',
                      fontSize: 18.sp,
                      color: AppColors.black,
                    ),
                    TextformfieldWidget(
                      hintText: 'Enter Description',
                      maxLines: 15,
                      color: AppColors.hint,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    sb30(),
                    Button(
                        text: 'SEND',
                        onTap: () async {
                          try {
                            var sellDoc = FirebaseFirestore.instance
                                .collection('sell_properties')
                                .doc();
                            await sellDoc.set({
                              'id': sellDoc.id,
                              'name': controller.name.text,
                              'contact_number': controller.phoneNum.text,
                              'email': controller.emailAd.text,
                              'type': controller.selectedProperty.value,
                              'location': controller.propertyLocation.text,
                              'price': controller.price.text,
                              'desc': controller.desc.text,
                            });
                            BaseController().showSuccessDialog(
                                title: "Success",
                                description:
                                    "Your Property info has been submitted to admin. Wait for an admin to contact you!",
                                hitApi: () {
                                  controller.name.clear();
                                  controller.phoneNum.clear();
                                  controller.emailAd.clear();
                                  controller.selectedProperty.value = null;
                                  controller.propertyLocation.clear();
                                  controller.price.clear();
                                  controller.desc.clear();
                                  Get.back();
                                });
                          } catch (e) {
                            print(e);
                          }
                        },
                        bgColor: AppColors.kRedColor,
                        borderRadius: BorderRadius.circular(30),
                        fontSize: 18.sp,
                        width: Get.width),
                    sb40(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget title() {
    return EraText(
      text: 'Share your property details',
      color: AppColors.kRedColor,
      fontSize: EraTheme.header,
      fontWeight: FontWeight.bold,
    );
  }

  // Widget uploadPhoto() {
  //   return GestureDetector(
  //     onTap: () {
  //       //todo add upload photo
  //       //todo NIKO
  //     },
  //     child: Image.asset(
  //       'assets/icons/uploadphoto.png',
  //     ),
  //   );
  // }
}
//   return Scaffold(
//     body: WillPopScope(
//       onWillPop: () {
//         Get.back();
//         return Future.value(false);
//       },
//       child: SafeArea(
//         child: Obx(() => switch (controller.sellState.value) {
//               SellState.loading => _loading(),
//               SellState.loaded => _loaded(),
//               SellState.error => _error(),
//               SellState.empty => _empty()
//             }),
//       ),
//     ),
//   );
// }

// _loading() {
//   return Center(
//     child: CircularProgressIndicator(
//       color: AppColors.primary,
//     ),
//   );
// }

// _loaded() {
//   return Padding(
//     padding: EdgeInsets.symmetric(horizontal: 25.h),
//     child: Column(
//       children: [

//       ],
//     ),
//   );
// }

// _error() {
//   //todo add error screen
// }
// _empty() {
//   //todo add empty screen
// }
// }
