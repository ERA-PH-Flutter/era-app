import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/assets.dart';

import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';

import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/company/companynews_page.dart';

import 'package:eraphilippines/app/widgets/listings/properties_widgets.dart';

import 'package:eraphilippines/app/widgets/project_views.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/project_view_binding.dart';
import 'package:eraphilippines/presentation/agent/forms/contacts/pages/join_era.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/project_view.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/projectmain.dart';
import 'package:eraphilippines/repository/listing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/constants/strings.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/filteredsearch_box.dart';

import '../controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //todo for later
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Obx(() => switch (controller.homeState.value) {
                HomeState.loading => _loading(),
                HomeState.loaded => _loaded(),
                HomeState.error => _error(),
              }),
        ),
      ),
    );
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 320.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider(
                      controller: controller.innerController,
                      items: controller.images.map((image) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: image),
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 7),
                        autoPlay: true,
                        viewportFraction: 1,
                        aspectRatio: 1.2,
                        onPageChanged: (index, reason) =>
                            controller.carouselIndex.value = index,
                      )),
                ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => AnimatedSmoothIndicator(
                                activeIndex: controller.carouselIndex.value,
                                count: controller.images.length,
                                effect: JumpingDotEffect(
                                  spacing: 25,
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  activeDotColor: AppColors.black,
                                  dotColor: AppColors.hint,
                                ),
                              )),
                        ]),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  child: Container(
                    height: 320.h,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.prevImage();
                        controller.innerController.previousPage();
                      },
                      child: Image.asset(
                        AppEraAssets.next,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  child: Container(
                    height: 320.h,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.nextImage(controller.images.length);
                        controller.innerController.nextPage();
                      },
                      child: Image.asset(
                        AppEraAssets.prev,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        sb20(),

        /// Search Engine Box
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            children: [
              sb5(),
              EraText(
                text: "Property searches made simple.",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              sb10(),
              FilteredSearchBox(),
              sb15(),
              controller.quickLinks!,
            ],
          ),
        ),
        sb30(),
        //    ProjectsList(),
        PropertiesWidgets(listingsModels: controller.listingImages),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidth, vertical: 15.h),
          child: ProjectMain.featuredProject(),
        ),

        /// Listings
        // Obx(() {
        //   if (projectController.projectsListState.value ==
        //       ProjectsListState.loading) {
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   }
        //   if (projectController.projectsListState.value ==
        //       ProjectsListState.loaded) {
        //     return Container(
        //       height: Get.height,
        //       child: ListView.builder(
        //         shrinkWrap: true,
        //         physics: NeverScrollableScrollPhysics(),
        //         itemCount: settings!.featuredProject!.length,
        //         itemBuilder: (context, index) {
        //           return GestureDetector(
        //             onTap: () {
        //               Get.to(ProjectView(),
        //                   binding: ProjectViewBinding(),
        //                   arguments: settings!.featuredProject![index]);
        //             },
        //             child: Container(
        //               height: Get.height,
        //               child: Column(
        //                 children: [
        //                   Column(
        //                     children: ProjectViews(
        //                             project: settings!.featuredProject![index])
        //                         .HomebuildPreview(),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     );
        //   } else {
        //     return Center(child: Text('No projects available'));
        //   }
        // }),
        Builder(builder: (context) {
          List<Widget> projects = [];
          for (int i = 0; i < controller.projects.length; i++) {
            projects.add(GestureDetector(
              onTap: () {
                Get.to(ProjectView(),
                    binding: ProjectViewBinding(),
                    arguments: controller.projects[i]);
              },
              child: Wrap(
                children: [
                  Column(
                    children: ProjectViews(project: controller.projects[i])
                        .HomebuildPreview(),
                  ),
                ],
              ),
            ));
          }
          return Column(children: projects);
        }),
        // Wrap(
        //   children: [
        //     ListView.builder(
        //         shrinkWrap: true,
        //         itemCount: controller.projects.length,
        //         itemBuilder: (context, index) {
        //           return GestureDetector(
        //             onTap: () {
        //               Get.to(ProjectView(),
        //                   binding: ProjectViewBinding(),
        //                   arguments: controller.projects[index]);
        //             },
        //             child: Wrap(
        //               children: [
        //                 Column(
        //                   children:
        //                       ProjectViews(project: controller.projects[index])
        //                           .HomebuildPreview(),
        //                 ),
        //               ],
        //             ),
        //           );
        //         }),
        //   ],
        // ),
        // sb90(),

        /// Projects
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     sb20(),
        //     ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
        //     sb20(),
        //     CarouselSliderWidget(images: CarouselModels.carouselModels),
        //     sb40(),
        //     Button(
        //       text: 'LEARN MORE',
        //       onTap: () {
        //         Get.toNamed("/haraya");
        //       },
        //       bgColor: AppColors.kRedColor,
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     //laya
        //     sb90(),
        //     ProjectDivider(
        //       textImage: ProjectTextImageModels.textImageModels2,
        //     ),
        //     sb20(),
        //     //temporary carousel
        //     CarouselSliderWidget(
        //         images: CarouselModels.layaCarouselImages,
        //         color: AppColors.carouselBgColor),
        //     sb40(),
        //     Button(
        //       text: 'LEARN MORE',
        //       onTap: () {
        //         Get.toNamed("/laya");
        //       },
        //       bgColor: AppColors.kRedColor,
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     //laya

        //     sb90(),
        //     ProjectDivider(
        //       textImage: ProjectTextImageModels.textImageModels3,
        //     ),
        //     sb20(),
        //     CarouselSliderWidget(
        //         images: CarouselModels.aureliaCarouselImages,
        //         color: AppColors.carouselBgColor),
        //     sb40(),
        //     Button(
        //       text: 'LEARN MORE',
        //       onTap: () {
        //         Get.toNamed("/aurelia");
        //       },
        //       bgColor: AppColors.kRedColor,
        //       borderRadius: BorderRadius.circular(30),
        //     ),
        //     sb10(),
        //   ],
        // ),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       sb30(),
        //       viewOtherProjects(
        //           text: 'View other projects',
        //           onTap: () => Get.toNamed("/project-main")),
        //       sb20(),
        //     ],
        //   ),
        // ),
        // sb30(),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            children: [
              EraText(
                textAlign: TextAlign.center,
                text: 'Connect worlds, build dreams with ERA Philippines;',
                color: AppColors.kRedColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              sb15(),
              EraText(
                textAlign: TextAlign.center,
                text: 'Your REAL ESTATE agency partner for life!',
                color: AppColors.kRedColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              sb5(),
              Divider(
                color: AppColors.black,
                thickness: 2.1,
                indent: 25.w,
                endIndent: 25.w,
              ),
              sb5(),
              EraText(
                textAlign: TextAlign.center,
                text:
                    'Whether you\'re buying, selling, or investing, we offer unparalleled expertise and commitment to turn your real estate goals into reality.',
                color: AppColors.black.withOpacity(0.7),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              sb15(),
              EraText(
                textAlign: TextAlign.center,
                text:
                    'Trust ERA Philippines to guide you through every step of your journey with professionalism and care.',
                color: AppColors.black.withOpacity(0.7),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),

        sb40(),

        /// Featured Listings
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ListingProperties(listingModels: controller.listings),
              SizedBox(
                height: Get.height / 1.4,
                width: Get.width,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: controller.listings.length,
                    itemBuilder: (context, index) {
                      Listing listing = controller.listings[index];
                      return GestureDetector(
                        onTap: () async {
                          await Database().addViews(listing.id);
                          Get.toNamed('/propertyInfo', arguments: listing);
                        },
                        child: Container(
                          width: 378.w,
                          margin: EdgeInsets.only(bottom: 16.h, right: 10.w),
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: const [
                                BoxShadow(
                                    offset: Offset(0, 0),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    color: Colors.black12)
                              ]),
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
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: EraText(
                                  textOverflow: TextOverflow.ellipsis,
                                  text: listing.name! == ""
                                      ? "No Name"
                                      : listing.name!,
                                  fontSize: EraTheme.header - 5.sp,
                                  color: AppColors.kRedColor,
                                  fontWeight: FontWeight.bold,
                                  lineHeight: 2,
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
                  ),
                ),
              ),
              //TODO: Nikko
              GestureDetector(
                onTap: () {
                  // Get.offAll(BaseScaffold(),
                  //     binding: SearchResultBinding(),
                  //     routeName: ("/searchresult"));
                  Get.toNamed(
                    "/searchresult",
                  );
                  // Get.deleteAll();

                  // );
                },
                child: viewOtherProjects(
                  text: 'View more listings',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        // same widget as the oone in the my dashboard will change it later
        Container(
          color: AppColors.hint.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EraText(
                      text: 'Company News',
                      fontSize: EraTheme.header + 5.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kRedColor),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/companynews");
                    },
                    child: EraText(
                        text: 'See all',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              EraText(
                text:
                    'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
                fontSize: EraTheme.subHeader - 2.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.hint,
              ),
              SizedBox(
                height: 50.h,
              ),
              SizedBox(
                height: 550.h,
                width: Get.width,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 390.w, //410
                  ),
                  itemCount: controller.news.length,
                  itemBuilder: (context, i) => GestureDetector(
                    onTap: () {
                      Get.offAll(() => CompanyNewsPage(
                          title: controller.news[i].title,
                          image: controller.news[i].image,
                          description: controller.news[i].description));
                    },
                    child: Container(
                      width: Get.width,
                      margin: EdgeInsets.only(bottom: 15.h, right: 12.w),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CloudStorage().imageLoader(
                                ref: controller.news[i].image,
                                height: 250.h,
                              ),
                              Spacer(),
                            ],
                          ),
                          Positioned(
                            bottom: 15.h,
                            left: -4.w,
                            right: -4.w,
                            top: 200.h,
                            child: Card(
                              color: AppColors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        EraTheme.paddingWidthSmall + 15.w,
                                    vertical: 15.h),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    EraText(
                                      text: controller.news[i].title,
                                      fontSize: EraTheme.paragraph + 5.sp,
                                      color: AppColors.kRedColor,
                                      fontWeight: FontWeight.bold,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                    EraText(
                                      text: controller.news[i].description,
                                      fontSize: EraTheme.paragraph - 2.sp,
                                      color: AppColors.hint,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 5,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                  ],
                                ),
                              ),
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
        SizedBox(
          height: 20.h,
        ),

        /// join us today
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
              color: AppColors.blue2,
            ),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      EraText(
                          text: 'Join Us Today',
                          fontSize: 30.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold),
                      EraText(
                          text:
                              'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.',
                          fontSize: 15.sp,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500),
                    ],
                  ),
                ),
                sb30(),
                Button(
                  text: 'BECOME AN ERA AGENT',
                  onTap: () {
                    Get.to(JoinEra());
                  },
                  bgColor: AppColors.kRedColor,
                  width: Get.width - 195.w,
                  borderRadius: BorderRadius.circular(30),
                ),
                sb40(),
              ],
            ),
          ),
        ),
        sb40(),
      ],
    );
  }

  _loading() {
    return Screens.loading();
  }

  _error() {
    return Screens.error();
  }

  Widget viewOtherProjects({required String? text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EraText(
                  text: text!,
                  fontSize: 15.sp,
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
            Positioned(
              top: 30.h,
              bottom: 0,
              left: 120.w,
              right: 150.w,
              child: Divider(
                thickness: 2,
                color: AppColors.hint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
