import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';

class ListingItemss extends StatelessWidget {
  final String image;
  final String type;
  final int areas;
  final int beds;
  final int baths;
  final int cars;
  final String description;
  final double price;
  final String? listedBy;
  final String? agentImage;
  final String? agentFirstName;
  final String? agentLastName;
  final String? role;
  final Widget? buttonEdit;
  final Widget? buttonDelete;

  final Function()? onTap;
  const ListingItemss({
    super.key,
    this.onTap,
    required this.image,
    required this.type,
    required this.areas,
    required this.beds,
    required this.baths,
    required this.cars,
    required this.description,
    required this.price,
    required this.listedBy,
    required this.agentImage,
    required this.agentFirstName,
    required this.agentLastName,
    required this.role,
    this.buttonEdit,
    this.buttonDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: 380.w,
                height: 200.h,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: type,
                fontSize: 16.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.bold,
                lineHeight: 0.4,
              ),
            ),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppEraAssets.area,
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(width: 2.w),
                    EraText(
                      text: '$areas sqm',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  AppEraAssets.bed,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '$beds',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  AppEraAssets.tub,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '$baths',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  AppEraAssets.car,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '$cars',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: EraText(
                text: 'Description:',
                fontSize: 16.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                lineHeight: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                description,
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
                    .format(price),
                color: AppColors.blue,
                fontSize: 23.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListedBy(
              text: listedBy!,
              image: agentImage!,
              agentFirstName: agentFirstName!,
              agentLastName: agentLastName!,
              agentType: role!,
            ),
            SizedBox(height: 20.h),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              if (buttonEdit != null) buttonEdit!,
              if (buttonDelete != null) buttonDelete!,
            ]),
          ],
        ),
      ),
    );
  }
}
