import 'package:eraphilippines/app/models/listing.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class ListingItems extends StatelessWidget {
  final Listing listingItems;
  final Function()? onTap;
  const ListingItems({super.key, required this.listingItems, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              listingItems.image,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 15.h,
            ),
            EraText(
              text: '${listingItems.type}',
              fontSize: 16.sp,
              color: AppColors.kRedColor,
              fontWeight: FontWeight.bold,
            ),
            Container(
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    listingItems.area,
                    width: 47.w,
                    height: 46.h,
                  ),
                  EraText(
                    text: '${listingItems.areas} sqm',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 2.w),
                  Image.asset(
                    listingItems.bed,
                    width: 47.w,
                    height: 46.h,
                  ),
                  EraText(
                    text: '${listingItems.beds}',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 2.w),
                  Image.asset(
                    listingItems.bath,
                    width: 47.w,
                    height: 46.h,
                  ),
                  EraText(
                    text: '${listingItems.baths}',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  SizedBox(width: 2.w),
                  Image.asset(
                    listingItems.car,
                    width: 47.w,
                    height: 46.h,
                  ),
                  EraText(
                    text: '${listingItems.cars}',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ],
              ),
            ),
            EraText(
              text: 'Description:',
              fontSize: 16.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            Text(
              listingItems.description,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 5.h,
            ),
            EraText(
              text: NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                  .format(listingItems.price),
              // text: 'PHP ${listingItems.price}',
              color: AppColors.blue,
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
            ),
            EraText(
              text: 'Listed By:',
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: AppColors.black,
            ),
            SizedBox(height: 5.h),
            Row(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColors.hint),
                  child: Image.asset(
                    listingItems.agentImage,
                    width: 47.w,
                    height: 47.h,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                      text: listingItems.agentName,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                    EraText(
                      text: listingItems.agents,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}