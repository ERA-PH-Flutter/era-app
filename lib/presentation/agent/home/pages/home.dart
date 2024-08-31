import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/widgets/app_divider.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/company/company_grid.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/app/widgets/listings/properties_widgets.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/findproperties.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
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
            height: 320.h, //height: (Get.height - 100.h) / 2,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider(
                      controller: controller.innerController,
                      items: controller.images.map((imagePath) {
                        return CustomImage(
                          url: imagePath,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlayInterval: Duration(milliseconds: 3000),
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
        SizedBox(
          height: 10.h,
        ),

        /// Search Engine Box
        Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidth, vertical: 26.h),
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
                                    toggleable: true,
                                    fillColor: WidgetStateProperty.all(
                                        AppColors.white.withOpacity(0.6)),
                                    value: 1,
                                    groupValue: controller.isForSale.value,
                                    onChanged: (value) {
                                      controller.isForSale.value = value ?? 0;
                                    }),
                              ),
                              EraText(
                                  text: 'BUY',
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
                                    toggleable: true,
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
                    SizedBox(height: 10.h),
                    Container(
                      width: Get.width,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          openFilterDialog();
                        },
                        label: EraText(
                          text: 'Filters',
                          color: AppColors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        icon: Icon(
                          Icons.filter_alt,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SearchWidget.build(() async {
                      var data;
                      var searchQuery = "";
                      if (controller.isForSale.value == 1) {
                        data = await Database().getForSaleListing();
                        searchQuery = "All For Sale Listings";
                      } else if (controller.isForSale.value == 2) {
                        data = await Database().getForRentListing();
                        searchQuery = "All For Rent Listings";
                      } else if (controller.aiSearchController.text == "") {
                        data = await Database().searchListing(
                            location: controller.locationController.text,
                            price: controller.priceController.text,
                            property: controller.propertyController.text);
                        if(controller.locationController.text != ""){
                          searchQuery += "Location: ${controller.locationController.text}";
                        }else if(controller.propertyController.text != ""){
                          searchQuery += "Property Type: ${controller.locationController.text}";
                        }else if(controller.priceController.text != ""){
                          searchQuery += "With price less than: ${controller.priceController.text}";
                        }
                      } else {
                        data =
                            await AI(query: controller.aiSearchController.text)
                                .search();
                        searchQuery = controller.aiSearchController.text;
                      }
                      selectedIndex.value = 2;
                      print("search results: " + searchQuery);
                      Get.toNamed("/searchresult",
                          arguments: [data, searchQuery]);
                    }),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  child: TextListing(
                    text: 'QUICK SEARCH',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor,
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FindProperties.quickSearchIcon(AppEraAssets.condo,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('type', isEqualTo: 'Condominium')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Condominium']);
                        }),
                        SizedBox(width: 15.w),
                        FindProperties.quickSearchIcon(AppEraAssets.condotel,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('type', isEqualTo: 'Condotel')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Condotel']);
                        }),
                        SizedBox(width: 15.w),
                        FindProperties.quickSearchIcon(AppEraAssets.commercial,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('type', isEqualTo: 'Commercial')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Commercial']);
                        }),
                        SizedBox(width: 15.w),
                        FindProperties.quickSearchIcon(AppEraAssets.apartment,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('sub_category', isEqualTo: 'Apartment')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Apartments']);
                        }),
                        SizedBox(width: 15.w),
                        FindProperties.quickSearchIcon(AppEraAssets.house1,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('sub_category', isEqualTo: 'House')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Houses']);
                        }),
                        SizedBox(width: 15.w),
                        FindProperties.quickSearchIcon(AppEraAssets.land,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('sub_category', isEqualTo: 'Lot')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Lands']);
                        }),
                        SizedBox(width: 15.w),
                        FindProperties.quickSearchIcon(AppEraAssets.waterfront,
                            () async {
                          var listings = (await FirebaseFirestore.instance
                                  .collection('listings')
                                  .where('view', isEqualTo: 'Water Front')
                                  .get())
                              .docs;
                          var data = listings.map((listing) {
                            return listing.data();
                          }).toList();
                          Get.toNamed("/searchresult",
                              arguments: [data, 'All Water Fronts']);
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 30.h,
        ),

        /// Listings
        PropertiesWidgets(listingsModels: controller.listingImages),
        SizedBox(
          height: 10.h,
        ),

        /// Projects
        GestureDetector(
          onTap: () => Get.toNamed("/haraya"),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: EraTheme.paddingWidth, vertical: 15.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextListing.projectTitle(
                        EraTheme.header, FontWeight.w600, AppColors.blue),
                    TextListing.projectSubtitle(
                        EraTheme.subHeader, FontWeight.w500, AppColors.black),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextListing(
                        text: 'Featured Projects'.toUpperCase(),
                        fontSize: EraTheme.header - 4.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kRedColor),
                    SizedBox(height: 20.h),
                    ProjectDivider(
                        textImage: ProjectTextImageModels.textImageModels),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              CarouselSliderWidget(images: CarouselModels.carouselModels),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              Button(
                text: 'LEARN MORE',
                onTap: () {
                  Get.toNamed("/haraya");
                },
                bgColor: AppColors.kRedColor,
                height: EraTheme.buttonHeightSmall,
                width: Get.width - 220.w,
                borderRadius: BorderRadius.circular(30),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        ),

        AppDivider(
          button: true,
        ),
        SizedBox(
          height: 10.h,
        ),
        SizedBox(
          height: 20.h,
        ),
        SizedBox(
          height: 10.h,
        ),

        /// Featured Listings
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextListing(
                  margin: EdgeInsets.symmetric(horizontal: 0.h),
                  text: 'FEATURED LISTING',
                  fontSize: EraTheme.header,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue),
              SizedBox(
                height: 25.h,
              ),
              // ListingProperties(listingModels: controller.listings),
              ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.listings.length,
                itemBuilder: (context, index) {
                  Listing listing = controller.listings[index];
                  return GestureDetector(
                    onTap: ()async{
                      await Database().addViews(listing.id);
                      Get.toNamed('/propertyInfo', arguments: listing);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
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
                            child: CachedNetworkImage(
                              imageUrl: listing.photos != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos!.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: 300.h,
                            ),
                          ),
                          SizedBox(
                            height: 17.h,
                          ),
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
                          SizedBox(
                            height: 5.h,
                          ),
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
                              SizedBox(width: 10.w),
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
                              SizedBox(width: 10.w),
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
                              SizedBox(width: 10.w),
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
                          SizedBox(
                            height: 5.h,
                          ),
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
                          // FutureBuilder(
                          //     future: EraUser().getById(listing.by),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.hasData) {
                          //         var user1 = snapshot.data;
                          //         return Padding(
                          //           padding:
                          //               EdgeInsets.symmetric(horizontal: 14.w),
                          //           child: ListedBy(
                          //               image: user1!.image ??
                          //                   AppStrings.noUserImageWhite,
                          //               agentFirstName:
                          //                   user1.firstname ?? "No Name",
                          //               agentType: user1.role ?? "Agent",
                          //               agentLastName: user1.lastname ?? ""),
                          //         );
                          //       } else {
                          //         return Center(
                          //           child: CircularProgressIndicator(),
                          //         );
                          //       }
                          //     }),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),

        /// All About News
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextListing(
                  text: 'COMPANY NEWS',
                  fontSize: EraTheme.header,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue),
              TextListing(
                text: 'Latest News and Events from ERA Philippines',
                fontSize: EraTheme.subHeader,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              SizedBox(
                height: 20.h,
              ),
              CompanyGrid(companymodels: controller.news),
              SizedBox(
                height: 10.h,
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
                height: 50.h,
              ),
            ],
          ),
        ),
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
