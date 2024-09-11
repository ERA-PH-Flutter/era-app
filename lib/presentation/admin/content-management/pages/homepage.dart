import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/button.dart';

class HomePage extends GetView<ContentManagementController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UploadBannersWidget(controller: controller, maxImages: 15),
          sb20(),
          // preview photos
          _uploadPreviewPhotos(),
          sb20(),

          _featuredProjects(),
        ],
      ),
    );
  }

  Widget _featuredProjects() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              EraText(
                text: 'FEATURED LISTINGS',
                color: AppColors.kRedColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              sbw30(),
              Container(
                width: 300.w,
                child: TextformfieldWidget(
                  hintText: 'Find Listings',
                  maxLines: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('listings').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<int> randomIndex = [];
              for (int i = 0; i < min(10, snapshot.data!.docs.length); i++) {
                var random = Random().nextInt(snapshot.data!.docs.length);
                while (randomIndex.contains(random)) {
                  random = Random().nextInt(snapshot.data!.docs.length);
                }
                randomIndex.add(random);
              }

              return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisExtent: 200,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: randomIndex.length,
                  itemBuilder: (context, index) {
                    var docIndex = randomIndex[index];
                    var listing =
                        Listing.fromJSON(snapshot.data!.docs[docIndex].data());

                    return Obx(() => Stack(
                          children: [
                            GestureDetector(
                              onLongPress: () {
                                print('Long pressed on index: $index');
                                controller.toggleSelection(index);
                              },
                              onTap: () {
                                print('Tapped on index: $index');
                                if (controller.selectionModeActive.value) {
                                  controller.toggleSelection(index);
                                }
                              },
                              child: Card(
                                color: AppColors.white,
                                elevation: 7,
                                child: Row(
                                  children: [
                                    CloudStorage().imageLoaderProvider(
                                      width: 120.w,
                                      height: 200.h,
                                      ref:
                                          '${listing.photos != null ? (listing.photos!.isNotEmpty ? listing.photos!.first : AppStrings.noUserImageWhite) : AppStrings.noUserImageWhite}',
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        bottomLeft: Radius.circular(10.r),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.h, left: 10.w),
                                        child: FutureBuilder<EraUser>(
                                          future: EraUser().getById(listing.by),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    height: 25.h,
                                                    child: EraText(
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      text:
                                                          '${snapshot.data?.firstname ?? "Admin"} ${snapshot.data?.lastname ?? ""}',
                                                      color: AppColors.blue,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  EraText(
                                                    text: listing.type!,
                                                    color: AppColors.black,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.bold,
                                                    maxLines: 3,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  EraText(
                                                    text: listing.description ??
                                                        "No Description",
                                                    color: AppColors.black,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w500,
                                                    maxLines: 3,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  EraText(
                                                    text: NumberFormat.currency(
                                                      locale: 'en_PH',
                                                      symbol: 'PHP ',
                                                    ).format(listing.price),
                                                    color: AppColors.blue,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Button(
                                width: 100.w,
                                text: controller.isSelected(index)
                                    ? 'Unselect'
                                    : 'Select',
                                bgColor: controller.isSelected(index)
                                    ? AppColors.kRedColor
                                    : AppColors.blue,
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            if (controller.selectionModeActive.value)
                              GestureDetector(
                                onTap: () => controller.toggleSelection(index),
                                child: Container(
                                    decoration: BoxDecoration(
                                  borderRadius: controller.isSelected(index)
                                      ? BorderRadius.circular(10)
                                      : null,
                                  border: Border.all(
                                    color: controller.isSelected(index)
                                        ? AppColors.kRedColor
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                )),
                              ),
                          ],
                        ));
                  });
            },
          ),
        ],
      ),
    );
  }

  Widget _uploadPreviewPhotos() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildUploadPhoto(
          text: 'Preselling Preview Photo',
        ),
        _buildUploadPhoto(
          text: 'Residential Preview Photo',
        ),
        _buildUploadPhoto(
          text: 'Commercial Preview Photo',
        ),
        _buildUploadPhoto(
          text: 'Rental Preview Photo',
        ),
        _buildUploadPhoto(
          text: 'Auction Preview Photo',
        ),
      ],
    );
  }

  Widget _buildUploadPhoto({String? text}) {
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
            border: Border.all(
              color: AppColors.hint.withOpacity(0.9),
              width: 2,
            ),
          ),
          child: GestureDetector(
              onTap: () {}, child: Image.asset(AppEraAssets.uploadAdmin)),
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Button(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 80.w,
              text: 'ADD',
              bgColor: AppColors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            Button(
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
