import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FindingProperties extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const FindingProperties({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 510,
        ),
        itemCount: listingModels.length,
        itemBuilder: (context, i) => ListingItemss(
          fromSold: false,
          image: listingModels[i].image,
          type: listingModels[i].type,
          areas: listingModels[i].areas.toDouble(),
          beds: listingModels[i].beds,
          baths: listingModels[i].baths,
          cars: listingModels[i].cars,
          description: listingModels[i].description,
          price: listingModels[i].price.toDouble(),
          showListedby: true,
          listedBy: 'Listed By',
          agentImage: '${listingModels[i].user.image}',
          agentFirstName: ' ${listingModels[i].user.firstname}',
          agentLastName: '${listingModels[i].user.lastname}',
          role: '${listingModels[i].user.role}',
          onTap: () async {
            Get.toNamed('/propertyInfo', arguments: listingModels[i]);
          },
          isSold: false,
        ),
      ),
    );
  }
}
