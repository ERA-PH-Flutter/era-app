import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/agent/favorites/controllers/fav_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';

class FavItems extends StatelessWidget {
  final RealEstateListing listing;
  final int index;
  final Function() onTap;
  final Function(int index) onLongPress;

  const FavItems({
    super.key,
    required this.listing,
    required this.index,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final FavController favC = Get.find();
    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        favC.enterSelectionMode();
        onLongPress(index);
      },
      child: Stack(
        children: [
          Obx(() {
            return Card(
              color: favC.isSelected(index)
                  ? AppColors.hint.withOpacity(0.7)
                  : AppColors.white,
              elevation: 7,
              child: Row(
                children: [
                  Image.asset(
                    '${listing.user.image}',
                    width: 110.w,
                    height: 90.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h, left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text:
                              '${listing.user.firstname} ${listing.user.lastname}',
                          color: AppColors.blue,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        EraText(
                          text: listing.type,
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Positioned(
            bottom: 10.w,
            right: 10.w,
            child: Obx(
              () => favC.isSelected(index)
                  ? Icon(
                      CupertinoIcons.heart,
                      color: AppColors.kRedColor,
                      size: 25.sp,
                    )
                  : Icon(
                      CupertinoIcons.heart_fill,
                      color: AppColors.kRedColor,
                      size: 25.sp,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
