import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../app/services/ai_search.dart';
import '../../../../../app/services/firebase_database.dart';
import '../../../../../app/widgets/listings/listedBy_widget.dart';
import '../../../../../repository/listing.dart';
import '../../../../../repository/user.dart';
import '../../listingproperties/pages/findproperties.dart';
import '../controllers/searchresult_controller.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    // final FilterController controllers = Get.put(FilterController());
    final ProjectsController projectsController = Get.put(ProjectsController());
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxWidget.build(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Obx(() {
                      if (!controller.showFullSearch.value) {
                        return AppTextField(
                            onPressed: () {},
                            controller: controller.aiSearchController,
                            hint: 'Use AI Search',
                            svgIcon: AppEraAssets.ai3,
                            bgColor: AppColors.white,
                            isSuffix: true,
                            obscureText: false,
                            suffixIcons: AppEraAssets.send);
                      }
                      return Container();
                    }),

                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        controller.expanded.value = !controller.expanded.value;
                        controller.showFullSearch.value =
                            !controller.showFullSearch.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Obx(() => EraText(
                              text: controller.expanded.value
                                  ? "Back to AI Search"
                                  : "Filtered Search",
                              fontSize: 15.sp,
                              textDecoration: TextDecoration.underline,
                            )),
                      ),
                    ),

                    //FILTERED SEARCH
                    Obx(() {
                      if (controller.showFullSearch.value) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10.h),
                                //Location same with projects
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
                                    selectedItem:
                                        controller.selectedPropertyTypeSearch,
                                    Types: controller.propertyTypeSearch,
                                    onChanged: (value) => controller
                                        .selectedPropertyTypeSearch
                                        .value = value!,
                                    name: 'Property Type',
                                    hintText: 'Select Property Type'),
                                AddListings.dropDownAddlistings(
                                    color: AppColors.white,
                                    selectedItem:
                                        controller.selectedPriceSearch,
                                    Types: controller.priceSearch,
                                    onChanged: (value) => controller
                                        .selectedPriceSearch.value = value!,
                                    name: 'Price Range',
                                    hintText: 'Select Price Range'),

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
                                  controller.searchResultState.value =
                                      SearchResultState.loading;
                                  controller.searchQuery.value = searchQuery;
                                  controller.expanded.value = false;
                                  controller.showFullSearch.value = false;
                                  controller.loadData(data);
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
                if (controller.showFullSearch.value == false) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextListing(
                          text: 'QUICK LINKS',
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.apartment, () async {
                                var listings = (await FirebaseFirestore.instance
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.factory, () async {
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
                              FindProperties.quickSearchIcon(AppEraAssets.farm,
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
                              FindProperties.quickSearchIcon(AppEraAssets.hotel,
                                  () async {
                                var listings = (await FirebaseFirestore.instance
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
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.house1, () async {
                                var listings = (await FirebaseFirestore.instance
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.industrial, () async {
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.office, () async {
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.parkingLot, () async {
                                var listings = (await FirebaseFirestore.instance
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.townhouse, () async {
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
                              FindProperties.quickSearchIcon(
                                  AppEraAssets.warehouse, () async {
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
                      ]);
                }
                return Container();
              }),
              Obx(() => switch (controller.searchResultState.value) {
                    SearchResultState.loading => Center(
                        child: CircularProgressIndicator(),
                      ),
                    SearchResultState.loaded => _loaded(),
                    SearchResultState.empty => _empty(),
                    SearchResultState.searching => _searching(),
                    SearchResultState.error => _error(),
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _searching() {
    return Container();
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          EraText(
            text: 'SEARCH RESULTS FOR',
            fontSize: 23.sp,
            color: AppColors.blue,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10.h),
          EraText(
            text: '“${controller.searchQuery}”',
            fontSize: 22.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 10.h),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              //print(controller.data[index]);
              if (controller.data[index] != null) {
                Listing listing = Listing.fromJSON(controller.data[index]);
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
                              height: 300.h,
                              width: Get.width,
                              ref: listing.photos != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos!.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                            )),
                        SizedBox(
                          height: 17.h,
                        ),
                        Container(
                          width: Get.width,
                          height: 30.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            textOverflow: TextOverflow.ellipsis,
                            text:
                                listing.name! == "" ? "No Name" : listing.name!,
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
                        FutureBuilder(
                            future: EraUser().getById(listing.by),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var user1 = snapshot.data;
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: ListedBy(
                                      image: user1!.image ??
                                          AppStrings.noUserImageWhite,
                                      agentFirstName:
                                          user1.firstname ?? "No Name",
                                      agentType: user1.role ?? "Agent",
                                      agentLastName: user1.lastname ?? ""),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  _error() {
    return EraText(
      text: "ERROR",
      color: Colors.black,
    );
  }

  _empty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 200.h,
          child: Center(
            child: EraText(
              text: "No results found! for ${Get.arguments[1]}",
              color: Colors.black,
              fontSize: 20.sp,
            ),
          ),
        )
      ],
    );
  }
}
