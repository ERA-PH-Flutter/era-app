import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listingItems_widget.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../repository/listing.dart';
import '../../services/firebase_database.dart';

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
          mainAxisSpacing: 20,
        ),
        itemCount: listingModels.length,
        itemBuilder: (context, i) => ListingItemss(
          fromSold: false,
          id: listingModels[i].id,
          by: listingModels[i].by,
          image: listingModels[i].photos!.firstOrNull ??
              AppStrings.noUserImageWhite,
          type: listingModels[i].name!,
          areas: listingModels[i].area ?? 0,
          beds: listingModels[i].beds ?? 0,
          baths: listingModels[i].baths ?? 0,
          cars: listingModels[i].cars ?? 0,
          description: listingModels[i].description ?? "No Description added.",
          price: listingModels[i].price ?? 0,
          showListedby: false,
          buttonEdit: Button.button3((Get.width - 65.w) / 2, 40.h, () {
            Get.toNamed('/editListings', arguments: [listingModels[i].id]);
          }, 'Edit', AppColors.blue),
          buttonDelete: Button.button3((Get.width - 65.w) / 2, 43.h, () {
            BaseController().showSuccessDialog(
                title: "Confirm",
                description: "Do you want to delete this listing?",
                hitApi: () async {
                  BaseController().showLoading();
                  await Listing().deleteListingsById(listingModels[i].id);
                  BaseController().hideLoading();
                  Get.back();
                },
                cancelable: true);
          }, 'Delete', AppColors.kRedColor),
          buttonSold: Button.button3(
            (Get.width - 65.w) / 2,
            30.h,
            () {},
            'Mark as Sold',
            AppColors.blue,
          ),
          onTap: ()async{
             await Database().addViews(listingModels[i].id);
            Get.toNamed('/propertyInfo', arguments: listingModels[i]);
          },
          isSold: listingModels[i].isSold ?? false,
        ),
      ),
    );
  }



}
