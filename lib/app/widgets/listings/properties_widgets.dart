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

class PropertiesWidgets extends StatelessWidget {
  final List listingsModels;

  const PropertiesWidgets({super.key, required this.listingsModels});
  void _onTap(BuildContext context, String label) {
    if (label == "PRE-SELLING") {
      Get.to(() => PreSelling());
      // Get.toNamed("/selling-search-result");
    } else if (label == "RESIDENTIAL") {
      Get.to(() => Residential());

      // Get.toNamed("/project");
    } else if (label == "COMMERCIAL") {
      Get.to(() => Commercial());

      // Get.toNamed("/project-main");
    } else if (label == "RENTAL") {
      Get.to(() => Rental());

      // Get.toNamed("/rent-search-result");
    } else if (label == "AUCTION") {
      Get.to(() => Auction());

      // Get.toNamed("/project-main");
    }
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
