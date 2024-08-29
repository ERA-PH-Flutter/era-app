import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/findproperties.dart';
import 'package:eraphilippines/presentation/agent/searchresult/controllers/searchresult_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../../repository/listing.dart';
import '../controllers/searchresult_controller.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterController controllers = Get.put(FilterController());

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
                    AppTextField(
                      onChange: (value) {
                        print('clicked');
                        controller.showFullSearch.value =
                            controller.aiSearchController.text.isNotEmpty;
                      },
                      onPressed: () {},
                      controller: controller.aiSearchController,
                      hint: 'AI Search',
                      svgIcon: AppEraAssets.send,
                      bgColor: AppColors.white,
                    ),
                    SizedBox(height: 10.h),
                    Obx(() {
                      if (controller.showFullSearch.value) {
                        return Column(
                          children: [
                            Column(
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
                                                  controller.isForSale.value =
                                                      value ?? 0;
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
                                                fillColor: WidgetStateProperty.all(
                                                    AppColors.white.withOpacity(0.6)),
                                                value: 2,
                                                groupValue: controller.isForSale.value,
                                                onChanged: (value) {
                                                  controller.isForSale.value =
                                                      value ?? 0;
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
                                  if (controller.aiSearchController.text == "") {
                                    data = await Database().searchListing(
                                        location: controller.locationController.text,
                                        price: controller.priceController,
                                        type: controller.isForSale.value == 1
                                            ? "selling"
                                            : "rent",
                                        property: controller.propertyController.text);
                                  } else {
                                    data = await AI(
                                        query: controller.aiSearchController.text)
                                        .search();
                                  }
                                  Get.to(() => SearchResult(),
                                      binding: SearchResultBinding(),
                                      arguments: [
                                        data,
                                        controller.aiSearchController.text
                                      ]);
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
                if (controller.showFullSearch.value) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextListing(
                          text: 'QUICK RESEARCH',
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kRedColor,
                        ),
                        SizedBox(height: 10.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              FindProperties.quickSearchIcon(AppEraAssets.condo,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'condominium')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Condominium']);
                                  }),
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(AppEraAssets.condotel,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'condotel')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Condotel']);
                                  }),
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(AppEraAssets.commercial,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'commercial')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Commercial']);
                                  }),
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(AppEraAssets.apartment,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'apartment')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Apartments']);
                                  }),
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(AppEraAssets.house1,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'house')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Houses']);
                                  }),
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(AppEraAssets.land,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'land')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Lands']);
                                  }),
                              SizedBox(width: 15.w),
                              FindProperties.quickSearchIcon(AppEraAssets.waterfront,
                                      () async {
                                    var listings = (await FirebaseFirestore.instance
                                        .collection('listings')
                                        .where('type', isEqualTo: 'water front')
                                        .get())
                                        .docs;
                                    var data = listings.map((listing) {
                                      return listing.data();
                                    }).toList();
                                    Get.to(() => SearchResult(),
                                        binding: SearchResultBinding(),
                                        arguments: [data, 'All Water Fronts']);
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // SearchWidget.build(() async {
                        //   controller.searchResultState.value =
                        //       SearchResultState.loading;
                        //   var data;
                        //   if (controller.aiSearchController.text == "") {
                        //     data = await Database().searchListing(
                        //         location: controller.locationController.text,
                        //         price: controller.priceController,
                        //         type: controller.isForSale.value == 1
                        //             ? "selling"
                        //             : "rent",
                        //         property: controller.propertyController.text);
                        //   } else {
                        //     data =
                        //         await AI(query: controller.aiSearchController.text)
                        //             .search();
                        //   }
                        //   controller.searchQuery.value =
                        //       controller.aiSearchController.text;
                        //   controller.data.value = data ?? [];
                        //   controller.searchResultState.value =
                        //       SearchResultState.loaded;
                        // }),
                        //        SizedBox(height: 10.h),
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
              Listing listing = Listing.fromJSON(controller.data[index]);
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/propertyInfo', arguments: listing);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 21.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: listing.photos != null
                              ? (listing.photos!.isNotEmpty
                                  ? listing.photos!.first
                                  : AppStrings.noUserImageWhite)
                              : AppStrings.noUserImageWhite,
                          fit: BoxFit.cover,
                          width: Get.width,
                          height: 200.h,
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: EraText(
                          text: listing.type!,
                          fontSize: EraTheme.header - 3.sp,
                          color: AppColors.kRedColor,
                          fontWeight: FontWeight.bold,
                          lineHeight: 0.4,
                        ),
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
                                fontSize: EraTheme.paragraph,
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
                            fontSize: EraTheme.paragraph,
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
                            fontSize: EraTheme.paragraph,
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
                            fontSize: EraTheme.paragraph,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: EraText(
                          text: 'Description:',
                          fontSize: EraTheme.header - 5.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          listing.description!,
                          style: TextStyle(
                            fontSize: EraTheme.paragraph,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: EraText(
                          text: NumberFormat.currency(
                                  locale: 'en_PH', symbol: 'PHP ')
                              .format(
                            listing.price.toString() == "" ? 0 : listing.price,
                          ),
                          color: AppColors.blue,
                          fontSize: EraTheme.header,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //todo missy add listed by
                    ],
                  ),
                ),
              );

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
