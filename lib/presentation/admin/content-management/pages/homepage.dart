import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/roster.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/button.dart';
import '../../../global.dart';

class HomePage extends GetView<ContentManagementController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
        child: Obx(() => switch (controller.homepageState.value) {
              HomepageState.loading => _loading(),
              HomepageState.loaded => _loaded(),
              HomepageState.error => _error(),
            }),
      ),
    );
  }

  _loading() {
    return Center(child: CircularProgressIndicator());
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UploadBannersWidget(maxImages: 15),
        sb20(),
        _uploadPreviewPhotos(),
        sb20(),
        _quicklinks(),
      ],
    );
  }

  _error() {
    return Container(
      child: EraText(
        text: 'error',
        color: AppColors.black,
      ),
    );
  }

  Widget _quicklinks() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'QUICK LINKS',
          color: AppColors.kRedColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
            ),
            itemCount: controller.categoryIcons.length,
            itemBuilder: (context, index) {
              var more = false.obs;
              return Stack(
                children: [
                  CloudStorage().imageLoaderProvider(
                    borderRadius: BorderRadius.circular(10.r),
                    ref: controller.categoryIcons[index]
                  ),
                  Positioned(
                    top: 25.h,
                    right: 15.h,
                    child: IconButton(
                      onPressed: () {
                        more.value = true;
                      },
                      icon: Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.black,
                        shadows: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              color: Colors.white,
                              blurRadius: 5,
                              spreadRadius: 1)
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    if (more.value == true) {
                      return Wrap(
                        children: [
                          Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 15.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                        spreadRadius: 1,
                                        color: Colors.black38)
                                  ]),
                              width: Get.width,
                              child: Column(children: [
                                Container(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () {
                                        more.value = false;
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 25.sp,
                                        color: Colors.black,
                                        shadows: const [
                                          BoxShadow(
                                              offset: Offset(0, 0),
                                              color: Colors.white,
                                              blurRadius: 5,
                                              spreadRadius: 1)
                                        ],
                                      ),
                                    )),
                                Roster.menuOptions("CHANGE ICON", () async {
                                  controller.pickImageFromWeb().then((value) {
                                    if (value != null) {
                                      controller.changeCategoryIcon();
                                    }
                                  });
                                }, Icons.change_circle),
                                SizedBox(
                                  height: 20.h,
                                )
                              ])),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  })
                ],
              );
            })
      ],
    );
  }

  Widget _uploadPreviewPhotos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildUploadPhoto(
          text: 'Preselling Preview Photo',
          image: settings!.preSellingPicture != null
              ? CloudStorage().imageLoader(ref: settings!.preSellingPicture)
              : null,
          target: "pre-selling",
          previousImage: settings!.preSellingPicture
        ),
        _buildUploadPhoto(
          text: 'Residential Preview Photo',
          image: settings!.residentialPicture != null
              ? CloudStorage().imageLoader(ref: settings!.residentialPicture)
              : null,
            target: "residential",
            previousImage: settings!.residentialPicture
        ),
        _buildUploadPhoto(
          text: 'Commercial Preview Photo',
          image: settings!.commercialPicture != null
              ? CloudStorage().imageLoader(ref: settings!.commercialPicture)
              : null,
            target: "commercial",
            previousImage: settings!.commercialPicture
        ),
        _buildUploadPhoto(
          text: 'Rental Preview Photo',
          image: settings!.rentalPicture != null
              ? CloudStorage().imageLoader(ref: settings!.rentalPicture)
              : null,
            target: "rental",
            previousImage: settings!.rentalPicture
        ),
        _buildUploadPhoto(
          text: 'Auction Preview Photo',
          image: settings!.auctionPicture != null
              ? CloudStorage().imageLoader(ref: settings!.auctionPicture)
              : null,
            target: "auction",
            previousImage: settings!.auctionPicture
        ),
      ],
    );
  }

  Widget _buildUploadPhoto({String? text, image,required target,previousImage}) {
    return Column(
      children: [
        AddListings.textBuild(
            text ?? ' ', 22.sp, FontWeight.w600, AppColors.kRedColor),
        Container(
          width: 250.w,
          height: 250.h,
          decoration: BoxDecoration(
            color: AppColors.hint.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
              onTap: () {},
              child: image ?? Image.asset(AppEraAssets.uploadAdmin)),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Button(
              onTap: ()async{
                controller.homepageState.value = HomepageState.loading;
                var newPicture = await ImagePicker().pickImage(source: ImageSource.gallery);
                if(newPicture != null){
                  await settings!.updatePicture(target, previousImage, await newPicture.readAsBytes());
                }
                controller.homepageState.value = HomepageState.loaded;
              },
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 80.w,
              text: image == null ? 'ADD' : "EDIT",
              bgColor: AppColors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            Button(
              onTap: ()async{
                await settings!.deletePicture(target, image);
              },
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 80.w,
              text: 'DELETE',
              bgColor: AppColors.hint,
              borderRadius: BorderRadius.circular(30),
            ),
          ]),
        ),
      ],
    );
  }
}
