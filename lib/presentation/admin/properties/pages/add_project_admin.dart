import 'dart:typed_data';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../agent/listings/add-edit_listings/pages/addlistings.dart';

class AddProjectAdmin extends GetView<ListingsAdminController> {
  const AddProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ListingsAdminController controller = Get.put(ListingsAdminController());
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                height: Get.height - 150.h,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                              Button(
                                onTap: (){
                                  print(controller.projectLego);
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
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      SizedBox(
                        width: Get.width,
                        child: DropdownButtonHideUnderline(
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
                                    value: 'unselect',
                                    child: EraText(
                                      text: 'None',
                                      color: AppColors.black,
                                    )),
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
                                      text: 'Indoor Amenities',
                                      color: AppColors.black,
                                    )),
                                DropdownMenuItem(
                                    value: 'space',
                                    child: EraText(
                                      text: 'Spacing',
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
                      ),
                      SizedBox(height: 20.h,),
                      Obx(() {
                        if (controller.selectedOption.value == 'bannerImages') {
                          var image;
                          return _buildCollapsibleSection(
                            onTap: ()async{
                              if(image != null){
                                controller.projectLego.add({
                                  'type' : "Banner Images",
                                  'image' : image
                                });
                                image = null;
                                controller.selectedOption.value = "unselect";
                              }else{
                                showError('Image is empty!');
                              }
                            },
                            title: 'BANNER PHOTO',
                            children: [
                              UploadBannersWidget(
                                padding: EdgeInsets.zero,
                                text: 'Upload Banners',
                                maxImages: 1,
                                onImageSelected: (Uint8List bannerImage) {
                                  image = bannerImage;
                                },
                              ),
                              sb20(),
                            ],
                          );
                        }
                        else if (controller.selectedOption.value == 'developerName') {
                          return _buildCollapsibleSection(
                            onTap: (){
                              if(controller.developerController.text.isNotEmpty){
                                controller.projectLego.add({
                                  'type' : "Developer Name",
                                  'developer_name' : controller.developerController.text
                                });
                                controller.developerController.clear();
                                controller.selectedOption.value = "unselect";
                              }else{
                                showError('Developer Name is empty');
                              }
                            },
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
                        }
                        else if (controller.selectedOption.value == 'ProjectLogo') {
                          var image;
                          return _buildCollapsibleSection(
                            onTap: (){
                              if(image != null){
                                controller.projectLego.add({
                                  'type' : "Project Logo",
                                  'image' : image
                                });
                                image = null;
                                controller.selectedOption.value = "unselect";
                              }else{
                                showError('Select a photo first!');
                              }
                            },
                            title: 'PROJECT LOGO',
                            children: [
                              UploadBannersWidget(
                                text: 'Upload Project Logo',
                                maxImages: 1,
                                onImageSelected: (Uint8List image) {
                                  image = image;
                                },
                              ),
                              sb20(),
                            ],
                          );
                        }
                        else if (controller.selectedOption.value == '3DVirtual') {
                          return _buildCollapsibleSection(
                            onTap: (){
                              String? message;
                              if(controller.virtualTitleController.text.isEmpty){
                                message = 'Please enter valid title!';
                              }
                              if(controller.virtualParagraphController.text.isEmpty){
                                message = 'Please enter valid paragraph!';
                              }
                              if(controller.virtualLinkController.text.isEmpty || !controller.virtualLinkController.text.contains('http')){
                                message = 'Please enter valid link!';
                              }
                              if(message == null){
                                controller.projectLego.add({
                                  'type' : "3D Virtual",
                                  'title' :  controller.virtualTitleController.text,
                                  'description' : controller.virtualParagraphController.text,
                                  'link' :  controller.virtualLinkController.text,
                                });
                                controller.virtualTitleController.clear();
                                controller.virtualParagraphController.clear();
                                controller.virtualLinkController.clear();
                                controller.selectedOption.value = "unselect";
                              }else{
                                showError(message);
                              }

                            },
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
                        }
                        else if (controller.selectedOption.value == 'Blurb') {
                          var blurbTitle = TextEditingController();
                          var blurbParagraph = TextEditingController();
                          var blurbImage;
                          return _buildCollapsibleSection(
                            onTap: (){
                              String? message;
                              if(blurbTitle.text.isEmpty){
                                message = 'Title is empty!';
                              }
                              if(blurbParagraph.text.isEmpty){
                                message = 'Paragraph is empty!';
                              }
                              if(blurbImage == null){
                                message = 'Image is not picked!';
                              }
                              if(message == null){
                                controller.projectLego.add({
                                  'type' : "Blurb",
                                  'title' :  blurbTitle,
                                  'description' : blurbParagraph,
                                  'image' : blurbImage,
                                });
                                blurbTitle.clear();
                                blurbParagraph.clear();
                                blurbImage = null;
                                controller.selectedOption.value = "unselect";
                              }else{
                                showError(message);
                              }

                            },
                            title: 'ADD BLURB',
                            children: [
                              _buildTextField(
                                  controller: blurbTitle,
                                  label: 'Blurb Title*',
                              ),
                              sb20(),
                              UploadBannersWidget(
                                  text: 'Upload Blurb Image',
                                  maxImages: 1,
                                  padding: EdgeInsets.zero,
                                  onImageSelected: (Uint8List image) {
                                    blurbImage = image;
                                  }),
                              sb20(),
                              TextformfieldWidget(
                                controller: blurbParagraph,
                                hintText: 'Blurb Paragraph *',
                                maxLines: 10,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                              ),
                              sb20(),
                            ],
                          );
                        }
                        else if (controller.selectedOption.value == 'location') {
                          return _buildCollapsibleSection(
                            title: 'ADD LOCATION',
                            children: [],
                          );
                        }
                        else if (controller.selectedOption.value == 'outdoorAmenities') {
                          var blurbTitle = TextEditingController();
                          var blurbParagraph = TextEditingController();
                          var blurbImage;
                          var blurbImages;
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
                                                    text: 'add blurb',
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
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          _buildTextField(
                                            controller: blurbTitle,
                                            label: 'Blurb Title*',
                                          ),
                                          sb20(),
                                          UploadBannersWidget(
                                              text: 'Upload Blurb Image',
                                              maxImages: 1,
                                              padding: EdgeInsets.zero,
                                              onImageSelected: (Uint8List image) {
                                                blurbImage = image;
                                              }),
                                          sb20(),
                                          TextformfieldWidget(
                                            controller: blurbParagraph,
                                            hintText: 'Blurb Paragraph *',
                                            maxLines: 10,
                                            textInputAction: TextInputAction.newline,
                                            keyboardType: TextInputType.multiline,
                                          ),
                                          sb20(),
                                        ]
                                      ),
                                    ],
                                  );
                                }
                                else if (controller.selectedOutDoor.value == 'gallery') {
                                  return UploadBannersWidget(
                                    padding: EdgeInsets.zero,
                                    text: 'Upload Outdoor Amenities Gallery Only',
                                    maxImages: 10,
                                    onImageSelected: (Uint8List outdoorAmenities) {
                                      blurbImages = outdoorAmenities;
                                    },
                                  );
                                }
                                else {
                                  return Container();
                                }
                              }),
                              sb20(),
                              Button(
                                onTap: (){
                                  String? message;
                                  if(controller.selectedOutDoor.value == 'blurb'){
                                    if(blurbTitle.text.isEmpty){
                                      message = 'Title is empty!';
                                    }
                                    if(blurbParagraph.text.isEmpty){
                                      message = 'Paragraph is empty!';
                                    }
                                    if(blurbImage == null){
                                      message = 'Select photos first!';
                                    }
                                    if(message == null){
                                      controller.projectLego.add({
                                        'type' : 'Outdoor Amenities',
                                        'sub_type' : 'blurb',
                                        'title' : blurbTitle.text,
                                        'description' : blurbParagraph.text,
                                        'images' : blurbImage,
                                      });
                                    }else{
                                      showError(message);
                                    }
                                  }else{
                                    if(blurbImages == null){
                                      message = 'Select photos first!';
                                    }
                                    if(message != null){
                                      controller.projectLego.add({
                                        'type' : 'indoorAmenities',
                                        'sub_type' : 'gallery',
                                        'images' : blurbImages,
                                      });
                                    }else{
                                      showError(message);
                                    }

                                  }
                                  if(message != null){
                                    blurbTitle.clear();
                                    blurbParagraph.clear();
                                    blurbImages = null;
                                    blurbImage = null;
                                    controller.selectedOption.value = "unselect";
                                  }
                                },
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: Get.width,
                                text: 'ADD',
                                bgColor: AppColors.blue,
                                borderRadius: BorderRadius.circular(30),
                              )
                            ],
                          );
                        }
                        else if (controller.selectedOption.value == 'indoorAmenities') {
                          var blurbTitle = TextEditingController();
                          var blurbParagraph = TextEditingController();
                          var blurbImage;
                          var blurbImages;
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
                                                    text: 'add blurb',
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
                                              text: 'BLURB INDOOR AMENITIES',
                                              color: AppColors.black),
                                        ],
                                      ),
                                      Column(
                                          children: [
                                            _buildTextField(
                                              controller: blurbTitle,
                                              label: 'Blurb Title*',
                                            ),
                                            sb20(),
                                            UploadBannersWidget(
                                                text: 'Upload Blurb Image',
                                                maxImages: 1,
                                                padding: EdgeInsets.zero,
                                                onImageSelected: (Uint8List image) {
                                                  blurbImage = image;
                                                }),
                                            sb20(),
                                            TextformfieldWidget(
                                              controller: blurbParagraph,
                                              hintText: 'Blurb Paragraph *',
                                              maxLines: 10,
                                              textInputAction: TextInputAction.newline,
                                              keyboardType: TextInputType.multiline,
                                            ),
                                            sb20(),
                                          ]
                                      ),
                                    ],
                                  );
                                }
                                else if (controller.selectedOutDoor.value == 'gallery') {
                                  return UploadBannersWidget(
                                    padding: EdgeInsets.zero,
                                    text: 'Upload Indoor Amenities Gallery Only',
                                    maxImages: 10,
                                    onImageSelectedMany: (List<Uint8List> outdoorAmenities) {
                                      blurbImages = outdoorAmenities;
                                    },
                                  );
                                }
                                else {
                                  return Container();
                                }
                              }),
                              sb20(),
                              Button(
                                onTap: (){
                                  String? message;
                                  if(controller.selectedOutDoor.value == 'blurb'){
                                    if(blurbTitle.text.isEmpty){
                                      message = 'Title is empty!';
                                    }
                                    if(blurbParagraph.text.isEmpty){
                                      message = 'Paragraph is empty!';
                                    }
                                    if(blurbImage == null){
                                      message = 'Select photos first!';
                                    }
                                    if(message == null){
                                      controller.projectLego.add({
                                        'type' : 'Indoor Amenities',
                                        'sub_type' : 'blurb',
                                        'title' : blurbTitle.text,
                                        'description' : blurbParagraph.text,
                                        'images' : blurbImage,
                                      });
                                    }else{
                                      showError(message);
                                    }
                                  }else{
                                    if(blurbImages == null){
                                      message = 'Select photos first!';
                                    }
                                    if(message != null){
                                      controller.projectLego.add({
                                        'type' : 'indoorAmenities',
                                        'sub_type' : 'gallery',
                                        'images' : blurbImages,
                                      });
                                    }else{
                                      showError(message);
                                    }

                                  }
                                  if(message != null){
                                    blurbTitle.clear();
                                    blurbParagraph.clear();
                                    blurbImages = null;
                                    blurbImage = null;
                                    controller.selectedOption.value = "unselect";
                                  }
                                },
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: Get.width,
                                text: 'ADD',
                                bgColor: AppColors.blue,
                                borderRadius: BorderRadius.circular(30),
                              )
                            ],
                          );
                        }
                        else if (controller.selectedOption.value == 'Carousel') {
                          var carouselTitle = TextEditingController();
                          var carouselFloorAreaC = TextEditingController();
                          var carouselNumberOfBedC = TextEditingController();
                          var carouselLoggiaSizeC = TextEditingController();
                          var carouselImages;
                          return Column(
                            children: [
                              _buildTextField(
                                controller: carouselTitle,
                                label: 'Carousel Title*',
                                onChanged: (value) {
                                  controller.addCarouselTitle(value);
                                },
                              ),
                              UploadBannersWidget(
                                text: 'Add Carousel Slider Photos',
                                maxImages: 10,
                                onImageSelectedMany: (List<Uint8List> outdoorAmenities) {
                                  carouselImages = outdoorAmenities;
                                },
                                padding: EdgeInsets.zero,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        infoTile(
                                            AppEraAssets.floorArea,
                                            carouselFloorAreaC,
                                            'Floor Area', (value) {
                                          controller.addcarouselFa(value);
                                        }),
                                        infoTile(
                                            AppEraAssets.numberOfBed,
                                            carouselNumberOfBedC,
                                            'Number of Bed', (value) {
                                          controller.addNob(value);
                                        }),
                                        infoTile(
                                            AppEraAssets.loggiaSize,
                                            carouselLoggiaSizeC,
                                            'Loggia Size', (value) {
                                          controller.addcarouselLs(value);
                                        }),
                                        //    infoTile(AppEraAssets.numberOfBed,
                                        //     controller.carouselnumberOfBedC, 'Floor Area',
                                        //     (value) {
                                        //   controller.addNob(value);
                                        // }),
                                        // HarayaProject.infoTile(AppEraAssets.loggiaSize,
                                        //     controller.carouselLoggiaSizeC.text),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              sb20(),
                              Button(
                                onTap: (){
                                  String? message;
                                  if(carouselTitle.text.isEmpty){
                                    message = 'Title is empty';
                                  }
                                  if(carouselImages == null){
                                    message = 'Images is empty';
                                  }
                                  if(message == null){
                                    controller.projectLego.add({
                                      'type' : 'Carousel',
                                      'title' : carouselTitle.text,
                                      'floor_area' : carouselFloorAreaC.text.isEmpty ? 0 : carouselFloorAreaC.text,
                                      'beds' : carouselNumberOfBedC.text.isEmpty ? 0 : carouselNumberOfBedC.text,
                                      'loggia_size' : carouselLoggiaSizeC.text.isEmpty ? 0 : carouselLoggiaSizeC.text,
                                      //'color' :
                                      'images' : carouselImages,
                                    });
                                    carouselTitle.clear();
                                    carouselFloorAreaC.clear();
                                    carouselNumberOfBedC.clear();
                                    carouselLoggiaSizeC.clear();
                                    carouselImages = null;
                                    controller.selectedOption.value = "unselect";
                                  }else{
                                    showError(message);
                                  }

                                },
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: Get.width,
                                text: 'ADD',
                                bgColor: AppColors.blue,
                                borderRadius: BorderRadius.circular(30),
                              )
                            ],
                          );
                        }
                        else if (controller.selectedOption.value == 'space') {
                          var height = TextEditingController();
                          return Column(
                            children: [
                              _buildTextField(
                                controller: height,
                                label: 'Space',
                                onChanged: (value) {
                                  controller.addCarouselTitle(value);
                                },
                              ),
                              sb20(),
                              Button(
                                onTap: (){
                                  String? message;
                                  if(height.text.isNotEmpty){
                                    controller.projectLego.add({
                                      'type' : 'Space',
                                      'height' : height.text,
                                    });
                                    height.clear();
                                    controller.selectedOption.value = "unselect";
                                  }else{
                                    showError('Space value is empty!');
                                  }

                                },
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: Get.width,
                                text: 'ADD',
                                bgColor: AppColors.blue,
                                borderRadius: BorderRadius.circular(30),
                              )
                            ],
                          );
                        }
                        else {
                          return Container();
                        }
                      }),
                      sb20(),
                      Obx((){
                        if(controller.projectLego.value.length != 0){
                          return ReorderableListView.builder(
                            key: Key('awawa'),
                            shrinkWrap: true,
                            onReorder: (oldIndex,newIndex){
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final item = controller.projectLego.removeAt(oldIndex);
                              controller.projectLego.insert(newIndex, item);
                            },
                            itemCount: controller.projectLego.length,
                            itemBuilder: (context,index){
                              return Container(
                                width: Get.width,
                                key: Key('era$index'),
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                margin: EdgeInsets.only(bottom: 10.h),
                                color: Colors.grey[200],
                                child: EraText(
                                  text: controller.projectLego[index]['type'],
                                  color: Colors.black,
                                  fontSize: 20.sp,
                                ),
                              );
                            },
                          );
                        }else{
                          return Container();
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 20.w,),
            Flexible(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                height: Get.height - 150.h,
                child: Obx((){
                  if(controller.projectLego.value.isNotEmpty){
                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.projectLego.length,
                      itemBuilder: (context,index){
                        var data = controller.projectLego[index];
                        if(data['type'] == "Banner Images"){
                          return Image.memory(
                            data['image'],
                            fit: BoxFit.cover,
                            height: 250.h,
                            width: Get.width,
                          );
                        }else if(data['type'] == "Developer Name"){

                        }else if(data['type'] == "Project Logo"){

                        }else if(data['type'] == "3D Virtual"){

                        }else if(data['type'] == "Blurb"){

                        }else if(data['type'] == "Location"){

                        }else if(data['type'] == "Outdoor Amenities"){

                        }else if(data['type'] == "Indoor Amenities"){

                        }else if(data['type'] == "Carousel"){
                          return Container(
                            decoration: BoxDecoration(color: AppColors.carouselBgColor),
                            child: CarouselSlider(
                              items: data['images'].map<Widget>((image) {
                                return Image.memory(
                                  image
                                );
                              }).toList(),
                              options: CarouselOptions(
                                enlargeCenterPage: true,
                                enlargeStrategy: CenterPageEnlargeStrategy.height,
                                autoPlay: true,
                                viewportFraction: 0.8,
                              ),
                            ));
                        }else if(data['type'] == "Space"){
                          return SizedBox(height: data['height'].toString().toDouble());
                        }
                        return Container();
                      },
                    );
                  }else{
                    return Container();
                  }
                }),
              )
            )
          ],
        ),
      ),
    );
  }
}

