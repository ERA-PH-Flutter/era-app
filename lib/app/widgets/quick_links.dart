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
  double? fontSize;
  QuickLinks({super.key, this.origin, this.fontSize});
  var categories = [
    [AppEraAssets.agricultural, "type", "Agricultural"],
    [AppEraAssets.apartment, "sub_category", "Apertment"],
    [AppEraAssets.commercial, "type", "Commercial"],
    [AppEraAssets.condo, "type", "Condominium"],
    [AppEraAssets.factory, "sub_category", "Factory"],
    [AppEraAssets.farm, "sub_category", "Farm"],
    [AppEraAssets.hotel, "sub_category", "Hotel"],
    [AppEraAssets.housenlot, "type", "House and Lot"],
    [AppEraAssets.house1, "sub_category", "House"],
    [AppEraAssets.lot, "sub_category", "Lot"],
    [AppEraAssets.industrial, "type", "Industrial"],
    [AppEraAssets.office, "sub_category", "Office"],
    [AppEraAssets.parkingLot, "sub_category", "Parking Lot"],
    [AppEraAssets.residential, "type", "Residential"],
    [AppEraAssets.townhouse, "type", "Townhouse"],
    [AppEraAssets.resort, "sub_category", "Resort"],
    [AppEraAssets.warehouse, "sub_category", "Warehouse"],
    [AppEraAssets.penthouse, "sub_category", "Penthouse"],
    [AppEraAssets.beachHouse, "sub_category", "Beach House"],
    [AppEraAssets.loft, "sub_category", "Loft"],
    [AppEraAssets.bedspace, "sub_category", "Bedspace"],
    [AppEraAssets.room, "sub_category", "Room"],
    [AppEraAssets.memorial, "sub_category", "Memorial"],
    [AppEraAssets.coworking, "sub_category", "Coworking"],
    [AppEraAssets.studio, "sub_category", "Studio"],
  ];
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      TextListing(
        text: 'Quick Links',
        fontSize: fontSize ?? 18.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      SizedBox(height: 10.h),
      SizedBox(
        height: 100.h,
        width: Get.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return quickSearchIcon(categories[index][0], categories[index][1],
                categories[index][2]);
          },
        ),
      ),
      SizedBox(height: 10.h),
    ]);
  }

  Widget quickSearchIcon(String icon, target, type) {
    return GestureDetector(
      onTap: () async {
        var listings = (await FirebaseFirestore.instance
                .collection('listings')
                .where(target ?? 'category', isEqualTo: type)
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
            arguments: [data, 'All $type listings!']);
      },
      child: Container(
        child: Column(
          children: [
            CloudStorage().imageLoaderProvider(
              height: 100.h,
              width: 100.h,
              borderRadius: BorderRadius.circular(10.r),
              ref: icon,
            ),
          ],
        ),
      ),
    );
  }
}
