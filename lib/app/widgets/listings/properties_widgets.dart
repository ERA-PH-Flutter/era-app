import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/listings/properties_card.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../presentation/global.dart';

class PropertiesWidgets extends StatelessWidget {
  final List listingsModels;

  const PropertiesWidgets({super.key, required this.listingsModels});
  void _onTap(BuildContext context, String label) async {
    var searchQuery = "";
    if (label == "PRE-SELLING") {
      searchQuery = "Pre-Selling Listings";
    } else if (label == "RESIDENTIAL") {
      searchQuery = "Residential Listings";
    } else if (label == "COMMERCIAL") {
      searchQuery = "Commercial Listings";
    } else if (label == "RENTAL") {
      searchQuery = "Rental Listings";
    } else if (label == "AUCTION") {
      searchQuery = "Auction Listings";
    }

    selectedIndex.value = 2;
    currentRoute = '/searchresult';
    pageViewController.animateToPage(
      2,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );

    Get.find<SearchResultController>().searchListingType(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        itemCount: listingsModels.length,
        crossAxisCount: 2,
        mainAxisSpacing: 15.w,
        crossAxisSpacing: 15.w,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTap(context, listingsModels[index].label),
            child: PropertiesCard(
              image: listingsModels[index].image,
              label: listingsModels[index].label,
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return listingsModels[index].label == "AUCTION"
              ? StaggeredTile.count(2, 1)
              : StaggeredTile.count(1, 1);
        },
      ),
    );
  }
}
