import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/content_management_controller.dart';
import 'package:eraphilippines/presentation/admin/content-management/pages/uploadbanners_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/sized_box.dart';

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
          UploadBannersWidget(
              controller: controller,
              maxImages: 15,
              text: 'UPLOAD PROJECT-MAIN BANNER'),
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
          EraText(
            text: 'FIND LISTINGS TO BE FEATURED',
            color: AppColors.kRedColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
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
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount: randomIndex.length,
                itemBuilder: (context, index) {
                  var docIndex = randomIndex[index];

                  var listing =
                      Listing.fromJSON(snapshot.data!.docs[docIndex].data());
                  print('Number of children: ${randomIndex.length}');

                  return GestureDetector(
                    onTap: () async {
                      await Database().addViews(listing.id);
                      Get.toNamed('/propertyInfo', arguments: listing);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                            blurRadius: 10,
                            color: Colors.black12,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CloudStorage().imageLoader(
                              ref: listing.photos != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos!.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                              width: Get.width,
                              height: 300.h,
                            ),
                          ),
                          sb17(),
                          Container(
                            width: Get.width,
                            height: 30.h,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: EraText(
                              textOverflow: TextOverflow.ellipsis,
                              text: listing.name! == ""
                                  ? "No Name"
                                  : listing.name!,
                              fontSize: EraTheme.header - 5.sp,
                              color: AppColors.kRedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: EraText(
                              text: listing.type!,
                              fontSize: EraTheme.header - 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1,
                            ),
                          ),
                          sb5(),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppEraAssets.area,
                                    width: 55.w,
                                    height: 55.w,
                                  ),
                                  SizedBox(width: 2.w),
                                  EraText(
                                    text: '${listing.area} sqm',
                                    fontSize: EraTheme.paragraph - 1.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),
                              sbw10(),
                              Image.asset(
                                AppEraAssets.bed,
                                width: 55.w,
                                height: 55.w,
                              ),
                              EraText(
                                text: '${listing.beds}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              sbw10(),
                              Image.asset(
                                AppEraAssets.tub,
                                width: 55.w,
                                height: 55.w,
                              ),
                              EraText(
                                text: '${listing.baths}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              sbw10(),
                              Image.asset(
                                AppEraAssets.car,
                                width: 55.w,
                                height: 55.w,
                              ),
                              EraText(
                                text: '${listing.cars}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          sb5(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: EraText(
                              text: 'Description:',
                              fontSize: EraTheme.header - 8.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                              lineHeight: 1,
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Text(
                              listing.description == ""
                                  ? "No description."
                                  : listing.description!,
                              style: TextStyle(
                                fontSize: EraTheme.paragraph - 4.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: EraText(
                              text: NumberFormat.currency(
                                      locale: 'en_PH', symbol: 'PHP ')
                                  .format(
                                listing.price.toString() == ""
                                    ? 0
                                    : listing.price,
                              ),
                              color: AppColors.blue,
                              fontSize: EraTheme.header,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
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
      ],
    );
  }
}
