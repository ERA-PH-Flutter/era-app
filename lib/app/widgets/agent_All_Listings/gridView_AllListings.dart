import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../repository/listing.dart';

class GridviewAlllistings extends StatelessWidget {
  final List<Listing> listingModels;

  const GridviewAlllistings({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisExtent: 500,
        ),
        itemCount: listingModels.length,
        itemBuilder: (context, i) => ListingItemss(
            fromSold: false,
            id: listingModels[i].id,
            image: listingModels[i].photos!.firstOrNull ?? AppStrings.noUserImageWhite,
            type: listingModels[i].type!,
            areas: listingModels[i].area ?? 0,
            beds: listingModels[i].beds ?? 0,
            baths: listingModels[i].baths ?? 0,
            cars: listingModels[i].cars ?? 0,
            description: listingModels[i].description ?? "",
            price: listingModels[i].price ?? 0,
            showListedby: false,
            buttonEdit: Button.button3(150.w, 40.h, () {
              Get.toNamed('/editListings');
            }, 'Edit', AppColors.blue),
            buttonDelete: Button.button3(
                150.w, 40.h, () {}, 'Delete', AppColors.kRedColor),
            onTap: () {
              Get.toNamed('/propertyInfo', arguments: listingModels[i]);
            },
            isSold: listingModels[i].isSold ?? false,
        ),
      ),
    );
  }
}
