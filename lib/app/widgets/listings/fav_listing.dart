import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:eraphilippines/presentation/agent/favorites/controllers/fav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FavListing extends StatelessWidget {
  List<RealEstateListing> listingModels;
  FavListing({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    final FavController favoritesController = Get.put(FavController());

    return GridView.builder(
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(10),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 550,
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
          agentFirstName: ' ${listingModels[i].user.firstname}',
          agentLastName: '${listingModels[i].user.lastname}',
          role: '${listingModels[i].user.role}',
          buttonDelete: Button(
            onTap: () {
              favoritesController.removeFromFavorites(listingModels[i]);
            },
            fontSize: 20.sp,
            text: 'Remove from Favorites',
            bgColor: AppColors.kRedColor,
            height: 40.h,
            width: Get.width - 150.w,
            borderRadius: BorderRadius.circular(5),
          ),
          onTap: () {
            Get.toNamed('/propertyInfo', arguments: listingModels[i]);
          }),
    );
  }
}
