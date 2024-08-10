import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_corner_image.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';

// ignore: must_be_immutable
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
  ListingItemss({
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
  var selected = false.obs;
  void toggleSelected() {
    selected.value = !selected.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(onTap: () {
              toggleSelected();
            }, child: Obx(
              () {
                return ClipPath(
                  clipper: selected.value ? CustomCornerClipPath() : null,
                  child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      height: selected.value ? 170.h : 200.h,
                      width: selected.value ? 340.w : 380.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      )),
                );
              },
            )),
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
