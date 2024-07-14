import 'package:architecture/app/models/listing.dart';
import 'package:architecture/app/widgets/listing_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ListingProperties extends StatelessWidget {
  final List<Listing> listingProperties;

  const ListingProperties({super.key, required this.listingProperties});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 540.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(20),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 410,
        ),
        itemCount: listingProperties.length,
        itemBuilder: (context, i) => ListingItems(
            listingItems: listingProperties[i],
            onTap: () {
              // Get.toNamed('');
              //
            }),
      ),
    );
  }
}
