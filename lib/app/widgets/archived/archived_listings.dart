import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/archived/archivedItems_widgets.dart';
import 'package:eraphilippines/presentation/agent/archivedlisting/controllers/archived_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ArchivedListings extends StatelessWidget {
  final List<RealEstateListing> listingModels;

  const ArchivedListings({super.key, required this.listingModels});

  @override
  Widget build(BuildContext context) {
    final ArchivedController archivedC = Get.put(ArchivedController());
    return Column(
      children: [
        Obx(() {
          return archivedC.anyItemSelected
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
                          side: BorderSide(color: AppColors.black, width: 1),
                        ),
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.refresh,
                            color: AppColors.black, size: 20.sp),
                        label: EraText(
                          text:
                              'REACTIVATE (${archivedC.selectedItems.length})',
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
                          side: BorderSide(color: AppColors.black, width: 1),
                        ),
                        onPressed: () {
                          archivedC.clearSelection();
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
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(10),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                mainAxisExtent: 120.h,
                mainAxisSpacing: 10.h),
            itemCount: listingModels.length,
            itemBuilder: (context, i) => ArchivedItems(
              index: i,
              onLongPress: (index) {
                print('Listing at index $index selected for reactivation');
              },
              agentImage: '${listingModels[i].user.image}',
              agentFirstName: '${listingModels[i].user.firstname}',
              agentLastName: '${listingModels[i].user.lastname}',
              type: listingModels[i].type,
              onTap: () {
                Get.toNamed('/propertyInfo', arguments: listingModels[i]);
              },
            ),
          ),
        ),
      ],
    );
  }
}