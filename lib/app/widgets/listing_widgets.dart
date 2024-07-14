import 'package:eraphilippines/app/widgets/listing_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class ListingWidget extends StatelessWidget {
  final List<Map<String, String>> listings = [
    {"image": "assets/images/Pre-Selling.jpg", "label": "PRE-SELLING"},
    {"image": "assets/images/Residential.jpg", "label": "RESIDENTIAL"},
    {"image": "assets/images/Commercial.jpg", "label": "COMMERCIAL"},
    {"image": "assets/images/Rental.jpg", "label": "RENTAL"},
    {"image": "assets/images/Residential.jpg", "label": "AUCTION"},
  ];

  ListingWidget({super.key});
  void _onTap(BuildContext context, String label) {
    if (label == "PRE-SELLING") {
      Get.toNamed("/pre-selling");
    } else if (label == "RESIDENTIAL") {
      Get.toNamed("/residential");
    } else if (label == "COMMERCIAL") {
      Get.toNamed("/commercial");
    } else if (label == "RENTAL") {
      Get.toNamed("/rental");
    } else if (label == "AUCTION") {
      Get.toNamed("/auction");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        itemCount: listings.length,
        crossAxisCount: 2,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _onTap(context, listings[index]["label"]!),
            child: ListingCard(
              image: listings[index]["image"]!,
              label: listings[index]["label"]!,
            ),
          );
        },
        staggeredTileBuilder: (index) {
          return listings[index]["label"] == "AUCTION"
              ? StaggeredTile.count(2, 1)
              : StaggeredTile.count(1, 1);
        },
      ),
    );
  }
}
