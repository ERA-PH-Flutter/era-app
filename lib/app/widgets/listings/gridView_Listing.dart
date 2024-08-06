import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ListingProperties extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const ListingProperties({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 510.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 410,
        ),
        itemCount: listingModels.length,
        itemBuilder: (context, i) => ListingItemss(
            image: listingModels[i].image,
            type: listingModels[i].type,
            areas: listingModels[i].areas,
            beds: listingModels[i].beds,
            baths: listingModels[i].baths,
            cars: listingModels[i].cars,
            description: listingModels[i].description,
            price: listingModels[i].price,
            listedBy: 'Listed By',
            agentImage: '${listingModels[i].user.image}',
            agentFirstName: '${listingModels[i].user.firstname}',
            agentLastName: '${listingModels[i].user.lastname}',
            role: '${listingModels[i].user.role}',
            onTap: () {
              Get.toNamed('/propertyInfo', arguments: listingModels[i]);
            }),
      ),
    );
  }
}
