import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';

import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/listing_properties.dart';
import 'package:eraphilippines/app/widgets/pieChart.dart';

import 'package:eraphilippines/presentation/mortageCalculator.dart/pages/MortageCalculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PropertyInformation extends StatelessWidget {
  final RealEstateListing listing;

  const PropertyInformation({
    super.key,
    required this.listing,
  });

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
            //temporary
            Image.asset(listing.image),
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
          EraText(
            text: 'Features / Amenities',
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: EraText(
              text: listing.features.join('\n'),
              color: AppColors.black,
              fontSize: 14.sp,
              maxLines: 50,
            ),
          ),
          SizedBox(height: 20.h),
          EraText(
            text: 'Rooms & Interior',
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: EraText(
              text: listing.roomsAndInterior.join('\n'),
              color: AppColors.black,
              fontSize: 14.sp,
              maxLines: 50,
            ),
          ),
          SizedBox(height: 20.h),
          EraText(
            text: 'Location & School',
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: EraText(
              text: listing.locationAndSchools.join('\n'),
              color: AppColors.black,
              fontSize: 14.sp,
              maxLines: 50,
            ),
          ),
          SizedBox(height: 40.h),
          //widget location
          location(),
          SizedBox(height: 30.h),

          overviewSum(),
          SizedBox(height: 30.h),

          // MortageCalculator page, widget
          EraText(
            text: 'MORTAGE CALCULATOR',
            fontSize: 20.sp,
            color: AppColors.kRedColor,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 15.h),
          Container(
            height: 330.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppColors.kRedColor.withOpacity(0.7), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: EraText(
                    text: 'Mortgage Payment Breakdown',
                    fontSize: 18.sp,
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40.h),
                Piechart(),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          MortageCalculator(),
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
            image: listing.agentImage,
            agentFirstName: listing.agentFirstName,
            agentLastName: listing.agentLastName,
            agentType: listing.agents,
            whatsapp: listing.whatsapp,
            whatsappIcon: AppEraAssets.whatsappIcon,
            email: listing.email,
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

          ListingProperties(listingModels: RealEstateListing.listingsModels),

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
            iconsWidgets(AppEraAssets.money, '${listing.pricePerSqm}'),
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
            shorterSummary('Sub Catergory', listing.subCatergory),
          ],
        ),
      ),
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
