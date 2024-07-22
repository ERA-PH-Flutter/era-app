import 'package:eraphilippines/app/models/listing.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/widgets/listing_items.dart';
import 'package:flutter/widgets.dart';

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
        mainAxisExtent: 560,
      ),
      itemCount: listingModels.length,
      itemBuilder: (context, i) => ListingItems(
          listingItems: listingModels[i],
          onTap: () {
            // Get.toNamed('');
            //
          }),
    );
  }
}
