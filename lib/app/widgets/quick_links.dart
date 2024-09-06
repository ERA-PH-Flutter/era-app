import 'package:cloud_firestore/cloud_firestore.dart';
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
  var controller;
  QuickLinks({super.key, this.origin, this.controller});

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
            FindProperties.quickSearchIcon(AppEraAssets.agricultural, () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('sub_category', isEqualTo: '')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
              // if(origin == null){
              //
              // }else{
              //   controller.data.value = data;
              //   controller.searchQuery.value = 'All Agricultural Listings';
              //   controller.loadData();
              // }
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.apartment, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.commercial, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.condo, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.factory, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.farm, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.hotel, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.housenlot, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.house1, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.lot, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.industrial, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.office, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.parkingLot, () async {
              var listings = (await FirebaseFirestore.instance
                      .collection('listings')
                      .where('view', isEqualTo: 'Parking Slot')
                      .get())
                  .docs;
              var data = listings.map((listing) {
                return listing.data();
              }).toList();
              selectedIndex.value = 2;
              pageViewController = PageController(initialPage: 2);
              currentRoute = '/searchresult';
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.residential, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.townhouse, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
            SizedBox(width: 15.w),
            FindProperties.quickSearchIcon(AppEraAssets.warehouse, () async {
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
              Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,'All Apartment']);
            }),
          ],
        ),
      ),
      SizedBox(height: 10.h),
    ]);
  }
}