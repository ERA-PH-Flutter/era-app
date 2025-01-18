import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/controllers/archived_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../app/constants/screens.dart';
import '../../../../../../app/widgets/archived/archivedItems_widgets.dart';
import '../../../../../global.dart';
import '../../../../landingpage/controller/homs_controller.dart';

class ArchivedWeb extends GetView<ArchivedWebController> {
  const ArchivedWeb({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() => switch (controller.archiveState.value) {
            ArchiveState.loading => _loading(),
            ArchiveState.loaded => _loaded(),
            ArchiveState.empty => _empty(),
            ArchiveState.error => _error()
          }),
    );
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(Icons.arrow_back_ios)),
              EraText(
                  text: 'ARCHIVED LISTINGS',
                  fontSize: EraTheme.h2,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600),
            ],
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Column(
          children: [
            Obx(() {
              return controller.anyItemSelected
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side:
                                  BorderSide(color: AppColors.black, width: 1),
                            ),
                            onPressed: () {},
                            icon: Icon(CupertinoIcons.refresh,
                                color: AppColors.black, size: 20.sp),
                            label: EraText(
                              text:
                                  'REACTIVATE (${controller.selectedItems.length})',
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side:
                                  BorderSide(color: AppColors.black, width: 1),
                            ),
                            onPressed: () {
                              controller.clearSelection();
                            },
                            icon: Icon(Icons.clear,
                                color: AppColors.black, size: 20.sp),
                            label: EraText(
                              text: 'CLEAR',
                              color: AppColors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox.shrink();
            }),
            SizedBox(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 190.h,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                ),
                itemCount: controller.archiveListings.length,
                itemBuilder: (context, i) => ArchivedItems(
                  index: i,
                  onLongPress: (index) {
                    print('Listing at index $index selected for reactivation');
                  },
                  listing: controller.archiveListings[i],

                  // agent: listingModels[i].by,
                  //    type: listingModels[i].type,
                  onTap: () async {
                    listingArgument = controller.archiveListings[i];
                    selectedIndex.value = 11;
                    Get.find<HomsController>().onNavbarItemSelected(11);
                    // Get.toNamed('/propertyInfo',
                    //     arguments: controller.favoritesList[i]);
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  _loading() {
    return Screens.loading();
  }

  _error() {
    return Center(
      child: EraText(
        text: "Something went Wrong!",
        color: Colors.black,
      ),
    );
  }

  _empty() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                     Get.toNamed('/agent-dashboard');
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.black,
                    size: 20.sp,
                  )),
            ],
          ),
          Center(
            child: EraText(
              text: "No Archived Listing Found!",
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
