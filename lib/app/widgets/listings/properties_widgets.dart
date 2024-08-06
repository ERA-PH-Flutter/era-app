import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/widgets/listings/properties_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class PropertiesWidgets extends StatelessWidget {
  final List<PropertiesModels> listingsModels;

  const PropertiesWidgets({super.key, required this.listingsModels});
  void _onTap(BuildContext context, String label) {
    if (label == "PRE-SELLING") {
      Get.toNamed("/selling-search-result");
    } else if (label == "RESIDENTIAL") {
      Get.toNamed("/project");
    } else if (label == "COMMERCIAL") {
      Get.toNamed("/project-main");
    } else if (label == "RENTAL") {
      Get.toNamed("/rent-search-result");
    } else if (label == "AUCTION") {
      Get.toNamed("/project-main");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        itemCount: listingsModels.length,
        crossAxisCount: 2,
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
