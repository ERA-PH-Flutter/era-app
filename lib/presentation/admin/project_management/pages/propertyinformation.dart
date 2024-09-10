import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/button.dart';

class PropertyInformationAdmin extends StatelessWidget {
  const PropertyInformationAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: 'PROPERTY INFORMATION',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 16.h),
            propertyInfo(listingModels: RealEstateListing.listingsModels),
          ],
        ),
      ),
    );
  }

  Widget propertyInfo({
    required List<RealEstateListing> listingModels,
  }) {
    final listing = listingModels.isNotEmpty ? listingModels[0] : null;

    if (listing == null) {
      return Center(
        child: EraText(
          text: 'No property information available',
          color: AppColors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: listing.type,
          color: AppColors.kRedColor,
          fontSize: EraTheme.header,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        EraText(
          text: NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
              .format(listing.price),
          color: AppColors.black,
          fontSize: 23.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 10.h),
        Container(
          height: 200.h,
          color: AppColors.black,
          width: double.infinity,
        ),
        SizedBox(height: 10.h),
        EraText(
          text: 'About This Property',
          color: AppColors.black,
          fontSize: EraTheme.header,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Description',
                    color: AppColors.black,
                    fontSize: EraTheme.header,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h),
                  EraText(
                    text: listing.description,
                    color: AppColors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    maxLines: 50,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.hint,
                        width: 2.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        EraText(
                          text: 'OVERVIEW',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kRedColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: EraTheme.paddingWidth),
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              shorterSummary(
                                text: 'Property ID:',
                                text2: listing.propertyId.toString(),
                              ),
                              shorterSummary(
                                text: 'Price',
                                text2: NumberFormat.currency(
                                        locale: 'en_PH', symbol: 'PHP ')
                                    .format(listing.price),
                              ),
                              shorterSummary(
                                text: 'Price per sqm',
                                text2: NumberFormat.currency(
                                        locale: 'en_PH', symbol: 'PHP ')
                                    .format(listing.pricePerSqm),
                              ),
                              shorterSummary(
                                text: 'Beds',
                                text2: listing.beds.toString(),
                              ),
                              shorterSummary(
                                text: 'Baths',
                                text2: listing.baths.toString(),
                              ),
                              shorterSummary(
                                text: 'Garage',
                                text2: listing.cars.toString(),
                              ),
                              shorterSummary(
                                text: 'Area',
                                text2: listing.areas.toString(),
                              ),
                              shorterSummary(
                                text: 'View',
                                text2: listing.view,
                              ),
                              shorterSummary(
                                text: 'Location',
                                text2: listing.location.capitalize ?? '',
                              ),
                              shorterSummary(
                                text: 'Type',
                                text2: listing.type,
                              ),
                              shorterSummary(
                                text: 'Sub Category',
                                text2: listing.subCategory,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  sb30(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(
                        color: AppColors.hint,
                        width: 2.w,
                      ),
                    ),
                    child: Column(
                      children: [
                        EraText(
                          text: 'PROPERTY PERFORMANCE',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kRedColor,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: EraTheme.paddingWidth),
                          child: Column(
                            children: [
                              SizedBox(height: 5.h),
                              shorterSummary(
                                text: 'Views',
                                text2: listing.views.toString(),
                              ),
                              shorterSummary(
                                text: 'Leads',
                                text2: listing.leads.toString(),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  sb30(),
                  shorterSummary(
                      text: 'Listing ID# ', text2: '${listing.propertyId}'),
                  shorterSummary(
                      text: 'Last Updated: ', text2: '${listing.lastUpdated}'),
                  shorterSummary(
                      text: 'Added: ', text2: '${listing.addedDaysago}'),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(8.sp),
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Button(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 150.w,
              text: 'EDIT',
              bgColor: AppColors.blue,
              borderRadius: BorderRadius.circular(30),
            ),
            Button(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 150.w,
              text: 'DELETE',
              bgColor: AppColors.hint,
              borderRadius: BorderRadius.circular(30),
            ),
          ]),
        ),
      ],
    );
  }

  Widget shorterSummary({required String text, required String text2}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EraText(
            text: text,
            color: AppColors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
          Expanded(
            child: EraText(
              text: text2,
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
