import 'dart:ui';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';

import 'package:eraphilippines/presentation/website/home/controllers/home_web_controller.dart';

import 'package:eraphilippines/repository/listing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../app/constants/screens.dart';
import '../../../../app/constants/strings.dart';
import '../../../../app/services/firebase_storage.dart';

import '../../../../app/widgets/filteredsearch_box.dart';
import '../../../global.dart';
import '../../landingpage/controller/homs_controller.dart' as a;
import '../../landingpage/controller/homs_controller.dart';
import '../../listings/controllers/listings_web_controller.dart';

List<String> imagePaths = [
  // 'assets/images/image.png',
  // 'assets/images/image2.png',
  // 'assets/images/image5.png',
  // 'assets/images/image6.png',
  // 'assets/images/image7.png',
];

class HomeWeb extends GetView<HomeWebController> {
  const HomeWeb({super.key});

  @override
  Widget build(BuildContext context) {
    HomeWebController controller = Get.put(HomeWebController());
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: SafeArea(
        child: Obx(() => switch (controller.homelandingState.value) {
              HomeWebState.loading => _loading(),
              HomeWebState.loaded => _loaded(),
              HomeWebState.error => _error(),
              HomeWebState.empty => _empty()
            }),
      ),
    );
  }

  Future<bool> _onWillPop() {
    Get.back();
    return Future.value(false);
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              width: Get.width,
              child: Stack(
                children: [
                  Positioned(
                    child: CarouselSlider(
                        controller: controller.innerController,
                        items: controller.bannersImages.map((imagePath) {
                          return CloudStorage().imageLoaderProvider(
                              reference: imagePath,
                              fit: BoxFit.cover,
                              width: Get.width);
                        }).toList(),
                        options: CarouselOptions(
                          scrollDirection: Axis.horizontal,
                          //   scrollPhysics: PageScrollPhysics(),
                          autoPlayInterval: Duration(seconds: 7),
                          autoPlay: true,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) =>
                              controller.carouselIndex.value = index,
                        )),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 10.w,
                    child: Container(
                      height: 240.h,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          // controller.prevImage();
                          controller.innerController.previousPage();
                        },
                        child: Image.asset(
                          AppEraAssets.next,
                          height: 50.h,
                          width: 50.w,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 10.w,
                    child: Container(
                      height: 240.h,
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          //    controller.nextImage(controller.images.length);
                          controller.innerController.nextPage();
                        },
                        child: Image.asset(
                          AppEraAssets.prev,
                          height: 50.h,
                          width: 50.w,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: Get.width,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              print(
                                  ' controller.carouselIndex.value ${controller.carouselIndex.value}');
                              print(
                                  ' controller.carouselIndex.value ${controller.carouselIndex.value.runtimeType}');
                              print(
                                  ' controller.images.length ${controller.images.length}');
                              return AnimatedSmoothIndicator(
                                activeIndex: controller.carouselIndex.value,
                                count: imagePaths.length,
                                effect: JumpingDotEffect(
                                  spacing: 25,
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  activeDotColor: AppColors.black,
                                  dotColor: AppColors.hint,
                                ),
                              );
                            })
                          ]),
                    ),
                  ),
                ],
              )),
          sb20(),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: EraText(
                    text: "Property searches made simple.",
                    fontSize: EraTheme.h1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kRedColor,
                  ),
                ),
                sb10(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidthAdmin * 5),
                  child: FilteredSearchBox(),
                ),
                sb15(),
                controller.quickLinks!,
                sb30(),
                _uploadPreviewPhotos(),
                sb50(),
                featuredProject(),
              ],
            ),
          ),

          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                mainAxisExtent: Get.height - 395.h,
              ),
              itemCount: controller.projects.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: controller.projects[index],
                    ),
                  ),
                );
              },
            ),
          ),

          // Column(children: controller.projects),

          Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sb70(),
                viewOtherProjects(
                    text: 'View other projects',
                    onTap: () {
                      // HomsController homsController =
                      //     Get.find<HomsController>();
                      // a.selectedIndex.value = 1;
                      // //  Get.lazyPut(() => NewsWebController());
                      // //await Get.find<NewsWebController>().getNews();
                      // homsController.onNavbarItemSelected(1);

                      Get.toNamed('/projects');
                    }),
                sb20(),
                EraText(
                  textAlign: TextAlign.center,
                  text: 'Connect worlds, build dreams with ERA Philippines;',
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.h1,
                  fontWeight: FontWeight.bold,
                ),
                sb10(),
                EraText(
                  textAlign: TextAlign.center,
                  text: 'Your REAL ESTATE agency partner for life!',
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.h2,
                  fontWeight: FontWeight.bold,
                ),
                sb20(),
                Divider(
                  color: AppColors.black,
                  thickness: 2.1,
                  // indent: 25.w,
                  // endIndent: 25.w,
                ),
                sb20(),
                EraText(
                  textAlign: TextAlign.center,
                  text:
                      'Whether you\'re buying, selling, or investing, we offer unparalleled expertise and commitment to turn your real estate goals into reality.',
                  color: AppColors.black.withOpacity(0.7),
                  fontSize: EraTheme.subHeaderWeb,
                  fontWeight: FontWeight.bold,
                ),
                sb15(),
                EraText(
                  textAlign: TextAlign.center,
                  text:
                      'Trust ERA Philippines to guide you through every step of your journey with professionalism and care.',
                  color: AppColors.black.withOpacity(0.7),
                  fontSize: EraTheme.subHeaderWeb,
                  fontWeight: FontWeight.bold,
                ),
                sb70(),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),

          Container(
            color: Colors.grey.withOpacity(0.3),
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb40(),
                EraText(
                  textAlign: TextAlign.start,
                  text: 'FEATURED LISTINGS',
                  fontSize: EraTheme.h1,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kRedColor,
                ),
                sb40(),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: Get.height - 300.h,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.listings.length,
                  itemBuilder: (context, index) {
                    Listing listing = controller.listings[index];
                    return GestureDetector(
                      onTap: () async {
                        // listingArgument = listing;
                        // a.selectedIndex.value = 10;
                        // Get.find<HomsController>().onNavbarItemSelected(10);
                        Get.delete<ListingsWebController>();
                        Get.toNamed('/view-listing/${listing.id}');
                      },
                      child: Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CloudStorage().imageLoader(
                                reference: listing.photos?.isNotEmpty == true
                                    ? listing.photos!.first
                                    : AppStrings.noUserImageWhite,
                                width: Get.width,
                                height: 340.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 14.w, right: 14.w, top: 10.h),
                                  child: EraText(
                                    text: listing.name?.isNotEmpty == true
                                        ? listing.name!
                                        : "No Name",
                                    fontSize: EraTheme.h3,
                                    color: AppColors.kRedColor,
                                    fontWeight: FontWeight.bold,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: EraText(
                                    text: listing.type ?? "Unknown Type",
                                    fontSize: EraTheme.h5,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildFeatureIcon(
                                      icon: AppEraAssets.area,
                                      label: '${listing.floorArea} sqm',
                                    ),
                                    SizedBox(width: 2.w),
                                    buildFeatureIcon(
                                      icon: AppEraAssets.bed,
                                      label: '${listing.beds}',
                                    ),
                                    SizedBox(width: 2.w),
                                    buildFeatureIcon(
                                      icon: AppEraAssets.tub,
                                      label: '${listing.baths}',
                                    ),
                                    SizedBox(width: 2.w),
                                    buildFeatureIcon(
                                      icon: AppEraAssets.car,
                                      label: '${listing.cars}',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                // Description
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: EraText(
                                    text: 'Description:',
                                    fontSize: EraTheme.h6,
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: EraText(
                                    text:
                                        listing.description?.isNotEmpty == true
                                            ? listing.description!
                                            : "No description available.",
                                    fontSize: EraTheme.caption,
                                    color: AppColors.black,
                                    maxLines: 3,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                sb20(),
                                GestureDetector(
                                  onTap: () {
                                    listingArgument = listing;
                                    a.selectedIndex.value = 10;
                                    Get.find<HomsController>()
                                        .onNavbarItemSelected(10);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        EraText(
                                          text: 'READ MORE',
                                          fontSize: EraTheme.h5,
                                          color: AppColors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        sbw10(),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: AppColors.blue,
                                          size: EraTheme.h6,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                sb60(),
                GestureDetector(
                  onTap: () {},
                  child: viewOtherProjects(
                      text: 'View other listings',
                      onTap: () {
                        // a.selectedIndex.value = 2;
                        // Get.find<HomsController>().onNavbarItemSelected(2);
                        Get.toNamed('/search');
                      }),
                ),
                sb10(),
              ],
            ),
          ),

          // same widget as the oone in the my dashboard wfaill change it later
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EraText(
                        text: 'COMPANY NEWS',
                        fontSize: EraTheme.h1,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kRedColor),
                    GestureDetector(
                      onTap: () async {
                        // HomsController homsController =
                        //     Get.find<HomsController>();
                        // a.selectedIndex.value = 8;
                        // //  Get.lazyPut(() => NewsWebController());
                        // //await Get.find<NewsWebController>().getNews();
                        // homsController.onNavbarItemSelected(8);
                        Get.toNamed('/news');
                      },
                      child: EraText(
                          text: 'See all',
                          fontSize: EraTheme.h4,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blue),
                    ),
                  ],
                ),
                EraText(
                  text:
                      'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
                  fontSize: EraTheme.h3,
                  fontWeight: FontWeight.w500,
                  color: AppColors.hint,
                ),
                SizedBox(
                  height: 50.h,
                ),
                SizedBox(
                  width: Get.width,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: Get.height - 400.h,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: controller.news.length,
                    itemBuilder: (context, i) => GestureDetector(
                      onTap: () {
                        // HomsController homsController =
                        //     Get.find<HomsController>();
                        // a.selectedIndex.value = 9;
                        // homsController.onNavbarItemSelected(9);
                        // newsArgument = {
                        //   "title": controller.news[i].title,
                        //   "image": controller.news[i].image,
                        //   "description": controller.news[i].description,
                        // };
                        Get.toNamed('/view-news/${controller.news[i].id}');
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CloudStorage().imageLoader(
                                reference: controller.news[i].image,
                                height: 350.h,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                            ),
                            sb40(),
                            EraText(
                              text: controller.news[i].title.toUpperCase(),
                              fontSize: EraTheme.h3,
                              color: AppColors.kRedColor,
                              fontWeight: FontWeight.bold,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            SizedBox(height: 8.h),
                            EraText(
                              text: controller.news[i].description,
                              fontSize: EraTheme.h6,
                              color: AppColors.hint,
                              fontWeight: FontWeight.w500,
                              maxLines: 3,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 16.h),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                    '/view-news/${controller.news[i].id}');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  EraText(
                                    text: 'READ MORE',
                                    fontSize: EraTheme.h5,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  sbw10(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.blue,
                                    size: EraTheme.h6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Center(
          //   child: Container(
          //     width: Get.width / 1.8,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(20.r)),
          //       color: AppColors.blue2,
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.center,
          //       children: [
          //         SizedBox(
          //           height: 20.h,
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(left: 10.w, right: 10.w),
          //           child: EraText(
          //               textAlign: TextAlign.start,
          //               text: 'Join Us Today',
          //               fontSize: 30.sp,
          //               color: AppColors.white,
          //               fontWeight: FontWeight.bold),
          //         ),
          //         Padding(
          //           padding: EdgeInsets.only(left: 10.w, right: 10.w),
          //           child: EraText(
          //               textAlign: TextAlign.center,
          //               text:
          //                   'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.',
          //               fontSize: 15.sp,
          //               color: AppColors.white,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         sb30(),
          //         Button(
          //           text: 'BECOME AN ERA AGENT',
          //           onTap: () {
          //             // Get.to(JoinEra());
          //           },
          //           bgColor: AppColors.kRedColor,
          //           width: 250.w,
          //           borderRadius: BorderRadius.circular(30),
          //         ),
          //         sb40(),
          //       ],
          //     ),
          //   ),
          // ),
          // sb40(),
        ],
      ),
    );
  }

  _error() {
    return EraText(
      text: 'errorrrr',
      color: AppColors.black,
    );
  }

  _empty() {
    return Container(
      child: EraText(
        text: 'No content available',
        color: AppColors.black,
      ),
    );
  }

  Widget viewOtherProjects({
    required String? text,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EraText(
                text: text!,
                fontSize: EraTheme.h2,
                color: AppColors.hint,
                fontWeight: FontWeight.w600,
              ),
              Icon(
                Icons.arrow_right,
                color: AppColors.hint,
                size: 30.sp,
              ),
            ],
          ),
          Divider(
            thickness: 2.1,
            color: AppColors.hint,
          ),
        ],
      ),
    );
  }

  static Widget buildFeatureIcon(
      {required String icon, required String label}) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 55.w,
          height: 55.h,
        ),
        EraText(
          text: label,
          fontSize: EraTheme.sbodyText,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ],
    );
  }
}

