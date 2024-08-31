import 'package:eraphilippines/app.dart';
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
          return favC.selectionModeActive.value
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          var selectedListings = [];
                          favC.selectedItems.forEach((selected){
                            selectedListings.add(listingModels[selected]);
                          });
                          print(selectedListings);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(color: AppColors.hint),
                          backgroundColor: AppColors.white,
                          elevation: 2,
                        ),
                        label: EraText(
                          text:
                              'GENERATE PDF ( ${favC.selectedItems.length} selected )',
                          color: AppColors.blue,
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton.icon(
                        onPressed: () {
                          favC.exitSelectionMode();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          side: BorderSide(color: AppColors.hint),
                          backgroundColor: AppColors.white,
                          elevation: 2,
                        ),
                        label: EraText(
                          text: 'CANCEL',
                          color: AppColors.blue,
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
              mainAxisExtent: 150,
              mainAxisSpacing: 5,
            ),
            itemCount: listingModels.length,
            itemBuilder: (context, i) => Obx(() {
              return Stack(
                children: [
                  FavItems(
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
                  ),
                  if (favC.selectionModeActive.value)
                    GestureDetector(
                      onTap: () => favC.toggleSelection(i),
                      child: Container(
                          decoration: BoxDecoration(
                        borderRadius: favC.isSelected(i)
                            ? BorderRadius.circular(10)
                            : null,
                        border: Border.all(
                          color: favC.isSelected(i)
                              ? AppColors.kRedColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      )),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
