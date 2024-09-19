import 'dart:typed_data';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';

import 'package:flutter/cupertino.dart';
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
            DropdownButtonHideUnderline(
              child: Obx(
                () => DropdownButton<String>(
                  focusColor: AppColors.hint.withOpacity(0.7),
                  dropdownColor: AppColors.white,
                  value: controller.selectedOption.isEmpty
                      ? null
                      : controller.selectedOption.value,
                  hint: EraText(
                    text: 'Select Option',
                    color: AppColors.black,
                  ),
                  items: [
                    DropdownMenuItem(
                        value: 'bannerImages',
                        child: EraText(
                          text: 'Banner Images',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'developerName',
                        child: EraText(
                          text: 'Developer Name',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'ProjectLogo',
                        child: EraText(
                          text: 'Project Logo',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: '3DVirtual',
                        child: EraText(
                          text: '3D Virtual Tour',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'Blurb',
                        child: EraText(
                          text: 'Blurb',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'location',
                        child: EraText(
                          text: 'Location',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'outdoorAmenities',
                        child: EraText(
                          text: 'Outdoor Amenities',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'indoorAmenities',
                        child: EraText(
                          text: 'Indor Amenities',
                          color: AppColors.black,
                        )),
                    DropdownMenuItem(
                        value: 'Carousel',
                        child: EraText(
                          text: 'Carousel Slider',
                          color: AppColors.black,
                        )),
                  ],
                  onChanged: (value) {
                    controller.selectedOption.value = value!;
                  },
                ),
              ),
            ),
            Obx(() {
              if (controller.selectedOption.value == 'bannerImages') {
                return _buildCollapsibleSection(
                  title: 'BANNER PHOTO',
                  children: [
                    UploadBannersWidget(
                      text: 'Upload Banners',
                      maxImages: 1,
                      onImageSelected: (Uint8List bannerImage) {
                        controller.addBannerPhoto(bannerImage);
                      },
                    ),
                    sb20(),
                  ],
                );
              } else if (controller.selectedOption.value == 'developerName') {
                return _buildCollapsibleSection(
                  title: 'DEVELOPER NAME',
                  children: [
                    _buildTextField(
                      controller: controller.developerController,
                      label: 'Developer Name*',
                      onChanged: (value) {
                        controller.updateDeveloperName(
                            controller.developerController.text);
                      },
                    ),
                    sb20(),
                  ],
                );
              } else if (controller.selectedOption.value == 'ProjectLogo') {
                return _buildCollapsibleSection(
                  title: 'PROJECT LOGO',
                  children: [
                    UploadBannersWidget(
                      text: 'Upload Project Logo',
                      maxImages: 1,
                      onImageSelected: (Uint8List image) {
                        controller.addProjectPhoto(image);
                      },
                    ),
                    sb20(),
                  ],
                );
              } else if (controller.selectedOption.value == '3DVirtual') {
                return _buildCollapsibleSection(
                  title: 'ADD VIRTUAL TOUR',
                  children: [
                    _buildTextField(
                        controller: controller.virtualTitleController,
                        label: 'Virtual Title*',
                        onChanged: (value) {
                          controller.updateVirtualTitle(value);
                        }),
                    sb20(),
                    TextformfieldWidget(
                      controller: controller.virtualParagraphController,
                      hintText: 'Virtual Paragraph *',
                      maxLines: 10,
                      textInputAction: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        controller.updateVirtualParagaph(value);
                      },
                    ),
                    sb20(),
                    _buildTextField(
                      controller: controller.virtualLinkController,
                      label: 'Virtual Link*',
                    ),
                    sb20(),
                  ],
                );
              } else if (controller.selectedOption.value == 'Blurb') {
                return _buildCollapsibleSection(
                  title: 'ADD BLURB',
                  children: [
                    Obx(() => Column(
                          children: List.generate(
                              controller.addBlurbTitle.length,
                              (index) => _buildBlurb(
                                    index,
                                    controller,
                                  )),
                        )),
                    IconButton(
                      onPressed: () {
                        controller.addBlurb();
                      },
                      icon: Icon(CupertinoIcons.add),
                    ),
                  ],
                );
              } else if (controller.selectedOption.value == 'location') {
                return _buildCollapsibleSection(
                  title: 'ADD LOCATION',
                  children: [],
                );
              } else if (controller.selectedOption.value ==
                  'outdoorAmenities') {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        EraText(
                            text: 'Add Outdoor Amenities',
                            color: AppColors.black),
                        Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                                hint: EraText(
                                    text: 'Select Option',
                                    color: AppColors.black),
                                value: controller.selectedOutDoor.value.isEmpty
                                    ? null
                                    : controller.selectedOutDoor.value,
                                items: [
                                  DropdownMenuItem(
                                      value: 'blurb',
                                      child: EraText(
                                          text: 'add blrub',
                                          color: AppColors.black)),
                                  DropdownMenuItem(
                                      value: 'gallery',
                                      child: EraText(
                                          text: 'add gallery photos',
                                          color: AppColors.black)),
                                ],
                                onChanged: (value) {
                                  controller.selectedOutDoor.value = value!;
                                }),
                          ),
                        ),
                      ],
                    ),
                    Obx(() {
                      if (controller.selectedOutDoor.value == 'blurb') {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EraText(
                                    text: 'BLURB OUTDOOR AMENITIES',
                                    color: AppColors.black),
                                IconButton(
                                  onPressed: () {
                                    controller.addBlurb();
                                  },
                                  icon: Icon(CupertinoIcons.add),
                                ),
                              ],
                            ),
                            Column(
                              children: List.generate(
                                  controller.addBlurbTitle.length,
                                  (index) => _buildBlurb(
                                        index,
                                        controller,
                                      )),
                            ),
                          ],
                        );
                      } else if (controller.selectedOutDoor.value ==
                          'gallery') {
                        return UploadBannersWidget(
                          text: 'Upload Outdoor Amenities Gallery Only',
                          maxImages: 10,
                          onImageSelected: (Uint8List outdoorAmenities) {
                            controller.addoutdoorAmenities(outdoorAmenities);
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                );
              } else if (controller.selectedOption.value == 'indoorAmenities') {
                return Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          EraText(
                              text: 'Add Indoor Amenities',
                              color: AppColors.black),
                          Obx(
                            () => DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    hint: EraText(
                                        text: 'Select Option',
                                        color: AppColors.black),
                                    value: controller.selectedIndoor.isEmpty
                                        ? null
                                        : controller.selectedIndoor.value,
                                    items: [
                                      DropdownMenuItem(
                                          value: 'blurb',
                                          child: EraText(
                                            text: 'add blurb',
                                            color: AppColors.black,
                                          )),
                                      DropdownMenuItem(
                                          value: 'gallery',
                                          child: EraText(
                                            text: 'add gallery',
                                            color: AppColors.black,
                                          )),
                                    ],
                                    onChanged: (value) {
                                      controller.selectedIndoor.value = value!;
                                    })),
                          ),
                        ]),
                    Obx(() {
                      if (controller.selectedIndoor.value == 'blurb') {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EraText(
                                    text: 'BLURB INDOOR AMENITIES',
                                    color: AppColors.black),
                                IconButton(
                                  onPressed: () {
                                    controller.addBlurb();
                                  },
                                  icon: Icon(CupertinoIcons.add),
                                ),
                              ],
                            ),
                            Column(
                              children: List.generate(
                                  controller.addBlurbTitle.length,
                                  (index) => _buildBlurb(
                                        index,
                                        controller,
                                      )),
                            ),
                          ],
                        );
                      } else if (controller.selectedIndoor.value == 'gallery') {
                        return UploadBannersWidget(
                          text: 'Upload Indoor Amenities Gallery Only',
                          maxImages: 10,
                          onImageSelected: (Uint8List outdoorAmenities) {
                            controller.addoutdoorAmenities(outdoorAmenities);
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ],
                );
              } else {
                return Container();
              }
            }),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildImagePreview(controller.bannerPhotos),
                _buildText(text: controller.developerName),
                _buildImagePreview(controller.projectLogo),
                _buildText(text: controller.virtualTitle),
                _buildText(text: controller.virtualParagraph),
                _buildText(text: controller.virtualLink),
                Obx(
                  () => Column(
                    children: List.generate(
                      controller.addBlurbTitle.length,
                      (index) => Column(
                        children: [
                          _buildBlurbTitle(
                              controller: controller, index: index),
                          _buildBulbImage(controller: controller, index: index),
                          _buildBlurbpParagraph(
                              controller: controller, index: index),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//preview
Widget _buildBulbImage({ListingsAdminController? controller, int? index}) {
  return Obx(() => controller!.addBlurImage[index!] != null
      ? Image.memory(
          controller.addBlurImage[index]!,
          width: Get.width / 3,
          height: Get.height / 2.5,
          fit: BoxFit.cover,
        )
      : Container());
}
//preview

Widget _buildBlurbTitle(
    {required ListingsAdminController controller, required int index}) {
  return Obx(() => EraText(
        text: controller.addBlurbTitle[index],
        color: AppColors.black,
        fontSize: EraTheme.paragraph,
        maxLines: 1,
      ));
}

Widget _buildBlurbpParagraph(
    {required ListingsAdminController controller, required int index}) {
  return Obx(() => EraText(
        text: controller.addBlurbParagraph[index],
        color: AppColors.black,
        fontSize: EraTheme.paragraph,
        maxLines: 10,
      ));
}

Widget _buildBlurb(int index, ListingsAdminController controller) {
  return Column(
    children: [
      _buildTextField(
          controller: controller.blurbTitleController[index],
          label: 'Blurb Title*',
          onChanged: (value) {
            controller.updateBlurbTitle(index, value);
          }),
      _buildBlurbTitle(controller: controller, index: index),
      sb20(),
      UploadBannersWidget(
          text: 'Upload Blurb Image',
          maxImages: 1,
          onImageSelected: (Uint8List image) {
            controller.updateBlurbImage(index, image);
          }),
      sb20(),
      TextformfieldWidget(
        controller: controller.blurbParagraphController[index],
        hintText: 'Blurb Paragraph *',
        maxLines: 10,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          controller.updateBlurbParagraph(index, value);
        },
      ),
      IconButton(
          onPressed: () {
            controller.removeBlurb(index);
          },
          icon: Icon(CupertinoIcons.clear)),
      sb20(),
    ],
  );
}

Widget _buildText({
  RxString? text,
}) {
  return Obx(() => EraText(
        text: text!.value,
        color: AppColors.black,
        fontSize: EraTheme.paragraph,
        maxLines: 50,
      ));
}

Widget _buildImagePreview(
  RxList<Uint8List> images,
) {
  return Stack(
    children: [
      Obx(() => images.isNotEmpty
          ? Image.memory(
              images.first,
              width: Get.width / 2.5,
              height: Get.height / 2.5,
              fit: BoxFit.cover,
            )
          : Container()),
      Positioned(
        top: 5.h,
        right: 0,
        child: IconButton(
          onPressed: () => images.clear(),
          icon: Icon(
            CupertinoIcons.clear,
            color: AppColors.black,
          ),
        ),
      )
    ],
  );
}

Widget _buildTextField({
  TextEditingController? controller,
  String? label,
  TextInputType? keyboardType,
  width,
  void Function(String)? onChanged,
}) {
  return SizedBox(
    width: width,
    child: TextFormField(
      keyboardType: keyboardType ?? TextInputType.text,
      controller: controller,
      onChanged: onChanged,
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
