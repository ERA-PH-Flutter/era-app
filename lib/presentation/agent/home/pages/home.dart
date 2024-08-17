import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/models/hero_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_divider.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/company/company_grid.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/listings/gridView_Listing.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/app/widgets/listings/properties_widgets.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../global.dart';
import '../../searchresult/controllers/searchresult_binding.dart';
import '../../searchresult/pages/searchresult.dart';
import '../controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
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
        /// Carousel
        SizedBox(
            height: 320.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider(
                      controller: controller.innerController,
                      items: settings!.banners != null
                          ? settings!.banners!.map((imagePath) {
                              return CustomImage(
                                url: imagePath,
                              );
                            }).toList()
                          : [],
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 2),
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

        /// Search Engine Box
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: BoxWidget.build(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                //Location
                AppTextField(
                  controller: controller.locationController,
                  hint: 'Location',
                  svgIcon: AppEraAssets.marker,
                  bgColor: AppColors.white,
                ),
                //property type
                SizedBox(height: 20.h),
                AppTextField(
                  controller: controller.propertyController,
                  hint: 'Property Type',
                  svgIcon: AppEraAssets.house,
                  bgColor: AppColors.white,
                ),
                //price range
                SizedBox(height: 20.h),
                AppTextField(
                  controller: controller.priceController,
                  hint: 'Price Range',
                  svgIcon: AppEraAssets.money,
                  bgColor: AppColors.white,
                ),
                //ai search
                SizedBox(height: 20.h),
                AppTextField(
                  controller: controller.aiSearchController,
                  hint: 'AI Search',
                  svgIcon: AppEraAssets.send,
                  bgColor: AppColors.white,
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.9,
                            child: Radio(
                                fillColor: WidgetStateProperty.all(
                                    AppColors.white.withOpacity(0.6)),
                                value: 1,
                                groupValue: controller.isForSale.value,
                                onChanged: (value) {
                                  controller.isForSale.value = value ?? 0;
                                }),
                          ),
                          EraText(
                              text: 'SELL',
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.9,
                            child: Radio(
                                fillColor: WidgetStateProperty.all(
                                    AppColors.white.withOpacity(0.6)),
                                value: 2,
                                groupValue: controller.isForSale.value,
                                onChanged: (value) {
                                  controller.isForSale.value = value ?? 0;
                                }),
                          ),
                          EraText(
                              text: 'RENT',
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),
                SearchWidget.build(() async {
                  var data;
                  if (controller.aiSearchController.text == "") {
                    data = await Database().searchListing(
                        location: controller.locationController.text,
                        price: controller.priceController,
                        type: controller.isForSale.value == 1
                            ? "selling"
                            : "rent",
                        property: controller.propertyController.text);
                  } else {
                    data = await AI(query: controller.aiSearchController.text)
                        .search();
                  }
                  Get.to(() => SearchResult(),
                      binding: SearchResultBinding(),
                      arguments: [data, controller.aiSearchController.text]);
                }),
              ],
            ),
          ),
        ),

        /// Listings
        PropertiesWidgets(listingsModels: PropertiesModels.listings),

        /// Projects
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextListing.projectTitle(24.sp, FontWeight.w600, AppColors.blue),
            TextListing.projectSubtitle(
                12.sp, FontWeight.w500, AppColors.black),
            SizedBox(
              height: 20.h,
            ),
            TextListing(
                margin: EdgeInsets.symmetric(horizontal: 40.0),
                text: 'Featured Projects',
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.kRedColor),
            SizedBox(height: 20.h),
            ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
            SizedBox(
              height: 20.h,
            ),
            CarouselSliderWidget(),
            SizedBox(
              height: 20.h,
            ),
            Button(
              text: 'VIEW PROJECTS',
              onTap: () {
                Get.toNamed("/project");
              },
              bgColor: AppColors.kRedColor,
              height: 40.h,
              borderRadius: BorderRadius.circular(30),
            ),
          ],
        ),
        SizedBox(height: 40.h),

        ///
        AppDivider(
          button: true,
        ),
        SizedBox(
          height: 20.h,
        ),

        /// Featured Listings
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextListing(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                text: 'FEATURED LISTING',
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blue),
            SizedBox(
              height: 10.h,
            ),
            ListingProperties(listingModels: RealEstateListing.listingsModels),
          ],
        ),

        /// All About News
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextListing(
                text: 'COMPANY NEWS',
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blue),
            SizedBox(
              height: 15.h,
            ),
            TextListing(
                text: 'Latest News and Events from ERA PH',
                fontSize: 15.h,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                lineHeight: 0.1),
            SizedBox(
              height: 20.h,
            ),
            CompanyGrid(companymodels: CompanyModels.companyNewsModels),
            SizedBox(
              height: 20.h,
            ),
            Button(
              text: 'MORE NEWS',
              fontSize: 25.sp,
              onTap: () {
                Get.toNamed("/companynews");
              },
              bgColor: AppColors.blue,
              height: 45.h,
              width: Get.width - 100.w,
              fontWeight: FontWeight.w500,
              borderRadius: BorderRadius.circular(10),
            ),
            SizedBox(
              height: 30.h,
            ),
          ],
        )
      ],
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _error() {
    return Container();
  }
}
