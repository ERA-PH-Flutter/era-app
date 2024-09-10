import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddProjectAdmin extends GetView<ListingsAdminController> {
  const AddProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ListingsAdminController controller = Get.put(ListingsAdminController());
    return SingleChildScrollView(
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
              text: 'ADD PROJECTS',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w600,
            ),
            _buildCollapsibleSection(
              title: 'BANNER PHOTO',
              children: [
                AddAgent.buildUploadPhoto(onTap: () {
                  controller.getImageGallery();
                }),
              ],
            ),
            _buildCollapsibleSection(
              title: 'PROJECT DETAILS',
              children: [
                sb10(),
                _buildTextField(
                  controller: controller.propertyNameController,
                  label: 'Property Name *',
                ),
                sb10(),
                _buildTextField(
                  controller: controller.developerController,
                  label: 'Developer *',
                ),
                sb10(),
                _buildTextField(
                  controller: controller.vrUploadController,
                  label: '3D Virtual Tour Link *',
                ),
                sb10(),
                _buildTextField(
                  controller: controller.locationControllers,
                  label: 'Location *',
                ),
                sb10(),
                SizedBox(
                  width: Get.width,
                  child: TextformfieldWidget(
                    controller: controller.descriptionController,
                    hintText: 'Description *',
                    maxLines: 8,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
                sb10(),
                //options
                _buildTextField(
                  controller: controller.vrUploadController2,
                  label: '3D Virtual Tour Link *',
                ),
                sb10(),
              ],
            ),
            sb20(),
            _buildCollapsibleSection(
              title: 'FEATURED DETAILS',
              children: [
                Row(
                  children: [
                    buildFeautredPhoto(onTap: () {
                      controller.getImageGallery();
                    }),
                    sbw10(),
                    SizedBox(
                      width: Get.width / 4.2,
                      child: TextformfieldWidget(
                        controller: controller.addFeaturedDesc1,
                        hintText: 'Description *',
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    buildFeautredPhoto(onTap: () {
                      controller.getImageGallery();
                    }),
                    sbw10(),
                    SizedBox(
                      width: Get.width / 4.2,
                      child: TextformfieldWidget(
                        controller: controller.addFeaturedDesc2,
                        hintText: 'Description *',
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    buildFeautredPhoto(onTap: () {
                      controller.getImageGallery();
                    }),
                    sbw10(),
                    SizedBox(
                      width: Get.width / 4.2,
                      child: TextformfieldWidget(
                        controller: controller.addFeaturedDesc3,
                        hintText: 'Description *',
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    buildFeautredPhoto(onTap: () {
                      controller.getImageGallery();
                    }),
                    sbw10(),
                    SizedBox(
                      width: Get.width / 4.2,
                      child: TextformfieldWidget(
                        controller: controller.addFeaturedDesc4,
                        hintText: 'Description *',
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            sb20(),
            _buildCollapsibleSection(
              title: 'AMENITIES PROJECT DETAILS',
              children: [
                Row(
                  children: [
                    buildFeautredPhoto(
                        title: 'Outdoor Amenities',
                        onTap: () {
                          controller.getImageGallery();
                        }),
                    sbw10(),
                    SizedBox(
                      width: Get.width / 4.2,
                      child: TextformfieldWidget(
                        controller: controller.outdoorAmenitiesController,
                        hintText: 'Description *',
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    buildFeautredPhoto(
                        title: 'Indoor Amenities',
                        onTap: () {
                          controller.getImageGallery();
                        }),
                    sbw10(),
                    SizedBox(
                      width: Get.width / 4.2,
                      child: TextformfieldWidget(
                        controller: controller.indoorAmenitiesController,
                        hintText: 'Description *',
                        maxLines: 8,
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            buildCarouselOption(
              controller: controller,
              title: 'CAROUSEL 1',
              controller1: controller.areaController,
              controller2: controller.roomController,
              controller3: controller.balconyController,
              controller4: controller.carouselDesc,
            ),
            buildCarouselOption(
              controller: controller,
              title: 'CAROUSEL 2',
              controller1: controller.areaController1,
              controller2: controller.roomController2,
              controller3: controller.balconyController3,
              controller4: controller.carouselDesc2,
            ),
            buildCarouselOption(
              controller: controller,
              title: 'CAROUSEL 3',
              controller1: controller.areaController4,
              controller2: controller.roomController,
              controller3: controller.balconyController3,
              controller4: controller.carouselDesc2,
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
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      {TextEditingController? controller,
      String? label,
      TextInputType? keyboardType,
      width}) {
    return SizedBox(
      width: width,
      child: TextFormField(
        keyboardType: keyboardType ?? TextInputType.text,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget buildFeautredPhoto({void Function()? onTap, String? title}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: title ?? 'ADD FEATURED PHOTOS',
              fontSize: 18.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            Container(
              width: 300.w,
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
      ),
    );
  }

  Widget buildCarouselOption({
    ListingsAdminController? controller,
    String? title,
    TextEditingController? controller1,
    TextEditingController? controller2,
    TextEditingController? controller3,
    TextEditingController? controller4,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title!,
          color: AppColors.black,
          fontSize: EraTheme.header - 10.sp,
          fontWeight: FontWeight.w600,
        ),
        EraText(
          text: 'Add photos (min 10)',
          color: AppColors.black,
          fontSize: EraTheme.header - 12.sp,
          fontWeight: FontWeight.w500,
        ),
        GestureDetector(
          onTap: () {
            //im not sure if this is the right function to call
            controller!.getImageGallery();
          },
          child: Container(
            width: Get.width,
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
        ),
        sb20(),
        Row(
          children: [
            _buildTextField(
              width: Get.width / 4,
              controller: controller1,
              label: 'Area *',
            ),
            sbw20(),
            _buildTextField(
              width: Get.width / 4,
              controller: controller2,
              label: 'Number of Rooms *',
            ),
            sbw20(),
            _buildTextField(
              width: Get.width / 4,
              controller: controller3,
              label: 'Balcony Size *',
            ),
          ],
        ),
        sb20(),
        TextformfieldWidget(
          controller: controller4,
          hintText: 'Description *',
          maxLines: 8,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
        ),
        sb20(),
      ],
    );
  }

  Widget _buildCollapsibleSection({
    required String title,
    required List<Widget> children,
  }) {
    return ExpansionTile(
      title: EraText(
        text: title,
        fontSize: EraTheme.header - 5.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      children: children,
    );
  }
  // Widget buildUploadSection({
  //   required String title,
  //   required TextEditingController controller1,
  //   required String text1,
  //   TextEditingController? controller2,
  //   String? text2,
  //   int maxLines1 = 1,
  //   int? maxLines2,
  // }) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           EraText(
  //             text: title,
  //             color: AppColors.black,
  //             fontSize: 18.sp,
  //             fontWeight: FontWeight.w500,
  //           ),
  //           SizedBox(height: 10.h),
  //           Container(
  //             height: 300.h,
  //             width: 500.w,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20),
  //               color: AppColors.hint,
  //             ),
  //           ),
  //         ],
  //       ),
  //       SizedBox(width: 20.w),
  //       Expanded(
  //         child: Column(
  //           children: [
  //             buildTextFormField2(
  //               text: text1,
  //               controller: controller1,
  //               maxLines: maxLines1,
  //             ),
  //             if (text2 != null && controller2 != null) ...[
  //               SizedBox(height: 20.h),
  //               buildTextFormField2(
  //                 text: text2,
  //                 controller: controller2,
  //                 maxLines: maxLines2 ?? 1,
  //               ),
  //             ],
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // static Widget buildTextFormField2({
  //   required String text,
  //   required TextEditingController controller,
  //   int maxLines = 1,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       if (text.isNotEmpty)
  //         EraText(
  //           text: text,
  //           fontSize: 18.sp,
  //           color: AppColors.black,
  //           fontWeight: FontWeight.w500,
  //         ),
  //       SizedBox(height: 10.h),
  //       TextFormField(
  //         controller: controller,
  //         maxLines: maxLines,
  //         decoration: InputDecoration(
  //           filled: true,
  //           fillColor: AppColors.white,
  //           enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //             borderSide: BorderSide(
  //               color: AppColors.black,
  //               width: 1.5,
  //             ),
  //           ),
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
