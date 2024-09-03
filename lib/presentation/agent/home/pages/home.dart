import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/app/widgets/listings/properties_widgets.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/projectmain.dart';
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
import '../../listings/listingproperties/pages/findproperties.dart';
import '../../listings/searchresult/controllers/searchresult_controller.dart';
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
    final SearchResultController searchController =
        Get.put(SearchResultController());
    final ProjectsController projectsController = Get.put(ProjectsController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(
          height: 20.h,
        ),

        /// Search Engine Box
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              EraText(
                text: "Property searches made simple.",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              SizedBox(
                height: 10.h,
              ),
              BoxWidget.build(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    if (!searchController.showFullSearch.value)
                      AppTextField(
                          onPressed: () {},
                          controller: controller.aiSearchController,
                          hint: 'Use AI Search',
                          svgIcon: AppEraAssets.ai3,
                          bgColor: AppColors.white,
                          isSuffix: true,
                          obscureText: false,
                          suffixIcons: AppEraAssets.send,
                          onSuffixTap: () async {
                            var data;
                            var searchQuery = "";
                            if (controller.isForSale.value == 1) {
                              data = await Database().getForSaleListing();
                              searchQuery = "All For Sale Listings";
                            } else if (controller.isForSale.value == 2) {
                              data = await Database().getForRentListing();
                              searchQuery = "All For Rent Listings";
                            } else if (controller.aiSearchController.text ==
                                "") {
                              data = await Database().searchListing(
                                  location: controller.locationController.text,
                                  price: controller.priceController.text,
                                  property: controller.propertyController.text);
                              if (controller.locationController.text != "") {
                                searchQuery +=
                                    "Location: ${controller.locationController.text}";
                              } else if (controller.propertyController.text !=
                                  "") {
                                searchQuery +=
                                    "Property Type: ${controller.locationController.text}";
                              } else if (controller.priceController.text !=
                                  "") {
                                searchQuery +=
                                    "With price less than: ${controller.priceController.text}";
                              }
                            } else {
                              data = await AI(
                                      query: controller.aiSearchController.text)
                                  .search();
                              searchQuery = controller.aiSearchController.text;
                            }
                            selectedIndex.value = 2;
                            Get.toNamed("/searchresult",
                                arguments: [data, searchQuery]);
                          }),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        searchController.expanded.value =
                            !searchController.expanded.value;
                        searchController.showFullSearch.value =
                            !searchController.showFullSearch.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Obx(() => EraText(
                              text: searchController.expanded.value
                                  ? "Back to AI Search"
                                  : "Filtered Search",
                              fontSize: 15.sp,
                              textDecoration: TextDecoration.underline,
                            )),
                      ),
                    ),
                    SizedBox(height: 0.h),
                    Obx(() {
                      if (searchController.showFullSearch.value) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10.h),
                                //notesfornikkoo
                                //Location new changes the location has the same properties with the searchresult,projectmain, home, and find agents
                                //proterty type, price range, >> home, projectmain, searchresult
                                AddListings.dropDownAddlistings(
                                    color: AppColors.white,
                                    selectedItem:
                                        projectsController.selectedLocation,
                                    Types: projectsController.location,
                                    onChanged: (value) => projectsController
                                        .selectedLocation.value = value!,
                                    name: 'Location',
                                    hintText: 'Select Location'),

                                AddListings.dropDownAddlistings(
                                    color: AppColors.white,
                                    selectedItem: searchController
                                        .selectedPropertyTypeSearch,
                                    Types: searchController.propertyTypeSearch,
                                    onChanged: (value) => searchController
                                        .selectedPropertyTypeSearch
                                        .value = value!,
                                    name: 'Property Type',
                                    hintText: 'Select Property Type'),
                                AddListings.dropDownAddlistings(
                                    color: AppColors.white,
                                    selectedItem:
                                        searchController.selectedPriceSearch,
                                    Types: searchController.priceSearch,
                                    onChanged: (value) => searchController
                                        .selectedPriceSearch.value = value!,
                                    name: 'Price Range',
                                    hintText: 'Select Price Range'),
                                //ai search

                                Obx(
                                  () => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Transform.scale(
                                            scale: 1.9,
                                            child: Radio(
                                                toggleable: true,
                                                fillColor:
                                                    WidgetStateProperty.all(
                                                        AppColors.white
                                                            .withOpacity(0.6)),
                                                value: 1,
                                                groupValue:
                                                    controller.isForSale.value,
                                                onChanged: (value) {
                                                  controller.isForSale.value =
                                                      value ?? 0;
                                                }),
                                          ),
                                          EraText(
                                              text: 'BUY',
                                              color: AppColors.white
                                                  .withOpacity(0.6),
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
                                                fillColor:
                                                    WidgetStateProperty.all(
                                                        AppColors.white
                                                            .withOpacity(0.6)),
                                                value: 2,
                                                groupValue:
                                                    controller.isForSale.value,
                                                onChanged: (value) {
                                                  controller.isForSale.value =
                                                      value ?? 0;
                                                }),
                                          ),
                                          EraText(
                                              text: 'RENT',
                                              color: AppColors.white
                                                  .withOpacity(0.6),
                                              fontSize: 15.0.sp,
                                              fontWeight: FontWeight.w500),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                SizedBox(
                                  width: Get.width,
                                  child: ElevatedButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor: WidgetStateProperty.all(
                                          AppColors.white),
                                      shape: WidgetStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      openFilterDialog();
                                    },
                                    label: EraText(
                                      text: 'More Filters',
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
                                  } else if (controller
                                          .aiSearchController.text ==
                                      "") {
                                    data = await Database().searchListing(
                                        location:
                                            controller.locationController.text,
                                        price: controller.priceController.text,
                                        property:
                                            controller.propertyController.text);
                                    if (controller.locationController.text !=
                                        "") {
                                      searchQuery +=
                                          "Location: ${controller.locationController.text}";
                                    } else if (controller
                                            .propertyController.text !=
                                        "") {
                                      searchQuery +=
                                          "Property Type: ${controller.locationController.text}";
                                    } else if (controller
                                            .priceController.text !=
                                        "") {
                                      searchQuery +=
                                          "With price less than: ${controller.priceController.text}";
                                    }
                                  } else {
                                    data = await AI(
                                            query: controller
                                                .aiSearchController.text)
                                        .search();
                                    searchQuery =
                                        controller.aiSearchController.text;
                                  }
                                  selectedIndex.value = 2;
                                  Get.toNamed("/searchresult",
                                      arguments: [data, searchQuery]);
                                }),
                                SizedBox(height: 10.h),

                                SizedBox(height: 10.h),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                TextListing(
                  text: 'Quick Links',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.kRedColor,
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.apartment,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('sub_category',
                                    isEqualTo: 'Agricultural')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Apartments']);
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
                                .where('type', isEqualTo: 'Factory')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Condotel']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.condotel,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('type', isEqualTo: 'Farm')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Condotel']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.house1,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('sub_category', isEqualTo: 'Hotel')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Houses']);
                      }),
                      SizedBox(width: 15.w),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.house1,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('sub_category',
                                    isEqualTo: 'House and Lot')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Houses']);
                      }),
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
                      FindProperties.quickSearchIcon(AppEraAssets.land,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('sub_category',
                                    isEqualTo: 'Industrial Lot')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Lands']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.office,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('view', isEqualTo: 'Office')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Water Fronts']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.waterfront,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('view', isEqualTo: 'Parking Slot')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Water Fronts']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.residential,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('view', isEqualTo: 'Residential')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Water Fronts']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.residential,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('view', isEqualTo: 'Resort')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Water Fronts']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.townhouse,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('view', isEqualTo: 'Townhouse')
                                .get())
                            .docs;
                        var data = listings.map((listing) {
                          return listing.data();
                        }).toList();
                        Get.toNamed("/searchresult",
                            arguments: [data, 'All Water Fronts']);
                      }),
                      SizedBox(width: 15.w),
                      FindProperties.quickSearchIcon(AppEraAssets.warehouse,
                          () async {
                        var listings = (await FirebaseFirestore.instance
                                .collection('listings')
                                .where('view', isEqualTo: 'Warehouse')
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
                SizedBox(height: 10.h),
              ]),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),

        /// Listings
        PropertiesWidgets(listingsModels: controller.listingImages),

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
                    // TextListing.projectTitle(
                    //     EraTheme.header, FontWeight.w600, AppColors.blue),

                    ProjectMain.featuredProject(),
                    // EraText(
                    //     text: 'Featured Projects',
                    //     fontSize: EraTheme.header,
                    //     fontWeight: FontWeight.bold,
                    //     color: AppColors.kRedColor),
                    // EraText(
                    //     text:
                    //         'Dive into the future of real estate with our spotlight on upcoming innovative projects.',
                    //     fontSize: EraTheme.small - 2.sp,
                    //     fontWeight: FontWeight.w600,
                    //     color: AppColors.hint),
                    TextListing(
                        text: '',
                        fontSize: EraTheme.header - 4.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kRedColor),

                    ProjectDivider(
                        textImage: ProjectTextImageModels.textImageModels),

                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                decoration: BoxDecoration(color: AppColors.carouselBgColor),
                child: Image.asset(
                  "assets/images/slider_haraya-project.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(
                height: 30.h,
              ),
              viewOtherProjects(
                  text: 'View other projects',
                  onTap: () => Get.toNamed("/project-main")),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
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
              SizedBox(
                height: 15.h,
              ),
              EraText(
                textAlign: TextAlign.center,
                text: 'You REAL ESTATE agency partner for life!',
                color: AppColors.kRedColor,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 5.h,
              ),
              Divider(
                color: AppColors.black,
                thickness: 2.1,
                indent: 25.w,
                endIndent: 25.w,
              ),
              SizedBox(
                height: 5.h,
              ),
              EraText(
                textAlign: TextAlign.center,
                text:
                    'Whether you\'re buying, selling, or investing, we offer unparalleled expertise and commitment to turn your real estate goals into reality.',
                color: AppColors.black.withOpacity(0.7),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 15.h,
              ),
              EraText(
                textAlign: TextAlign.center,
                text:
                    'Trust ERA Philippines to guide you through every step of your journey with propessionalism and care.',
                color: AppColors.black.withOpacity(0.7),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
        // AppDivider(
        //   button: true,
        // ),
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
              // ListingProperties(listingModels: controller.listings),
              ListView.builder(
                physics: const ScrollPhysics(),
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
              viewOtherProjects(
                text: 'View more listings',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          color: AppColors.white.withOpacity(0.9),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EraText(
                        text: 'Company News',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.kRedColor),
                    EraText(
                        text: 'See all',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blue),
                  ],
                ),
                SizedBox(
                  height: 5.h,
                ),
                EraText(
                  text:
                      'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.hint,
                ),
                SizedBox(
                  height: 10.h,
                ),
                GridView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisExtent: 520.w, //410
                  ),
                  itemCount: controller.news.length,
                  itemBuilder: (context, i) => Stack(
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
                        bottom: 10.h,
                        left: -3.w,
                        right: -3.w,
                        top: 200.h,
                        child: Card(
                          color: AppColors.white,
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: EraTheme.paddingWidthSmall + 15.w,
                                vertical: 15.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                EraText(
                                  text: controller.news[i].title,
                                  fontSize: EraTheme.paragraph + 5.sp,
                                  color: AppColors.kRedColor,
                                  fontWeight: FontWeight.bold,
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                EraText(
                                  text: controller.news[i].description,
                                  fontSize: EraTheme.paragraph,
                                  color: AppColors.hint,
                                  fontWeight: FontWeight.w600,
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
              ],
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),

        /// All About News
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                  text: 'Join Us Today',
                  fontSize: 30.sp,
                  color: AppColors.kRedColor,
                  fontWeight: FontWeight.bold),
              EraText(
                  text:
                      'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.',
                  fontSize: 15.sp,
                  color: AppColors.hint,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Button(
          text: 'BECOME AN ERA AGENT',
          onTap: () {
            Get.toNamed("/aboutus");
          },
          bgColor: AppColors.kRedColor,
          height: EraTheme.buttonHeightSmall,
          width: Get.width - 220.w,
          borderRadius: BorderRadius.circular(30),
        ),
        SizedBox(
          height: 40.h,
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
