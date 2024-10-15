import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/services/local_storage.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_binding.dart';
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
    [AppEraAssets.agricultural,"type","Agricultural"],
    [AppEraAssets.apartment,"sub_category","Apartment"],
    [AppEraAssets.commercial,"type","Commercial"],
    [AppEraAssets.condo,"type","Condominium"],
    [AppEraAssets.factory,"sub_category","Factory"],
    [AppEraAssets.farm,"sub_category","Farm"],
    [AppEraAssets.hotel,"sub_category","Hotel"],
    [AppEraAssets.housenlot,"type","House and Lot"],
    [AppEraAssets.house1,"sub_category","House"],
    [AppEraAssets.lot,"sub_category","Lot"],
    [AppEraAssets.industrial,"type","Industrial"],
    [AppEraAssets.office,"sub_category","Office"],
    [AppEraAssets.parkingLot,"sub_category","Parking Lot"],
    [AppEraAssets.residential,"type","Residential"],
    [AppEraAssets.townhouse,"type","Townhouse"],
    [AppEraAssets.resort,"sub_category","Resort"],
    [AppEraAssets.warehouse,"sub_category","Warehouse"],
    [AppEraAssets.penthouse,"sub_category","Penthouse"],
    [AppEraAssets.beachHouse,"sub_category","Beach House"],
    [AppEraAssets.loft,"sub_category","Loft"],
    [AppEraAssets.bedspace,"sub_category","BedSpace"],
    [AppEraAssets.room,"sub_category","Room"],
    [AppEraAssets.memorial,"sub_category","Memorial"],
    [AppEraAssets.coworking,"sub_category","Coworking"],
    [AppEraAssets.studio,"sub_category","Studio"],
  ];

  initialize() async {
    List<Widget> items = [];-
    // for(int index = 0;index < categories.length;index++){
    //   items.add(await quickSearchIcon(categories[index][0], categories[index][1], categories[index][2]));
    // }
    var ql = Get.find<LocalStorageService>().images!['quick_links'];
    for(int index = 0;index < ql.length ;index++){
      items.add(await quickSearchIcon(ql[index], categories[index][1], categories[index][2]));
    }
    if(ql.length != categories.length){
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            children: items,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  download()async{
    List paths = [];
    for (var category in categories) {
      paths.add(await CloudStorage().downloadAndSave(
        docRef: category[0],
        folder: 'quick_links'
      ));
    }
    return paths;
  }

  Future<Widget> quickSearchIcon(String icon,target,type)async{
    return GestureDetector(
      onTap: ()async{
        var listings = (await FirebaseFirestore.instance
            .collection('listings').where(target ?? 'category', isEqualTo: type).get()).docs;
        var data = listings.map((listing) {
          return listing.data();
        }).toList();
        selectedIndex.value = 2;
        pageViewController = PageController(initialPage: 2);
        currentRoute = '/searchresult';
        Get.offAll(BaseScaffold(),
            binding: HomeBinding(),
            arguments: [data, 'All $type listings!']);
      },
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 100.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: FileImage(
                  File(icon)
                )
              )
            ),
          ),
        ],
      ),
    );
  }
}