import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/content-management/controllers/homepage_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/bindings/agent_listings_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/agent_listings.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/agentsDashBoard.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends GetView<HomePageController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _uploadBanners(),
          _uploadProjectMainBanner(),
          _featuredProjects(),
        ],
      ),
    );
  }

  Widget _uploadBanners() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddListings.textBuild(
                'UPLOAD BANNERS', 22.sp, FontWeight.w600, AppColors.kRedColor),
            Obx(() => AddListings.textBuild('${controller.images.length}/2',
                22.sp, FontWeight.w600, Colors.black)),
          ],
        ),
        SizedBox(height: 10.h),
        // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
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
                onPressed: () {
                  controller.getImageGallery();
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
          if (controller.images.isEmpty) {
            return _buildUploadPhoto();
          } else {
            return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.h,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(controller.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }
        }),

        SizedBox(height: 5.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: EraText(
              text: 'Photo must be at least 300px X 300px',
              fontSize: 15.sp,
              color: AppColors.hint),
        ),
      ],
    );
  }

  Widget _uploadProjectMainBanner() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddListings.textBuild('UPLOAD PROJECT-MAIN BANNER', 22.sp,
                FontWeight.w600, AppColors.kRedColor),
            Obx(() => AddListings.textBuild('${controller.images.length}/1',
                22.sp, FontWeight.w600, Colors.black)),
          ],
        ),
        SizedBox(height: 10.h),
        // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
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
                onPressed: () {
                  controller.getImageGallery();
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
          if (controller.images.isEmpty) {
            return _buildUploadPhoto();
          } else {
            return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.h,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(controller.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }
        }),

        SizedBox(height: 5.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: EraText(
              text: 'Photo must be at least 300px X 300px',
              fontSize: 15.sp,
              color: AppColors.hint),
        ),
      ],
    );
  }

  Widget _buildUploadPhoto() {
    return Column(
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
    );
  }

  // Widget _featuredProjects() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection('listings').snapshots(),
  //       builder: (context, snapshot) {
  //         if (!snapshot.hasData) {
  //           return Center(child: CircularProgressIndicator());
  //         }
  //         List<Widget> children = [];
  //         List randomIndex = [];
  //         for (int i = 0; i < min(5, snapshot.data!.docs.length); i++) {
  //           var random = Random().nextInt(snapshot.data!.docs.length);
  //           while (randomIndex.contains(random)) {
  //             random = Random().nextInt(snapshot.data!.docs.length);
  //           }
  //           randomIndex.add(random);
  //           var listing = EraUser.fromJSON(snapshot.data!.docs[random].data());
  //           children.add(
  //             Container(
  //               //   color: AppColors.kRedColor,
  //               height: 160.h,
  //               child: Padding(
  //                 padding: EdgeInsets.only(right: 10.w),
  //                 child: Column(
  //                   children: [
  //                     ListView.builder(
  //                       physics: const ScrollPhysics(),
  //                       shrinkWrap: true,
  //                       itemCount: controller.listings.length,
  //                       itemBuilder: (context, index) {
  //                         Listing listing = controller.listings[index];
  //                         return GestureDetector(
  //                           onTap: () async {
  //                             await Database().addViews(listing.id);
  //                             Get.toNamed('/propertyInfo', arguments: listing);
  //                           },
  //                           child: Container(
  //                             margin: EdgeInsets.only(bottom: 16.h),
  //                             padding: EdgeInsets.zero,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(10.r),
  //                                 boxShadow: const [
  //                                   BoxShadow(
  //                                       offset: Offset(0, 0),
  //                                       spreadRadius: 1,
  //                                       blurRadius: 10,
  //                                       color: Colors.black12)
  //                                 ]),
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 ClipRRect(
  //                                   borderRadius: BorderRadius.circular(10.r),
  //                                   child: CloudStorage().imageLoader(
  //                                     ref: listing.photos != null
  //                                         ? (listing.photos!.isNotEmpty
  //                                             ? listing.photos!.first
  //                                             : AppStrings.noUserImageWhite)
  //                                         : AppStrings.noUserImageWhite,
  //                                     width: Get.width,
  //                                     height: 300.h,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 17.h,
  //                                 ),
  //                                 Container(
  //                                   width: Get.width,
  //                                   height: 30.h,
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 14.w),
  //                                   child: EraText(
  //                                     textOverflow: TextOverflow.ellipsis,
  //                                     text: listing.name! == ""
  //                                         ? "No Name"
  //                                         : listing.name!,
  //                                     fontSize: EraTheme.header - 5.sp,
  //                                     color: AppColors.kRedColor,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                                 Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 14.w),
  //                                   child: EraText(
  //                                     text: listing.type!,
  //                                     fontSize: EraTheme.header - 12.sp,
  //                                     color: AppColors.black,
  //                                     fontWeight: FontWeight.bold,
  //                                     lineHeight: 1,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 5.h,
  //                                 ),
  //                                 Row(
  //                                   //crossAxisAlignment: CrossAxisAlignment.start,
  //                                   children: [
  //                                     Row(
  //                                       children: [
  //                                         Image.asset(
  //                                           AppEraAssets.area,
  //                                           width: 55.w,
  //                                           height: 55.w,
  //                                         ),
  //                                         SizedBox(width: 2.w),
  //                                         EraText(
  //                                           text: '${listing.area} sqm',
  //                                           fontSize: EraTheme.paragraph - 1.sp,
  //                                           fontWeight: FontWeight.w500,
  //                                           color: AppColors.black,
  //                                         ),
  //                                       ],
  //                                     ),
  //                                     SizedBox(width: 10.w),
  //                                     Image.asset(
  //                                       AppEraAssets.bed,
  //                                       width: 55.w,
  //                                       height: 55.w,
  //                                     ),
  //                                     EraText(
  //                                       text: '${listing.beds}',
  //                                       fontSize: EraTheme.paragraph - 1.sp,
  //                                       fontWeight: FontWeight.w500,
  //                                       color: AppColors.black,
  //                                     ),
  //                                     SizedBox(width: 10.w),
  //                                     Image.asset(
  //                                       AppEraAssets.tub,
  //                                       width: 55.w,
  //                                       height: 55.w,
  //                                     ),
  //                                     EraText(
  //                                       text: '${listing.baths}',
  //                                       fontSize: EraTheme.paragraph - 1.sp,
  //                                       fontWeight: FontWeight.w500,
  //                                       color: AppColors.black,
  //                                     ),
  //                                     SizedBox(width: 10.w),
  //                                     Image.asset(
  //                                       AppEraAssets.car,
  //                                       width: 55.w,
  //                                       height: 55.w,
  //                                     ),
  //                                     EraText(
  //                                       text: '${listing.cars}',
  //                                       fontSize: EraTheme.paragraph - 1.sp,
  //                                       fontWeight: FontWeight.w500,
  //                                       color: AppColors.black,
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(
  //                                   height: 5.h,
  //                                 ),
  //                                 Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 14.w),
  //                                   child: EraText(
  //                                     text: 'Description:',
  //                                     fontSize: EraTheme.header - 8.sp,
  //                                     color: AppColors.black,
  //                                     fontWeight: FontWeight.w600,
  //                                     lineHeight: 1,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 2.h,
  //                                 ),
  //                                 Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 14.w),
  //                                   child: Text(
  //                                     listing.description == ""
  //                                         ? "No description."
  //                                         : listing.description!,
  //                                     style: TextStyle(
  //                                       fontSize: EraTheme.paragraph - 4.sp,
  //                                       fontWeight: FontWeight.w500,
  //                                       color: AppColors.black,
  //                                     ),
  //                                     maxLines: 5,
  //                                     overflow: TextOverflow.ellipsis,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 5.h,
  //                                 ),
  //                                 Padding(
  //                                   padding:
  //                                       EdgeInsets.symmetric(horizontal: 14.w),
  //                                   child: EraText(
  //                                     text: NumberFormat.currency(
  //                                             locale: 'en_PH', symbol: 'PHP ')
  //                                         .format(
  //                                       listing.price.toString() == ""
  //                                           ? 0
  //                                           : listing.price,
  //                                     ),
  //                                     color: AppColors.blue,
  //                                     fontSize: EraTheme.header,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   height: 15.h,
  //                                 ),
  //                               ],
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  //         }
  //         return Row(
  //           children: children,
  //         );
  //       },
  //     ),
  //   );
  // }
  // Widget _featuredProjects() {
  //   return SingleChildScrollView(
  //     scrollDirection: Axis.horizontal,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         EraText(
  //           text: 'FIND LISTINGS TO BE FEATURED',
  //           color: AppColors.kRedColor,
  //           fontSize: 20.sp,
  //           fontWeight: FontWeight.w600,
  //         ),
  //         SizedBox(height: 10.h),
  //         SingleChildScrollView(
  //           scrollDirection: Axis.horizontal,
  //           child: StreamBuilder(
  //             stream:
  //                 FirebaseFirestore.instance.collection('listings').snapshots(),
  //             builder: (context, snapshot) {
  //               if (!snapshot.hasData) {
  //                 return Center(child: CircularProgressIndicator());
  //               }
  //               List<Widget> children = [];
  //               List randomIndex = [];
  //               for (int i = 0; i < min(5, snapshot.data!.docs.length); i++) {
  //                 var random = Random().nextInt(snapshot.data!.docs.length);
  //                 while (randomIndex.contains(random)) {
  //                   random = Random().nextInt(snapshot.data!.docs.length);
  //                 }
  //                 randomIndex.add(random);
  //                 var user =
  //                     EraUser.fromJSON(snapshot.data!.docs[random].data());
  //                 var listing =
  //                     Listing.fromJSON(snapshot.data!.docs[random].data());
  //                 print(
  //                     'Image URL: ${listing.photos?.first ?? AppStrings.noUserImageWhite}');
  //                 children.add(
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 10.w),
  //                     child: GestureDetector(
  //                       onTap: () async {
  //                         await Database().addViews(listing.id);
  //                         Get.toNamed('/propertyInfo', arguments: listing);
  //                       },
  //                       child: Container(
  //                         width: 400.w,
  //                         height: Get.height - 430.h,
  //                         margin: EdgeInsets.only(bottom: 16.h),
  //                         padding: EdgeInsets.zero,
  //                         decoration: BoxDecoration(
  //                             color: Colors.white,
  //                             borderRadius: BorderRadius.circular(10.r),
  //                             boxShadow: const [
  //                               BoxShadow(
  //                                   offset: Offset(0, 0),
  //                                   spreadRadius: 1,
  //                                   blurRadius: 10,
  //                                   color: Colors.black12)
  //                             ]),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             ClipRRect(
  //                               borderRadius: BorderRadius.circular(10.r),
  //                               child: CloudStorage().imageLoader(
  //                                 ref: listing.photos?.first != null
  //                                     ? (listing.photos!.isNotEmpty
  //                                         ? listing.photos?.first
  //                                         : AppStrings.noUserImageWhite)
  //                                     : AppStrings.noUserImageWhite,
  //                                 width: Get.width,
  //                                 height: 300.h,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 17.h,
  //                             ),
  //                             Container(
  //                               width: Get.width,
  //                               height: 30.h,
  //                               padding: EdgeInsets.symmetric(horizontal: 14.w),
  //                               child: EraText(
  //                                 textOverflow: TextOverflow.ellipsis,
  //                                 text: listing.name! == ""
  //                                     ? "No Name"
  //                                     : listing.name!,
  //                                 fontSize: EraTheme.header - 5.sp,
  //                                 color: AppColors.kRedColor,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 14.w),
  //                               child: EraText(
  //                                 text: listing.type!,
  //                                 fontSize: EraTheme.header - 12.sp,
  //                                 color: AppColors.black,
  //                                 fontWeight: FontWeight.bold,
  //                                 lineHeight: 1,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 5.h,
  //                             ),
  //                             Row(
  //                               //crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Row(
  //                                   children: [
  //                                     Image.asset(
  //                                       AppEraAssets.area,
  //                                       width: 55.w,
  //                                       height: 55.w,
  //                                     ),
  //                                     SizedBox(width: 2.w),
  //                                     EraText(
  //                                       text: '${listing.area} sqm',
  //                                       fontSize: EraTheme.paragraph - 1.sp,
  //                                       fontWeight: FontWeight.w500,
  //                                       color: AppColors.black,
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(width: 10.w),
  //                                 Image.asset(
  //                                   AppEraAssets.bed,
  //                                   width: 55.w,
  //                                   height: 55.w,
  //                                 ),
  //                                 EraText(
  //                                   text: '${listing.beds}',
  //                                   fontSize: EraTheme.paragraph - 1.sp,
  //                                   fontWeight: FontWeight.w500,
  //                                   color: AppColors.black,
  //                                 ),
  //                                 SizedBox(width: 10.w),
  //                                 Image.asset(
  //                                   AppEraAssets.tub,
  //                                   width: 55.w,
  //                                   height: 55.w,
  //                                 ),
  //                                 EraText(
  //                                   text: '${listing.baths}',
  //                                   fontSize: EraTheme.paragraph - 1.sp,
  //                                   fontWeight: FontWeight.w500,
  //                                   color: AppColors.black,
  //                                 ),
  //                                 SizedBox(width: 10.w),
  //                                 Image.asset(
  //                                   AppEraAssets.car,
  //                                   width: 55.w,
  //                                   height: 55.w,
  //                                 ),
  //                                 EraText(
  //                                   text: '${listing.cars}',
  //                                   fontSize: EraTheme.paragraph - 1.sp,
  //                                   fontWeight: FontWeight.w500,
  //                                   color: AppColors.black,
  //                                 ),
  //                               ],
  //                             ),
  //                             SizedBox(
  //                               height: 5.h,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 14.w),
  //                               child: EraText(
  //                                 text: 'Description:',
  //                                 fontSize: EraTheme.header - 8.sp,
  //                                 color: AppColors.black,
  //                                 fontWeight: FontWeight.w600,
  //                                 lineHeight: 1,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 2.h,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 14.w),
  //                               child: Text(
  //                                 listing.description == ""
  //                                     ? "No description."
  //                                     : listing.description!,
  //                                 style: TextStyle(
  //                                   fontSize: EraTheme.paragraph - 4.sp,
  //                                   fontWeight: FontWeight.w500,
  //                                   color: AppColors.black,
  //                                 ),
  //                                 maxLines: 5,
  //                                 overflow: TextOverflow.ellipsis,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 5.h,
  //                             ),
  //                             Padding(
  //                               padding: EdgeInsets.symmetric(horizontal: 14.w),
  //                               child: EraText(
  //                                 text: NumberFormat.currency(
  //                                         locale: 'en_PH', symbol: 'PHP ')
  //                                     .format(
  //                                   listing.price.toString() == ""
  //                                       ? 0
  //                                       : listing.price,
  //                                 ),
  //                                 color: AppColors.blue,
  //                                 fontSize: EraTheme.header,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                             SizedBox(
  //                               height: 15.h,
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 );
  //               }

  //               print('Number of children: ${children.length}');

  //               return Row(
  //                 children: children,
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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
                  // Adjust this ratio as needed
                ),
                itemCount: randomIndex.length,
                itemBuilder: (context, index) {
                  var docIndex = randomIndex[index];
                  var user =
                      EraUser.fromJSON(snapshot.data!.docs[docIndex].data());
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
                              ref: listing.photos?.first != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos?.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                              width: Get.width, // Adjust image width
                              height: 300.h, // Adjust image height
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
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
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: EraText(
                              text: listing.type!,
                              fontSize: EraTheme.header - 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                AppEraAssets.area,
                                width: 35.w,
                                height: 35.w,
                              ),
                              EraText(
                                text: '${listing.area} sqm',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              Image.asset(
                                AppEraAssets.bed,
                                width: 35.w,
                                height: 35.w,
                              ),
                              EraText(
                                text: '${listing.beds}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: EraText(
                              text: NumberFormat.currency(
                                locale: 'en_PH',
                                symbol: 'PHP ',
                              ).format(listing.price.toString() == ""
                                  ? 0
                                  : listing.price),
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

  Widget _featuredNews() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AddListings.textBuild('UPLOAD FEATURED LISTINGS', 22.sp,
                FontWeight.w600, AppColors.kRedColor),
            Obx(() => AddListings.textBuild('${controller.images.length}/2',
                22.sp, FontWeight.w600, Colors.black)),
          ],
        ),
        SizedBox(height: 10.h),
        // textBuild('Uploads', 20.sp, FontWeight.w500, AppColors.black),
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
                onPressed: () {
                  controller.getImageGallery();
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
          if (controller.images.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: SizedBox(
                width: 300.w,
                child: Image.asset(
                  AppEraAssets.uploadphoto,
                ),
              ),
            );
          } else {
            return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.h,
                ),
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(controller.images[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                });
          }
        }),

        SizedBox(height: 5.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: EraText(
              text: 'Photo must be at least 300px X 300px',
              fontSize: 15.sp,
              color: AppColors.hint),
        ),
      ],
    );
  }
}