Widget _uploadPreviewPhotos() {
  HomeWebController controller = Get.put(HomeWebController());
  var listingsImages = controller.listingImages;
  return StaggeredGridView.countBuilder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    crossAxisCount: 3,
    itemCount: listingsImages.length,
    crossAxisSpacing: 16.0,
    mainAxisSpacing: 16.0,
    itemBuilder: (context, index) {
      return _buildUploadPhoto(
        text: listingsImages[index].label,
        image: listingsImages[index].image,
      );
    },
    staggeredTileBuilder: (index) {
      if (index == 2) {
        return StaggeredTile.count(1, 2);
      } else {
        return StaggeredTile.count(1, 1);
      }
    },
  );
}

Widget _buildUploadPhoto({required String text, required String image}) {
  return GestureDetector(
    onTap: () async {
      List eraTranslated = [
        ['type', 'pre_selling'],
        ['type', 'pre_selling'],
        ['type', 'pre_selling'],
        ['type', 'pre_selling'],
        ['type', 'pre_selling']
      ];
      List eraList = [
        'PRE-SELLING',
        'RESIDENTIAL',
        'RENTAL',
        'COMMERCIAL',
        'AUCTION'
      ];
      List types = ['sub-type', 'type', 'type', 'type', 'type'];
      var listings = (await FirebaseFirestore.instance
              .collection('listings')
              .where('type', isEqualTo: text.toLowerCase())
              .get())
          .docs;
      var data = listings.map((listing) {
        return listing.data();
      }).toList();
      // a.selectedIndex.value = 2;
      // Get.find<a.HomsController>().onIndexChanged();
      // Get.find<a.HomsController>().update();
      Get.lazyPut(() => ListingsWebController());
      var s = Get.find<ListingsWebController>();
      s.listingsWebState(ListingsWebState.loading);
      s.searchQuery.value = text;
      await s.loadData(data.map((e) => Listing.fromJSON(e)).toList());
      if (data.isEmpty) {
        Get.find<ListingsWebController>()
            .listingsWebState(ListingsWebState.empty);
      } else {
        Get.find<ListingsWebController>()
            .listingsWebState(ListingsWebState.loaded);
      }
      Get.toNamed('/search');
    },
    child: CloudStorage().imageLoaderProvider(
      reference: image,
      borderRadius: BorderRadius.only(topRight: Radius.circular(20.0)),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            left: 10,
            child: EraText(
              text: text,
              fontSize: EraTheme.headerWeb - 5.sp,
              // fontWeight: FontWeight.bold,
              style: TextStyle(
                  fontSize: EraTheme.headerWeb - 5.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    )
                  ]),
            ),
          )
        ],
      ),
    ),
  );
}

Widget featuredProject() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      EraText(
          text: 'FEATURED PROJECTS',
          textAlign: TextAlign.start,
          fontSize: EraTheme.h1,
          fontWeight: FontWeight.bold,
          color: AppColors.kRedColor),
      EraText(
        text:
            'Dive into the future of real estate with our spotlight on upcoming innovative projects.',
        fontSize: EraTheme.h2,
        fontWeight: FontWeight.w500,
        color: AppColors.hint,
        textAlign: TextAlign.start,
      ),
    ],
  );
}

class UploadPhotoData {
  final text, image;

  UploadPhotoData({
    required this.text,
    required this.image,
  });
}
