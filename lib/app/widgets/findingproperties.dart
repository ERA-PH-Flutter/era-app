import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/listing_items.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FindingProperties extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const FindingProperties({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 520,
      ),
      itemCount: listingModels.length,
      itemBuilder: (context, i) => ListingItems(
          listingItems: listingModels[i],
          onTap: () {
            // Get.toNamed("/propertyInfo", arguments: listingModels[i]);
          }),
    );
  }
}