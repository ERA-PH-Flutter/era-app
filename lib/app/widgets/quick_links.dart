import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../presentation/agent/listings/listingproperties/pages/findproperties.dart';
import '../../presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import '../../presentation/global.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import 'app_text_listing.dart';
import 'navigation/customenavigationbar.dart';

class QuickLinks extends StatelessWidget {
  String? origin;
  QuickLinks({super.key, this.origin});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextListing(
        text: 'Quick Links',
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      SizedBox(height: 10.h),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(
                CloudStorage().imageLoaderProvider(
                  borderRadius: BorderRadius.circular(10.r),
                  ref: AppEraAssets.agricultural,
                ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'Agricultural')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Agricultural']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(
                CloudStorage().imageLoaderProvider(
                  borderRadius: BorderRadius.circular(10.r),
                  ref: AppEraAssets.apartment,
                ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'Apartment')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(
                CloudStorage().imageLoaderProvider(
                  borderRadius: BorderRadius.circular(10.r),
                  ref: AppEraAssets.commercial,
                ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('type', isEqualTo: 'Commercial')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Commercial']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(
                CloudStorage().imageLoaderProvider(
                  borderRadius: BorderRadius.circular(10.r),
                  ref: AppEraAssets.condo,
                ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('type', isEqualTo: 'Condominium')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(
                CloudStorage().imageLoaderProvider(
                  borderRadius: BorderRadius.circular(10.r),
                  ref: AppEraAssets.factory,
                ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('type', isEqualTo: 'Factory')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(
                CloudStorage().imageLoaderProvider(
                  borderRadius: BorderRadius.circular(10.r),
                  ref: AppEraAssets.farm,
                ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('type', isEqualTo: 'Farm')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.hotel,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'Hotel')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.housenlot,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'House and Lot')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.house1,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'House')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.lot,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'Lot')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.industrial,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: 'Industrial Lot')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.office,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Office')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.parkingLot,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Parking Lot')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.residential,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Resort')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.townhouse,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Townhouse')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.warehouse,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Warehouse')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.penthouse,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Penthouse')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.beachHouse,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Beach House')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.loft,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Loft')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.bedspace,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Bedspace')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.room,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Room')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.memorial,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Memorial')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.coworking,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Coworking Space')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(CloudStorage().imageLoaderProvider(
              borderRadius: BorderRadius.circular(10.r),
              ref: AppEraAssets.studio,
            ), () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Studio')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),
                  binding: SearchResultBinding(),
                  arguments: [data, 'All Apartment']);
            }),
            SizedBox(width: 15.w),
          ],
        ),
      ),
      SizedBox(height: 10.h),
    ]);
  }
}
