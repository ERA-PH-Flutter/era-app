import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../presentation/agent/listings/favorites/controllers/fav_controller.dart';
import '../../../repository/listing.dart';

class FavItems extends StatelessWidget {
  final Listing listing;
  final int index;
  final Function() onTap;
  final Function(int index) onLongPress;

  EraUser? agent;
  FavItems({
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
      // onLongPress: () {
      //   favC.enterSelectionMode();
      //  },
      child: Stack(
        children: [
          Obx(() {
            favC.selectionModeActive.value;
            return Card(
              color: AppColors.white,
              elevation: 7,
              child: Row(
                children: [
                  CloudStorage().imageLoaderProvider(
                    width: 140.w,
                    height: Get.height,
                    ref: '${listing.photos != null ? (listing.photos!.isNotEmpty ? listing.photos!.first : AppStrings.noUserImageWhite) : AppStrings.noUserImageWhite}',
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),bottomLeft: Radius.circular(10.r)),
                  ),
                  SizedBox(width: 5.w,),
                  FutureBuilder(
                    future: EraUser().getById(listing.by),
                    builder: (context, AsyncSnapshot<EraUser> snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: EdgeInsets.only(top: 10.h, left: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 25.h,
                                width:Get.width - 200.w,

                                child: EraText(
                                  textOverflow: TextOverflow.ellipsis,
                                  text:
                                      '${snapshot.data?.firstname ?? "Admin"} ${snapshot.data?.lastname ?? ""}',
                                  color: AppColors.blue,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              EraText(
                                text: listing.type!,
                                color: AppColors.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                maxLines: 3,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.h),
                              SizedBox(
                                width: 200.w,
                                child: EraText(
                                  text: listing.description ?? "No Description",
                                  color: AppColors.black,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  maxLines: 3,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              EraText(
                                text: NumberFormat.currency(
                                  locale: 'en_PH',
                                  symbol: 'PHP ',
                                ).format(listing.price),
                                color: AppColors.blue,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  )
                ],
              ),
            );
          }),
          Positioned(
            bottom: 10.w,
            right: 10.w,
            child: GestureDetector(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.heart_fill,
                  color: AppColors.kRedColor,
                  size: 40.sp,
                )),
          ),
        ],
      ),
    );
  }
}
