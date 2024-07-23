import 'package:eraphilippines/app/models/listing.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/listingproperties/pages/property_infomation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class ListingItems extends StatelessWidget {
  final RealEstateListing listingItems;
  final Function()? onTap;
  const ListingItems({super.key, required this.listingItems, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: '${listingItems.type}',
                fontSize: 16.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      listingItems.area,
                      width: 47.w,
                      height: 46.h,
                    ),
                    SizedBox(width: 2.w),
                    EraText(
                      text: '${listingItems.areas}',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: 'Description:',
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                listingItems.description,
                style: TextStyle(
                  fontSize: 16.sp,
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
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                    .format(listingItems.price),
                color: AppColors.blue,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: 'Listed By:',
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 5.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget build3() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Image.asset(
              listingItems.bed,
              width: 47.w,
              height: 46.h,
            ),
          ],
        ),
        Row(
          children: [
            EraText(
              text: '${listingItems.beds}',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ],
        ),
      ],
    );
  }
}
