import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../presentation/agent/listings/archivedlisting/controllers/archived_controller.dart';
import '../../../repository/user.dart';

class ArchivedItems extends StatelessWidget {
  final Listing listing;
  final int index;
  final Function() onTap;
  final Function(int index) onLongPress;

  const ArchivedItems({
    super.key,
    required this.index,
    required this.onTap,
    required this.onLongPress,
    required this.listing,
  });

  @override
  Widget build(BuildContext context) {
    final ArchivedController archivedC = Get.find();
    return GestureDetector(
      onTap: () {
        if (archivedC.selectionModeActive.value) {
          archivedC.toggleSelection(index);
        } else {
          onTap();
        }
      },
      onLongPress: () {
        archivedC.enterSelectionMode();
        archivedC.toggleSelection(index);
        onLongPress(index);
      },
      child: Stack(
        children: [
          Card(
            color: AppColors.white,
            elevation: 7,
            child: Row(
              children: [
                CloudStorage().imageLoader(
                  ref : '${listing.photos != null ? (listing.photos!.isNotEmpty ? listing.photos!.first : AppStrings.noUserImageWhite) : AppStrings.noUserImageWhite}',
                  width: 100.w,
                  height: Get.height,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: EraUser().getById(listing.by),
                        builder: (context, AsyncSnapshot<EraUser> snapshot) {
                          if (snapshot.hasData) {
                            return EraText(
                              text:
                                  '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
                              color: AppColors.blue,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      EraText(
                        text: listing.type!,
                        color: AppColors.black,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 5.h),
                      Container(
                        width: 200.w,
                        child: EraText(
                          text: listing.description ?? "No Description",
                          color: AppColors.black,
                          fontSize: 12.sp,
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            return archivedC.isSelected(index)
                ? Positioned(
                    top: 5.w,
                    right: 5.w,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: AppColors.white,
                      child: Icon(
                        Icons.check_circle,
                        color: AppColors.black,
                      ),
                    ),
                  )
                : SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}
