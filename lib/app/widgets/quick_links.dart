import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import '../../presentation/global.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../services/firebase_storage.dart';
import 'app_text_listing.dart';
import 'navigation/customenavigationbar.dart';

class QuickLinksModel {
  var categories = [
    [AppEraAssets.agricultural, "type", "Agricultural"],
    [AppEraAssets.apartment, "sub_category", "Apartment"],
    [AppEraAssets.commercial, "type", "Commercial"],
    [AppEraAssets.condo, "type", "Condominium"],
    [AppEraAssets.factory, "sub_category", "Factory"],
    [AppEraAssets.farm, "sub_category", "Farm"],
    [AppEraAssets.hotel, "sub_category", "Hotel"],
    [AppEraAssets.house1, "sub_category", "House"],
    [AppEraAssets.lot, "sub_category", "Lot"],
    [AppEraAssets.industrial, "type", "Industrial"],
    [AppEraAssets.office, "sub_category", "Office"],
    [AppEraAssets.parkingLot, "sub_category", "Parking Lot"],
    [AppEraAssets.resort, "sub_category", "Resort"],
    [AppEraAssets.beachHouse, "sub_category", "Beach House"],
    [AppEraAssets.school, "sub_category", "School"],
  ];

  initialize() async {
    List<Widget> items = [];
    for (int index = 0; index < categories.length; index++) {
      items.add(await quickSearchIcon(
          categories[index][0], categories[index][1], categories[index][2]));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextListing(
          text: 'Quick Links',
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: items,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Future<Widget> quickSearchIcon(String icon, target, type) async {
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
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: 150.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        await CloudStorage().getFileDirect(docRef: icon)))),
          ),
        ],
      ),
    );
  }
}
