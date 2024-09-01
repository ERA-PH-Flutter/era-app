import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../services/firebase_database.dart';

class SoldPropertiesListings extends StatelessWidget {
  final listingModels;

  const SoldPropertiesListings({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        mainAxisExtent: 510.h,
        mainAxisSpacing: 20.h,
      ),
      itemCount: listingModels!.length,
      itemBuilder: (context, i) => ListingItemss(
        fromSold: true,
        image: (listingModels![i].photos != null)
            ? (listingModels[i].photos.isNotEmpty
                ? listingModels[i].photos.first
                : AppStrings.noUserImageWhite)
            : AppStrings.noUserImageWhite,
        type: listingModels![i].type!,
        areas: listingModels![i].area!,
        beds: listingModels![i].beds!,
        baths: listingModels![i].baths!,
        cars: listingModels![i].cars!,
        description: listingModels![i].description!,
        price: listingModels![i].price ?? 0,
        showListedby: true,
        listedBy: 'Listed By',
        agent: listingModels[i].by,
        onTap: ()async{
          await Database().addViews(listingModels[i].id);
          Get.toNamed('/propertyInfo', arguments: listingModels![i]);
        },
        isSold: listingModels![i].isSold!,
      ),
    );
  }
}
