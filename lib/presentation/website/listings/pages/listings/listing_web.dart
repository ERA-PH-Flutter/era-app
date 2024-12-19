import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/home/pages/home_web.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/presentation/website/listings/controllers/listings_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../app/constants/screens.dart';
import '../../../../../../app/widgets/filteredsearch_box.dart';
import '../../../../../../app/widgets/listings/listedBy_widget.dart';
import '../../../../../../repository/listing.dart';
import '../../../../../../repository/user.dart';
import '../../../../global.dart';

class BuyWeb extends GetView<ListingsWebController> {
  const BuyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.h,
          ),
          EraText(
            text: "Property searches made simple.",
            fontSize: EraTheme.h1,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 5),
            child: FilteredSearchBox(),
          ),
          sb50(),
          Obx(() {
            if (controller.showFullSearch.value == false) {
              return controller.quickLinks ?? Container();
            }
            return Container();
          }),
          Obx(() => switch (controller.listingsWebState.value) {
                ListingsWebState.loading => Screens.loading(height: 500.h),
                ListingsWebState.loaded => _loaded(),
                ListingsWebState.empty => _empty(),
                ListingsWebState.searching => _searching(),
                ListingsWebState.error => _error(),
              }),
        ],
      ),
    );
  }

  _searching() {
    return Container();
  }

  _loaded() {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Obx(() {
            if (controller.searchQuery.value == "") {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Showcased Listings',
                    fontSize: EraTheme.h1,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.w800,
                  ),
                  EraText(
                    text: 'Explore Our Top Picks',
                    fontSize: EraTheme.h2,
                    color: AppColors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Here\'s what I found for you!',
                    fontSize: 23.sp,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            }
          }),
          SizedBox(height: 10.h),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: Get.height - 180.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              if (controller.data[index] != null) {
                Listing listing = Listing.fromJSON(controller.data[index]);
                return GestureDetector(
                  onTap: () async {
                    // await Database().addViews(listing.id);
                    // Get.toNamed('/propertyInfo', arguments: listing);
                    listingArgument = listing;
                    selectedIndex.value = 12;
                    Get.find<HomsController>().onNavbarItemSelected(12);
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: 16.h,
                      right: 20.w,
                    ),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.black12)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CloudStorage().imageLoader(
                              height: 340.h,
                              width: Get.width,
                              fit: BoxFit.cover,
                              reference: listing.photos != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos!.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                            )),
                        SizedBox(
                          height: 17.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text:
                                listing.name! == "" ? "No Name" : listing.name!,
                            fontSize: EraTheme.h3,
                            color: AppColors.kRedColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text: listing.type!,
                            fontSize: EraTheme.h5,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            HomeWeb.buildFeatureIcon(
                              icon: AppEraAssets.area,
                              label: '${listing.floorArea} sqm',
                            ),
                            SizedBox(width: 2.w),
                            HomeWeb.buildFeatureIcon(
                              icon: AppEraAssets.bed,
                              label: '${listing.beds}',
                            ),
                            SizedBox(width: 2.w),
                            HomeWeb.buildFeatureIcon(
                              icon: AppEraAssets.tub,
                              label: '${listing.baths}',
                            ),
                            SizedBox(width: 2.w),
                            HomeWeb.buildFeatureIcon(
                              icon: AppEraAssets.car,
                              label: '${listing.cars}',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text: 'Description:',
                            fontSize: EraTheme.h6,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(
                            listing.description ?? "No description.",
                            style: TextStyle(
                              fontSize: EraTheme.caption,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text: NumberFormat.currency(
                                    locale: 'en_PH', symbol: 'PHP ')
                                .format(
                              listing.price.toString() == ""
                                  ? 0
                                  : listing.price,
                            ),
                            color: AppColors.blue,
                            fontSize: EraTheme.h4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder(
                            future: EraUser().getById(listing.by),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var user1 = snapshot.data;
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: ListedBy(
                                      image: user1!.image ??
                                          AppStrings.noUserImageWhite,
                                      agentFirstName:
                                          user1.firstname ?? "No Name",
                                      agentType: user1.role ?? "Agent",
                                      agentLastName: user1.lastname ?? ""),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        sb50(),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  _error() {
    return EraText(
      text: "ERROR",
      color: Colors.black,
    );
  }

  _empty() {
    print("data empty");
    return SizedBox(
      height: 300.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'No results found!',
            fontSize: 23.sp,
            color: AppColors.blue,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
