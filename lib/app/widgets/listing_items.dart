import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listedBy_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class ListingItems extends StatelessWidget {
  final RealEstateListing listingItems;

  final Function()? onTap;
  const ListingItems({
    super.key,
    required this.listingItems,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/propertyInfo', arguments: listingItems);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.asset(
                listingItems.image,
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
                text: listingItems.type,
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
                      listingItems.area,
                      width: 40.w,
                      height: 40.h,
                    ),
                    SizedBox(width: 2.w),
                    EraText(
                      text: '${listingItems.areas} sqm',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ],
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  listingItems.bed,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '${listingItems.beds}',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  listingItems.bath,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '${listingItems.baths}',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                SizedBox(width: 10.w),
                Image.asset(
                  listingItems.car,
                  width: 40.w,
                  height: 40.h,
                ),
                EraText(
                  text: '${listingItems.cars}',
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
            //widget listed by
            ListedBy(
              text: 'Listed By',
              image: listingItems.agentImage,
              agentFirstName: listingItems.agentFirstName,
              agentLastName: listingItems.agentLastName,
              agentType: listingItems.agents,
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
 // Widget listedBys(String image, String agentName, String agentType) {

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: EraText(
  //           text: 'Listed By:',
  //           fontWeight: FontWeight.bold,
  //           fontSize: 12.sp,
  //           color: AppColors.black,
  //         ),
  //       ),
  //       SizedBox(height: 5.h),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10.0),
  //         child: Row(
  //           children: [
  //             Container(
  //               clipBehavior: Clip.antiAlias,
  //               decoration: BoxDecoration(
  //                   shape: BoxShape.circle, color: AppColors.hint),
  //               child:  Image.asset(
  //                 listingItems.agentImage,
  //                 width: 47.w,
  //                 height: 47.h,
  //               ),
  //             ),
  //             SizedBox(
  //               width: 10.w,
  //             ),
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 EraText(
  //                   text: listingItems.agentName,
  //                   fontSize: 14.sp,
  //                   fontWeight: FontWeight.bold,
  //                   color: AppColors.black,
  //                 ),
  //                 EraText(
  //                   text: listingItems.agents,
  //                   fontSize: 12.sp,
  //                   fontWeight: FontWeight.w500,
  //                   color: AppColors.black,
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }