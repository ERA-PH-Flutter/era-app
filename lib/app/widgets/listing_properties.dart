import 'package:eraphilippines/app/models/listing.dart';
import 'package:eraphilippines/app/widgets/Listing_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListingProperties extends StatelessWidget {
  final List<RealEstateListing> listingModels;
  final Axis? scrollDirection;

  const ListingProperties(
      {super.key, required this.listingModels, this.scrollDirection});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 580.h,
      child: GridView.builder(
        scrollDirection: scrollDirection ?? Axis.horizontal,
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
              // Get.toNamed('');
              //
            }),
      ),
    );
  }
}
