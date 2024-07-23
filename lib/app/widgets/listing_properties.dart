import 'package:eraphilippines/app/models/listing.dart';
import 'package:eraphilippines/app/widgets/Listing_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ListingProperties extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const ListingProperties({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 420,
        ),
        itemCount: listingModels.length,
        itemBuilder: (context, i) => ListingItems(
            listingItems: listingModels[i],
            onTap: () {
              // Get.toNamed('/propertyInfo');
              //
            }),
      ),
    );
  }
}
