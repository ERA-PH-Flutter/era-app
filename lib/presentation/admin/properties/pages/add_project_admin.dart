import 'dart:typed_data';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/project_views.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/services/firebase_storage.dart';
import '../../../../app/widgets/era_place_search.dart';
import '../../../../repository/logs.dart';
import '../../../../repository/project.dart';
import '../../../global.dart';
import '../../landingpage/controllers/landingpage_controller.dart';

class AddProjectAdmin extends GetView<ListingsAdminController> {
  const AddProjectAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ListingsAdminController controller = Get.put(ListingsAdminController());
    return Obx((){
      return switch (controller.listingState.value) {
        ListingsAState.loading => _loading(),
        ListingsAState.loaded => _loaded(),
        ListingsAState.error => _error(),
        ListingsAState.empty => _empty(),
      };
    });
  }
  _loaded(){
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
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
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Button(
                                    onTap: (){
                                      projectsData = null;
                                      projectId = null;
                                      controller.projectLego.clear();
                                    },
                                    text: "CLEAR",
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: 150.w,
                                    color: Colors.black,
                                    border: Border.all(width: 2.w, color: AppColors.blue,),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  Button(
                                    onTap: () async {
                                      var hasDeveloperName = false;
                                      var hasCarousel = false;
                                      var hasProjectLogo = false;
                                      var hasProjectTitled = false;
                                      for (var lego in controller.projectLego) {
                                        if (lego['type'] == "Project Title") {
                                          hasProjectTitled = true;
                                        }
                                        if (lego['type'] == "Project Logo") {
                                          hasProjectLogo = true;
                                        }
                                        if (lego['type'] == "Carousel") {
                                          hasCarousel = true;
                                        }
                                        if (lego['type'] == "Developer Name") {
                                          hasDeveloperName = true;
                                        }
                                      }
                                      if (!hasDeveloperName ||
                                          !hasCarousel ||
                                          !hasProjectLogo ||
                                          !hasProjectTitled) {
                                        BaseController().showErroDialog(
                                            title: "Error",
                                            description:
                                            "Project must have Title, Developer Name, Carousel and a Logo",
                                            onTap:(){

                                            }
                                        );
                                        return;
                                      }
                                      var titleController = TextEditingController();
                                      if(projectsData != null){
                                        titleController.text = pjTitle ?? "";
                                      }
                                      showCupertinoDialog(
                                        context: Get.context!,
                                        builder: (context){
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            child: Wrap(
                                              children: [
                                                Container(
                                                  width: Get.width/3,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20.r)
                                                  ),
                                                  padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth,vertical: 21.h),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          EraText(
                                                            text: "Project Title",
                                                            fontSize: 18.sp,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                          IconButton(
                                                            onPressed: (){
                                                              Get.back();
                                                            },
                                                            icon: Icon(Icons.cancel,size: 30.sp,color: Colors.red,),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(height: 5.h,),
                                                      AppTextField(
                                                        height: 48.h,
                                                        isSuffix: false,
                                                        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                                                        isPrefix: false,
                                                        controller: titleController,
                                                        hint: "Project Title",
                                                      ),
                                                      SizedBox(height: 15.h,),
                                                      Button(
                                                        width: Get.width,
                                                        text: 'SUBMIT',
                                                        bgColor: AppColors.blue,
                                                        borderRadius: BorderRadius.circular(30),
                                                        onTap: ()async{
                                                          if(titleController.text.isNotEmpty){
                                                            try {
                                                              BaseController().showLoading();
                                                              for (var lego in controller.projectLego) {
                                                                if ([
                                                                  'Banner Images',
                                                                  'Project Logo',
                                                                  'Blurb'
                                                                ].contains(lego['type'])) {
                                                                  lego['image'] = await controller.uploadSingle(lego['image']);
                                                                } else if (['Carousel'].contains(lego['type'])) {
                                                                  lego['images'] = await controller.uploadMultiple(lego['images']);
                                                                } else if ([
                                                                  'Outdoor Amenities',
                                                                  'Indoor Amenities'
                                                                ].contains(lego['type'])) {
                                                                  if (lego['sub_type'] == 'blurb') {
                                                                    lego['image'] = await controller.uploadSingle(lego['image']);
                                                                  } else {
                                                                    lego['images'] = await controller.uploadMultiple(lego['images']);
                                                                  }
                                                                }
                                                              }
                                                              Project? project;
                                                              if(projectsData == null){
                                                                project = Project.fromJSON({
                                                                  'uploaded_by': user == null
                                                                      ? "UnknownAdmin"
                                                                      : user!.id,
                                                                  'title' : titleController.text,
                                                                  'date_created': DateTime.now(),
                                                                  'date_updated': DateTime.now(),
                                                                  'order_id': await controller.getOrderCount(),
                                                                  'data': controller.projectLego
                                                                });
                                                              }
                                                              else{
                                                                Project p = await Project.getById(projectId);
                                                                project = Project.fromJSON({
                                                                  'id' : p.id,
                                                                  'title' : titleController.text,
                                                                  'uploaded_by': p.uploadedBy,
                                                                  'date_created': p.dateCreated,
                                                                  'date_updated': DateTime.now(),
                                                                  'order_id': p.orderId,
                                                                  'data': controller.projectLego
                                                                });
                                                              }
                                                              if(projectsData != null){
                                                                print(project.toMap());
                                                                await project.updateProject();
                                                                await Logs(
                                                                    title:
                                                                    "${user!.firstname} ${user!.lastname} updated a project with ID ${project.id}",
                                                                    type: "project")
                                                                    .add();
                                                                for (var pd in controller.oldImages) {
                                                                  await CloudStorage().deleteFileDirect(docRef: pd);
                                                                }
                                                              }
                                                              else{
                                                                await project.add();
                                                                await Logs(
                                                                    title:
                                                                    "${user!.firstname} ${user!.lastname} added a project with ID ${project.id}",
                                                                    type: "project")
                                                                    .add();
                                                              }
                                                              BaseController().showSuccessDialog(
                                                                  title: "Success!",
                                                                  description:
                                                                  "Project ${projectsData != null ? 'update' : 'upload'} success!",
                                                                  hitApi: () {
                                                                    Get.back();
                                                                    Get.back();
                                                                    Get.back();
                                                                    Get.find<LandingPageController>()
                                                                        .onSectionSelected(19);
                                                                  });
                                                            } catch (e,ex) {
                                                              print(ex);
                                                              BaseController().showErroDialog(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  description: '$e');
                                                            }
                                                          }
                                                          else{
                                                            BaseController().showErroDialog(
                                                                onTap: (){

                                                                },
                                                                description: "Title is empty"
                                                            );
                                                          }
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      );
                                    },
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: 150.w,
                                    text: 'SUBMIT',
                                    bgColor: AppColors.blue,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
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
                                    value: 'ProjectTitle',
                                    child: EraText(
                                      text: 'Project Title',
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
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() {
                        if (controller.selectedOption.value == 'bannerImages') {
                          Uint8List? image;
                          return _buildCollapsibleSection(
                            onTap: () async {
                              if (image != null) {
                                controller.projectLego.add(
                                    {'type': "Banner Images", 'image': image});
                                image = null;
                                controller.selectedOption.value = "unselect";
                              } else {
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
                        } else if (controller.selectedOption.value ==
                            'ProjectTitle') {
                          return _buildCollapsibleSection(
                            onTap: () {
                              if (controller
                                  .projectTitleController.text.isNotEmpty) {
                                controller.projectLego.add({
                                  'type': "Project Title",
                                  'project_title':
                                  controller.projectTitleController.text
                                });
                                controller.projectTitleController.clear();
                                controller.selectedOption.value = "unselect";
                              } else {
                                showError('Project Title is empty');
                              }
                            },
                            title: 'Project Title',
                            children: [
                              _buildTextField(
                                controller: controller.projectTitleController,
                                label: 'Project Title*',
                              ),
                              sb20(),
                            ],
                          );
                        } else if (controller.selectedOption.value ==
                            'developerName') {
                          return _buildCollapsibleSection(
                            onTap: () {
                              if (controller
                                  .developerController.text.isNotEmpty) {
                                controller.projectLego.add({
                                  'type': "Developer Name",
                                  'developer_name':
                                  controller.developerController.text
                                });
                                controller.developerController.clear();
                                controller.selectedOption.value = "unselect";
                              } else {
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
                        } else if (controller.selectedOption.value ==
                            'ProjectLogo') {
                          Uint8List? imageLogo;
                          return _buildCollapsibleSection(
                            onTap: () async {
                              if (imageLogo != null) {
                                controller.projectLego.add({
                                  'type': "Project Logo",
                                  'image': imageLogo
                                });
                                imageLogo = null;
                                controller.selectedOption.value = "unselect";
                              } else {
                                showError('Select a photo first!');
                              }
                            },
                            title: 'PROJECT LOGO',
                            children: [
                              UploadBannersWidget(
                                padding: EdgeInsets.zero,
                                text: 'Upload Logo',
                                maxImages: 1,
                                onImageSelected: (Uint8List image) {
                                  imageLogo = image;
                                },
                              ),
                              sb20(),
                            ],
                          );
                        } else if (controller.selectedOption.value ==
                            '3DVirtual') {
                          return _buildCollapsibleSection(
                            onTap: () {
                              String? message;
                              if (controller
                                  .virtualTitleController.text.isEmpty) {
                                message = 'Please enter valid title!';
                              }
                              if (controller
                                  .virtualParagraphController.text.isEmpty) {
                                message = 'Please enter valid paragraph!';
                              }
                              if (controller
                                  .virtualLinkController.text.isEmpty ||
                                  !controller.virtualLinkController.text
                                      .contains('http')) {
                                message = 'Please enter valid link!';
                              }
                              if (message == null) {
                                controller.projectLego.add({
                                  'type': "3D Virtual",
                                  'title':
                                  controller.virtualTitleController.text,
                                  'description': controller
                                      .virtualParagraphController.text,
                                  'link': controller.virtualLinkController.text,
                                });
                                controller.virtualTitleController.clear();
                                controller.virtualParagraphController.clear();
                                controller.virtualLinkController.clear();
                                controller.selectedOption.value = "unselect";
                              } else {
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
                                controller:
                                controller.virtualParagraphController,
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
                          var blurbTitle = TextEditingController();
                          var blurbParagraph = TextEditingController();
                          Uint8List? blurbImage;
                          return _buildCollapsibleSection(
                            onTap: () {
                              String? message;
                              if (blurbTitle.text.isEmpty) {
                                message = 'Title is empty!';
                              }
                              if (blurbParagraph.text.isEmpty) {
                                message = 'Paragraph is empty!';
                              }
                              if (blurbImage == null) {
                                message = 'Image is not picked!';
                              }
                              if (message == null) {
                                controller.projectLego.add({
                                  'type': "Blurb",
                                  'title': blurbTitle.text,
                                  'image': blurbImage,
                                  'description': blurbParagraph.text,
                                });
                                blurbTitle.clear();
                                blurbParagraph.clear();
                                blurbImage = null;
                                controller.selectedOption.value = "unselect";
                              } else {
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
                        } else if (controller.selectedOption.value ==
                            'location') {
                          var textController = TextEditingController();
                          var coords;
                          return _buildCollapsibleSection(
                            onTap: () {
                              controller.projectLego.add({
                                'type': "Location",
                                'location': [coords.latitude, coords.longitude]
                              });
                              controller.selectedOption.value = "unselect";
                            },
                            title: 'ADD LOCATION',
                            children: [
                              SizedBox(
                                width: Get.width,
                                child: EraPlaceSearch(
                                  textFieldController: textController,
                                  callback: (coordinate) async {
                                    coords = coordinate;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          );
                        } else if (controller.selectedOption.value ==
                            'outdoorAmenities') {
                          var blurbTitle = TextEditingController();
                          var blurbParagraph = TextEditingController();
                          Uint8List? blurbImage;
                          List<Uint8List>? blurbImages;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                          value: controller
                                              .selectedOutDoor.value.isEmpty
                                              ? null
                                              : controller
                                              .selectedOutDoor.value,
                                          items: [
                                            DropdownMenuItem(
                                                value: 'blurb',
                                                child: EraText(
                                                    text: 'blurb',
                                                    color: AppColors.black)),
                                            DropdownMenuItem(
                                                value: 'gallery',
                                                child: EraText(
                                                    text: 'gallery',
                                                    color: AppColors.black)),
                                          ],
                                          onChanged: (value) {
                                            controller.selectedOutDoor.value =
                                            value!;
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() {
                                if (controller.selectedOutDoor.value ==
                                    'blurb') {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          EraText(
                                              text: 'BLURB OUTDOOR AMENITIES',
                                              color: AppColors.black),
                                        ],
                                      ),
                                      Column(children: [
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
                                          textInputAction:
                                          TextInputAction.newline,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                        sb20(),
                                      ]),
                                    ],
                                  );
                                } else if (controller.selectedOutDoor.value ==
                                    'gallery') {
                                  return UploadBannersWidget(
                                    padding: EdgeInsets.zero,
                                    text:
                                    'Upload Outdoor Amenities Gallery Only',
                                    maxImages: 10,
                                    onImageSelectedMany:
                                        (List<Uint8List> outdoorAmenities) {
                                      blurbImages = outdoorAmenities;
                                      print(
                                          'Gallery images selected: ${blurbImages?.length} images');
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                              sb20(),
                              Button(
                                onTap: () {
                                  String? message;
                                  if (controller.selectedOutDoor.value ==
                                      'blurb') {
                                    if (blurbTitle.text.isEmpty) {
                                      message = 'Title is empty!';
                                    }
                                    if (blurbParagraph.text.isEmpty) {
                                      message = 'Paragraph is empty!';
                                    }
                                    if (blurbImage == null) {
                                      message = 'Select photos first!';
                                    }
                                    if (message == null) {
                                      controller.projectLego.add({
                                        'type': 'Outdoor Amenities',
                                        'sub_type': 'blurb',
                                        'title': blurbTitle.text,
                                        'image': blurbImage,
                                        'description': blurbParagraph.text,
                                      });
                                    } else {
                                      showError(message);
                                    }
                                  } else if (controller.selectedOutDoor.value ==
                                      'gallery') {
                                    if (blurbImages == null ||
                                        blurbImages!.isEmpty) {
                                      message = 'Select photos first!';
                                    }
                                    if (message == null) {
                                      controller.projectLego.add({
                                        'type': 'Outdoor Amenities',
                                        'sub_type': 'gallery',
                                        'images': blurbImages,
                                      });
                                    } else {
                                      showError(message);
                                    }
                                  }

                                  if (message == null) {
                                    blurbTitle.clear();
                                    blurbParagraph.clear();
                                    blurbImage = null;
                                    controller.selectedOption.value =
                                    "unselect";
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
                        } else if (controller.selectedOption.value ==
                            'indoorAmenities') {
                          var blurbTitle = TextEditingController();
                          var blurbParagraph = TextEditingController();
                          Uint8List? blurbImage;
                          List<Uint8List>? blurbImages;
                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                          value: controller
                                              .selectedOutDoor.value.isEmpty
                                              ? null
                                              : controller
                                              .selectedOutDoor.value,
                                          items: [
                                            DropdownMenuItem(
                                                value: 'blurb',
                                                child: EraText(
                                                    text: 'blurb',
                                                    color: AppColors.black)),
                                            DropdownMenuItem(
                                                value: 'gallery',
                                                child: EraText(
                                                    text: 'gallery',
                                                    color: AppColors.black)),
                                          ],
                                          onChanged: (value) {
                                            controller.selectedOutDoor.value =
                                            value!;
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() {
                                if (controller.selectedOutDoor.value ==
                                    'blurb') {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          EraText(
                                              text: 'BLURB INDOOR AMENITIES',
                                              color: AppColors.black),
                                        ],
                                      ),
                                      Column(children: [
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
                                          textInputAction:
                                          TextInputAction.newline,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                        sb20(),
                                      ]),
                                    ],
                                  );
                                } else if (controller.selectedOutDoor.value ==
                                    'gallery') {
                                  return UploadBannersWidget(
                                    padding: EdgeInsets.zero,
                                    text:
                                    'Upload Indoor Amenities Gallery Only',
                                    maxImages: 10,
                                    onImageSelectedMany:
                                        (List<Uint8List> outdoorAmenities) {
                                      blurbImages = outdoorAmenities;
                                    },
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                              sb20(),
                              Button(
                                onTap: () {
                                  String? message;
                                  if (controller.selectedOutDoor.value ==
                                      'blurb') {
                                    if (blurbTitle.text.isEmpty) {
                                      message = 'Title is empty!';
                                    }
                                    if (blurbParagraph.text.isEmpty) {
                                      message = 'Paragraph is empty!';
                                    }
                                    if (blurbImage == null) {
                                      message = 'Select photos first!';
                                    }
                                    if (message == null) {
                                      controller.projectLego.add({
                                        'type': 'Indoor Amenities',
                                        'sub_type': 'blurb',
                                        'title': blurbTitle.text,
                                        'image': blurbImage,
                                        'description': blurbParagraph.text,
                                      });
                                    } else {
                                      showError(message);
                                    }
                                  } else if (controller.selectedOutDoor.value ==
                                      'gallery') {
                                    if (blurbImages == null ||
                                        blurbImages!.isEmpty) {
                                      message = 'Select photos first!';
                                    }
                                    if (message == null) {
                                      controller.projectLego.add({
                                        'type': 'Indoor Amenities',
                                        'sub_type': 'gallery',
                                        'images': blurbImages,
                                      });
                                    } else {
                                      showError(message);
                                    }
                                  }
                                  if (message == null) {
                                    blurbTitle.clear();
                                    blurbParagraph.clear();
                                    blurbImages = null;
                                    blurbImage = null;
                                    controller.selectedOption.value =
                                    "unselect";
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
                        } else if (controller.selectedOption.value ==
                            'Carousel') {
                          var carouselTitle = TextEditingController();
                          var carouselFloorAreaC = TextEditingController();
                          var carouselNumberOfBedC = TextEditingController();
                          var carouselLoggiaSizeC = TextEditingController();
                          var carouselImages;
                          var carouselParagraph = TextEditingController();
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
                                onImageSelectedMany:
                                    (List<Uint8List> outdoorAmenities) {
                                  carouselImages = outdoorAmenities;
                                },
                                padding: EdgeInsets.zero,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 25.w),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        infoTile(
                                          AppEraAssets.floorArea,
                                          carouselFloorAreaC,
                                          'Floor Area',
                                              (value) {
                                            controller.addcarouselFa(value);
                                          },
                                        ),
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
                              TextformfieldWidget(
                                controller: carouselParagraph,
                                hintText: 'Paragraph *',
                                maxLines: 10,
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                              ),
                              sb20(),
                              Button(
                                onTap: () {
                                  String? message;
                                  if (carouselTitle.text.isEmpty) {
                                    message = 'Title is empty';
                                  }
                                  if (carouselImages == null) {
                                    message = 'Images is empty';
                                  }
                                  if (carouselParagraph.text.isEmpty) {
                                    message = 'Paragraph is empty!';
                                  }
                                  if (message == null) {
                                    controller.projectLego.add({
                                      'type': 'Carousel',
                                      'title': carouselTitle.text,
                                      'floor_area':
                                      carouselFloorAreaC.text.isEmpty
                                          ? 0
                                          : carouselFloorAreaC.text,
                                      'beds': carouselNumberOfBedC.text.isEmpty
                                          ? 0
                                          : carouselNumberOfBedC.text,
                                      'loggia_size':
                                      carouselLoggiaSizeC.text.isEmpty
                                          ? 0
                                          : carouselLoggiaSizeC.text,
                                      //'color' :
                                      'paragraph': carouselParagraph.text,
                                      'images': carouselImages,
                                    });
                                    carouselTitle.clear();
                                    carouselFloorAreaC.clear();
                                    carouselNumberOfBedC.clear();
                                    carouselLoggiaSizeC.clear();
                                    carouselParagraph.clear();
                                    carouselImages = null;
                                    controller.selectedOption.value =
                                    "unselect";
                                  } else {
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
                        } else if (controller.selectedOption.value == 'space') {
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
                                onTap: () {
                                  if (height.text.isNotEmpty) {
                                    controller.projectLego.add({
                                      'type': 'Space',
                                      'height': height.text,
                                    });
                                    height.clear();
                                    controller.selectedOption.value =
                                    "unselect";
                                  } else {
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
                        } else {
                          return Container();
                        }
                      }),
                      sb20(),
                      Obx(() {
                        if (controller.projectLego.value.isNotEmpty) {
                          return ReorderableListView.builder(
                            key: Key('addProjects'),
                            shrinkWrap: true,
                            onReorder: (oldIndex, newIndex) {
                              if (oldIndex < newIndex) {
                                newIndex -= 1;
                              }
                              final item =
                              controller.projectLego.removeAt(oldIndex);
                              controller.projectLego.insert(newIndex, item);
                            },
                            itemCount: controller.projectLego.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: Get.width,
                                key: Key('era$index'),
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                margin: EdgeInsets.only(bottom: 10.h),
                                color: Colors.grey[200],
                                child: ListTile(
                                  title: EraText(
                                    text: controller.projectLego[index]['type'],
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                  ),
                                  trailing: Padding(
                                    padding: EdgeInsets.only(right: 5.w),
                                    child: IconButton(
                                        onPressed: () {
                                          controller.projectLego
                                              .removeAt(index);
                                        },
                                        icon: Icon(Icons.delete)),
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return Container();
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20.w,
            ),
            Flexible(
                flex: 1,
                child: Wrap(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: Get.width,
                    ),
                    EraText(
                      text: 'PROJECT PREVIEW',
                      color: AppColors.black,
                      fontSize: EraTheme.header,
                      fontWeight: FontWeight.w500,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.h,bottom: 20.h),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              spreadRadius: 0,
                              color: Colors.black26)
                        ],
                      ),
                      child: Obx(() {
                        if (controller.projectLego.value.isNotEmpty){
                          return ProjectViews(
                            project: Project.fromJSON({
                              'id' : projectId,
                              'data' : controller.projectLego
                            })
                          ).build();
                        }
                        else {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: EraText(
                                text: "Empty data",
                                color: Colors.black,
                                fontSize: 17.sp,
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
  _loading(){
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  _empty(){
    return Center(
      child: EraText(text: "empty",color: Colors.black,),
    );
  }
  _error(){
    return Center(
      child: EraText(text: "error",color: Colors.black,),
    );
  }
}

Widget infoTile(
    String icon, TextEditingController controller, hintText, onChanged) {
  return Row(
    children: [
      Image.asset(icon, width: 70.w, height: 70.h),
      SizedBox(
        width: 100.w,
        height: 50.h,
        child: TextformfieldWidget(
          contentPadding: EdgeInsets.only(
            top: 10.w,
          ),
          controller: controller,
          hintText: hintText,
          hintstlye: TextStyle(fontSize: 15.sp),
          onChanged: onChanged,
          keyboardType: TextInputType.number,
          readOnly: false,
        ),
      )
    ],
  );
}

showError(error) {
  BaseController()
      .showErroDialog(description: error, onTap: () {}, width: Get.width / 2.5);
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

Widget _buildCollapsibleSection(
    {required String title,
    required List<Widget> children,
    void Function()? onTap}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      onTap: onTap ?? () {},
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: Get.width,
      text: 'ADD',
      bgColor: AppColors.blue,
      borderRadius: BorderRadius.circular(30),
    )
  ]);
}

Widget title({text, color, padding, textAlign}) {
  return Padding(
    padding:
        padding ?? EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth20),
    child: EraText(
      text: text,
      color: color ?? AppColors.kRedColor,
      fontSize: EraTheme.header + 3.sp,
      fontWeight: FontWeight.bold,
      textAlign: textAlign ?? TextAlign.center,
    ),
  );
}

Widget description({text, color, padding}) {
  return Padding(
    padding:
        padding ?? EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth30),
    child: EraText(
      text: text,
      color: color ?? AppColors.black,
      fontSize: EraTheme.subHeader,
      fontWeight: FontWeight.w500,
      maxLines: 20,
    ),
  );
}
