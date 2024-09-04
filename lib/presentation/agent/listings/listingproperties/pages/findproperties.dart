import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:eraphilippines/repository/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/services/ai_search.dart';
import '../../../../../app/services/firebase_database.dart';
import '../controllers/listing_controller.dart';

class FindProperties extends GetView<ListingController> {
  const FindProperties({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectsController projectsController = Get.put(ProjectsController());
    SearchResultController searchController = Get.put(SearchResultController());
    return BaseScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth),
            child: Column(
              children: [
                BoxWidget.build(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Obx(() {
                        if (!searchController.showFullSearch.value) {
                          return AppTextField(
                            onPressed: () {},
                            controller: controller.aiSearchController,
                            hint: 'AI Search',
                            svgIcon: AppEraAssets.ai,
                            bgColor: AppColors.white,
                            isSuffix: true,
                            obscureText: false,
                            suffixIcons: AppEraAssets.send,
                          );
                        }
                        return Container();
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
                                  //Location
                                  // AppTextField(
                                  //   controller: controller.locationController,
                                  //   hint: 'Location',
                                  //   svgIcon: AppEraAssets.marker,
                                  //   bgColor: AppColors.white,
                                  // ),
                                  // //property type
                                  // SizedBox(height: 20.h),
                                  // AppTextField(
                                  //   controller: controller.propertyController,
                                  //   hint: 'Property Type',
                                  //   svgIcon: AppEraAssets.house,
                                  //   bgColor: AppColors.white,
                                  // ),
                                  // //price range
                                  // SizedBox(height: 20.h),
                                  // AppTextField(
                                  //   controller: controller.priceController,
                                  //   hint: 'Price Range',
                                  //   svgIcon: AppEraAssets.money,
                                  //   bgColor: AppColors.white,
                                  // ),
                                  //ai search

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
                                      Types:
                                          searchController.propertyTypeSearch,
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
                                                  fillColor: WidgetStateProperty
                                                      .all(AppColors.white
                                                          .withOpacity(0.6)),
                                                  value: 1,
                                                  groupValue: controller
                                                      .isForSale.value,
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
                                                  fillColor: WidgetStateProperty
                                                      .all(AppColors.white
                                                          .withOpacity(0.6)),
                                                  value: 2,
                                                  groupValue: controller
                                                      .isForSale.value,
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
                                        backgroundColor:
                                            WidgetStateProperty.all(
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
                                      data =
                                          await Database().getForSaleListing();
                                      searchQuery = "All For Sale Listings";
                                    } else if (controller.isForSale.value ==
                                        2) {
                                      data =
                                          await Database().getForRentListing();
                                      searchQuery = "All For Rent Listings";
                                    } else if (controller
                                            .aiSearchController.text ==
                                        "") {
                                      data = await Database().searchListing(
                                          location: controller
                                              .locationController.text,
                                          price:
                                              controller.priceController.text,
                                          property: controller
                                              .propertyController.text);
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
                                    searchController.searchResultState.value =
                                        SearchResultState.loading;
                                    searchController.searchQuery.value =
                                        searchQuery;
                                    searchController.expanded.value = false;
                                    searchController.showFullSearch.value =
                                        false;
                                    searchController.loadData(data);
                                  }),
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
                SizedBox(height: 10.h),
                Obx(() {
                  if (searchController.showFullSearch.value == false) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextListing(
                            text: 'QUICK LINKS',
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.agricultural, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.apartment, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('sub_category',
                                              isEqualTo: 'Apartment')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Apartments']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.commercial, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type',
                                              isEqualTo: 'Commercial')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Commercial']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.condo, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('type',
                                              isEqualTo: 'Condominium')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Condominium']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.factory, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.farm, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.hotel, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('sub_category',
                                              isEqualTo: 'Hotel')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Houses']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.housenlot, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.house1, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('sub_category',
                                              isEqualTo: 'House')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Houses']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(AppEraAssets.lot,
                                    () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('sub_category',
                                              isEqualTo: 'Lot')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Lands']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.industrial, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.office, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.parkingLot, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
                                          .collection('listings')
                                          .where('view',
                                              isEqualTo: 'Parking Slot')
                                          .get())
                                      .docs;
                                  var data = listings.map((listing) {
                                    return listing.data();
                                  }).toList();
                                  Get.toNamed("/searchresult",
                                      arguments: [data, 'All Water Fronts']);
                                }),
                                SizedBox(width: 15.w),
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.residential, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.townhouse, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                                FindProperties.quickSearchIcon(
                                    AppEraAssets.warehouse, () async {
                                  var listings = (await FirebaseFirestore
                                          .instance
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
                        ]);
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget quickSearchIcon(String icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 80.h,
            width: 80.w,
          ),
        ],
      ),
    );
  }
}
