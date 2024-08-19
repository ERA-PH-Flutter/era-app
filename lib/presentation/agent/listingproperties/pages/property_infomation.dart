import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/favorites/controllers/fav_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/listing_controller.dart';

class PropertyInformation extends GetView<ListingController> {
  final RealEstateListing listing;

  PropertyInformation({
    super.key,
    required this.listing,
  });
  final FavController favoritesController = Get.put(FavController());

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: EraText(
                text: 'Property Information',
                color: AppColors.blue,
                fontSize: 23.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: EraText(
                text: listing.type,
                color: AppColors.kRedColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EraText(
                    text: NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                        .format(listing.price),
                    color: AppColors.black,
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  //convert to usd
                  Image.asset(AppEraAssets.convertusd,
                      height: 50.h, width: 50.w),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // i dont know why URI is not working here
            Obx(() {
              bool isFav = favoritesController.isFavorite(listing);
              CachedNetworkImage.evictFromCache(controller.currentImage.value);

              return SizedBox(
                height: 350.h,
                child: Stack(
                  children: [
                    Positioned(
                        child: SizedBox(
                      height: 320.h,
                      child: CachedNetworkImage(
                        imageUrl: controller.currentImage.value,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error, color: Colors.red),
                            Text('Failed to load image'),
                            Text(error.toString()),
                          ],
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    )),
                    Positioned(
                      bottom: 0.h,
                      child: SizedBox(
                        width: Get.width,
                        height: 70.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.images.length,
                          itemBuilder: (context, index) {
                            final image = controller.images[index];
                            final isSelected =
                                controller.currentImage.value == image;

                            return GestureDetector(
                              onTap: () {
                                controller.onSelectedImage(image);
                              },
                              child: Container(
                                decoration: isSelected
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.hint,
                                          width: 5,
                                        ),
                                      )
                                    : null,
                                margin: EdgeInsets.symmetric(horizontal: 7.w),
                                child: CachedNetworkImage(
                                  imageUrl: controller.images[index],
                                  fit: BoxFit.cover,
                                  width: Get.width / 6,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      right: 10.w,
                      top: 10.h,
                      child: Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            if (isFav) {
                              favoritesController.removeFromFavorites(listing);
                            } else {
                              favoritesController.addToFavorites(listing);
                            }
                          },
                          child: isFav
                              ? Icon(
                                  CupertinoIcons.heart_fill,
                                  color: AppColors.kRedColor,
                                  size: 30.sp,
                                )
                              : Icon(
                                  CupertinoIcons.heart,
                                  color: AppColors.hint,
                                  size: 30.sp,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),

            SizedBox(height: 20.h),
            //widget
            iconsText(),
            SizedBox(height: 20.h),
            allDescriptions(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget allDescriptions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Description',
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          EraText(
            text: listing.description,
            color: AppColors.black,
            fontSize: 14.sp,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          eratexts('Listing ID# ', '${listing.listingId}'),
          eratexts('Last Updated: ', '${listing.lastUpdated}'),
          eratexts('Added: ', '${listing.addedDaysago} days Ago'),

          SizedBox(height: 20.h),

          featuresWidgets('Features / Amenities', listing.features.join('\n')),
          SizedBox(height: 20.h),
          featuresWidgets(
              'Rooms & Interior', listing.roomsAndInterior.join('\n')),
          SizedBox(height: 20.h),
          featuresWidgets(
              'Location & School', listing.locationAndSchools.join('\n')),

          SizedBox(height: 40.h),
          //widget location
          location(),
          SizedBox(height: 30.h),

          overviewSum(),
          SizedBox(height: 30.h),

//widget
          BoxWidget.BoxWidget2(
              AppColors.hint.withOpacity(0.3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                      text: 'PROPERTY PERFOMANCE',
                      fontSize: 20.sp,
                      color: AppColors.kRedColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        EraText(
                          text: 'Views: ',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 100.w),
                        EraText(
                          text: '${listing.views}',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        EraText(
                          text: 'Leads: ',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 100.w),
                        EraText(
                          text: '${listing.leads}',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ],
                    )
                  ],
                ),
              )),
          SizedBox(height: 30.h),
          ListedBy(
            text: 'Listed By',
            image: listing.user.image!,
            agentFirstName: listing.user.firstname!,
            agentLastName: listing.user.lastname!,
            agentType: listing.user.role!,
            whatsapp: listing.user.whatsApp,
            whatsappIcon: AppEraAssets.whatsappIcon,
            email: listing.user.email,
            emailIcon: AppEraAssets.emailIcon,
          ),

          SizedBox(height: 20.h),
          EraText(
            text: 'SIMILAR LISTINGS',
            color: AppColors.kRedColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 10.h),

          //ListingProperties(listingModels: RealEstateListing.listingsModels),
          Button(
            text: 'MORE LISTINGS',
            onTap: () {
              Get.toNamed('/findproperties');
            },
            bgColor: AppColors.blue,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            width: 320.w,
            margin: EdgeInsets.symmetric(horizontal: 0.w),
          ),
        ],
      ),
    );
  }

  Widget location() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Location',
            color: AppColors.kRedColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: 'Address',
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
          SizedBox(height: 20.h),
          EraText(
            text: listing.address,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          //temporary i dont know how to implemnt the location
          SizedBox(height: 10.h),
          Image.asset(
            'assets/images/locationImage.png',
          ),
        ],
      ),
    );
  }

  Widget iconsText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconsWidgets(AppEraAssets.money2, '${listing.pricePerSqm}'),
            iconsWidgets(AppEraAssets.area, '${listing.areas} sqm'),
            iconsWidgets(AppEraAssets.bed, '${listing.beds}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconsWidgets(AppEraAssets.tub, '${listing.baths}'),
            iconsWidgets(AppEraAssets.car, '${listing.cars}'),
            iconsWidgets(AppEraAssets.sunrise, 'SUNRISE'),
          ],
        ),
      ],
    );
  }

  Widget overviewSum() {
    return BoxWidget.BoxWidget2(
      AppColors.white,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: 'OVERVIEW SUMMARY',
              color: AppColors.kRedColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 5.h),
            shorterSummary('Property ID', '${listing.propertyId}'),
            shorterSummary(
                'Price',
                NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                    .format(listing.price)),
            shorterSummary(
                'Price per sqm',
                NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                    .format(listing.pricePerSqm)),
            shorterSummary('Beds', '${listing.beds}'),
            shorterSummary('Baths', '${listing.baths}'),
            shorterSummary('Area', '${listing.areas}'),
            shorterSummary('Offer Type', listing.offerType),
            shorterSummary('View', listing.view),
            shorterSummary('Location', listing.location),
            shorterSummary('Type', listing.specificType),
            shorterSummary('Sub Category', listing.subCategory),
          ],
        ),
      ),
    );
  }

  Widget featuresWidgets(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: EraText(
            text: text,
            color: AppColors.black,
            fontSize: 15.sp,
            maxLines: 50,
          ),
        ),
      ],
    );
  }

  Widget iconsWidgets(String image, String text) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 80.h,
          width: 80.w,
        ),
        EraText(
          text: text,
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          fontSize: 15.sp,
        ),
      ],
    );
  }

  Widget shorterSummary(String text, text2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      child: Row(
        children: [
          Expanded(
            child: EraText(
              text: text,
              color: AppColors.black,
              fontSize: 18.sp,
            ),
          ),
          Expanded(
            child: EraText(
              text: text2,
              color: AppColors.black,
              fontSize: 18.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget eratexts(String text, text2) {
    return Row(
      children: [
        EraText(
          text: text,
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        EraText(
          text: text2,
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
