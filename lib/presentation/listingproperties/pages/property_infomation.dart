import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/mortageCalculator.dart';
import 'package:eraphilippines/presentation/mortageCalculator.dart/pages/MortageCalculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class PropertyInformation extends StatelessWidget {
  final RealEstateListing listing;

  const PropertyInformation({required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
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
                  Image.asset(listing.convertusd, height: 50.h, width: 50.w),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            //temporary
            Image.asset(listing.image),
            SizedBox(height: 20.h),
            //widget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                icons(
                    listing.moneyIcon,
                    NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                        .format(listing.pricePerSqm)),
                icons(listing.area, '${listing.areas} sqm'),
                icons(listing.bed, '${listing.beds}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                icons(listing.bath, '${listing.baths}'),
                icons(listing.car, '${listing.cars}'),
                icons(listing.sunriseIcon, 'SUNRISE'),
              ],
            ),
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
          SizedBox(height: 30.h),

          overviewSum(),
          SizedBox(height: 10.h),

          // MortageCalculator(),
          EraText(
            text: 'MORTAGE CALCULATOR',
            fontSize: 20.sp,
            color: AppColors.kRedColor,
            fontWeight: FontWeight.bold,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: AppColors.kRedColor.withOpacity(0.7), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'Mortgage Payment Breakdown',
                  fontSize: 18.sp,
                  color: AppColors.blue,
                  fontWeight: FontWeight.bold,
                ),
                MortageCalculator(
                    data: MortageData('Interest', 10).getChartData()),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget overviewSum() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.hint.withOpacity(0.7), width: 3),
      ),
      child: Padding(
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

  Widget icons(String icon, String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Image.asset(icon, height: 80.h, width: 80.w),
          EraText(
            text: text,
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 15.sp,
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
