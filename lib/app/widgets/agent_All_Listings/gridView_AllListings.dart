import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GridviewAlllistings extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const GridviewAlllistings({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(10),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 580,
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
            buttonEdit: Button.button3(150.w, 40.h, () {
              Get.toNamed('/editListings');
            }, 'Edit', AppColors.blue),
            buttonDelete: Button.button3(
                150.w, 40.h, () {}, 'Delete', AppColors.kRedColor),
            onTap: () {
              Get.toNamed('/propertyInfo', arguments: listingModels[i]);
            }),
      ),
    );
  }
}
