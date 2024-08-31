import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/listings/properties_card.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/auction.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/commercial.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/pre_selling.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/rental.dart';
import 'package:eraphilippines/presentation/agent/listingproperties/pages/residential.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../services/firebase_database.dart';

class PropertiesWidgets extends StatelessWidget {
  final List listingsModels;

  const PropertiesWidgets({super.key, required this.listingsModels});
  void _onTap(BuildContext context, String label)async{
    var data;
    var searchQuery = "";
    if (label == "PRE-SELLING") {
      var listings = (await FirebaseFirestore.instance
          .collection('listings')
          .where('type', isEqualTo: 'Pre-selling')
          .get())
        .docs;
        data = listings.map((listing) {
        return listing.data();
      }).toList();
      searchQuery = "Pre Selling Listings";
    } else if (label == "RESIDENTIAL") {
      var listings = (await FirebaseFirestore.instance
          .collection('listings')
          .where('sub_category', isEqualTo: 'Residential')
          .get())
          .docs;
        data = listings.map((listing) {
        return listing.data();
      }).toList();
      searchQuery = "Residential Listings";
    } else if (label == "COMMERCIAL") {
      var listings = (await FirebaseFirestore.instance
          .collection('listings')
          .where('type', isEqualTo: 'Commercial')
          .get())
          .docs;
        data = listings.map((listing) {
        return listing.data();
      }).toList();
      searchQuery = "Commercial Listings";
    } else if (label == "RENTAL") {
      var listings = (await FirebaseFirestore.instance
          .collection('listings')
          .where('sub_category', isEqualTo: 'Rent to Own')
          .get())
          .docs;
        data = listings.map((listing) {
        return listing.data();
      }).toList();
      searchQuery = "Rental Listings";
    } else if (label == "AUCTION") {
      var listings = (await FirebaseFirestore.instance
          .collection('listings')
          .where('type', isEqualTo: 'Others')
          .get())
          .docs;
        data = listings.map((listing) {
        return listing.data();
      }).toList();
      searchQuery = "Auction Listings";
    }
    Get.toNamed("/searchresult",
        arguments: [data, searchQuery]);
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
