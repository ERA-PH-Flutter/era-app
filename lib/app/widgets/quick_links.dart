import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart' as a;
import 'package:eraphilippines/presentation/website/listings/controllers/buyweb_binding.dart';
import 'package:eraphilippines/presentation/website/listings/controllers/listings_web_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import '../../presentation/global.dart';
import '../../presentation/website/listings/controllers/listings_web_controller.dart';
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
          fontSize: EraTheme.h1,
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
        ListingsWebBinding().dependencies();
        ListingsWebController s =  Get.find<ListingsWebController>();
        s.listingsWebState.value = ListingsWebState.loading;
        var listings = (await FirebaseFirestore.instance
                .collection('listings')
                .where(target ?? 'category', isEqualTo: type)
                .get())
            .docs;
        var data = listings.map((listing) {
          return listing.data();
        }).toList();


        s.loadData(data.map((e)=>Listing.fromJSON(e)).toList());
        s.searchQuery.value = "search";
        // a.selectedIndex.value = 2;
        // Get.find<a.HomsController>().onNavbarItemSelected(2);
        Get.toNamed('/search');
      },
      child: Column(
        children: [
          Container(
            //  color: AppColors.black,
            height: 220.h,
            width: 200.w,
            decoration: BoxDecoration(
                // color: AppColors.black,
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                    //  fit: BoxFit.co,
                    image: CachedNetworkImageProvider(
                        await CloudStorage().getFileDirect(docRef: icon)))),
          ),
        ],
      ),
    );
  }
}