Widget infoTile(
    String icon, TextEditingController controller, hintText, onChanged) {
  return Row(
    children: [
      Image.asset(icon, width: 70.w, height: 70.h),
      SizedBox(
        width: 150.w,
        height: 50.h,
        child: TextformfieldWidget(
          contentPadding: EdgeInsets.only(
            top: 10.w,
          ),
          controller: controller,
          hintText: hintText,
          onChanged: onChanged,
          keyboardType: TextInputType.number,
        ),
      )
    ],
  );
}
showError(error){
  BaseController().showErroDialog(description: error,onTap: (){},width: Get.width / 2.5);
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
          controller: controller.blurbTitle,
          label: 'Blurb Title*',
          onChanged: (value) {
            controller.updateBlurbTitle(index, value);
          }),
      _buildBlurbTitle(controller: controller, index: index),
      sb20(),
      UploadBannersWidget(
          text: 'Upload Blurb Image',
          maxImages: 1,
          padding: EdgeInsets.zero,
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
  void Function()? onTap
}) {
  return Column(
    children: [
      ExpansionTile(
        title: EraText(
          text: title,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        tilePadding: EdgeInsets.zero,
        children: children,
      ),
      sb20(),
      Button(
        onTap: onTap ?? (){

        },
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: Get.width,
        text: 'ADD',
        bgColor: AppColors.blue,
        borderRadius: BorderRadius.circular(30),
      )
    ]
  );
}
