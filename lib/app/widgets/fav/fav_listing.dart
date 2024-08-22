import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/fav/favItems_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/presentation/agent/favorites/controllers/fav_controller.dart';

class FavListing extends StatelessWidget {
  final List listingModels;

  FavListing({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    final FavController favC = Get.put(FavController());

    return Column(
      children: [
        Obx(() {
          return favC.anyItemSelected
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(color: AppColors.black, width: 1),
                          ),
                          onPressed: () {
                            favC.removeSelectedFavorites();
                          },
                          icon: Icon(CupertinoIcons.refresh,
                              color: AppColors.black, size: 20.sp),
                          label: EraText(
                            text:
                                'REMOVE FROM FAVORITES (${favC.selectedItems.length})',
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink();
        }),
        SizedBox(
          child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(10),
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 120,
              ),
              itemCount: listingModels.length,
              itemBuilder: (context, i) => FavItems(
                    listing: listingModels[i],
                    index: i,
                    onTap: () {
                      if (favC.selectionModeActive.value) {
                        favC.toggleSelection(i);
                      } else {
                        Get.toNamed('/propertyInfo',
                            arguments: listingModels[i]);
                      }
                    },
                    onLongPress: (index) {
                      favC.toggleSelection(index);
                    },
                  )),
        ),
      ],
    );
  }
}
