import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/agent/archivedlisting/controllers/archived_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../repository/user.dart';

class ArchivedItems extends StatelessWidget {
  final String? agentImage;
  final String? agentFirstName;
  final String? agentLastName;
  final String? agent;
  final String type;
  final int index;
  final Function() onTap;
  final Function(int index) onLongPress;

  const ArchivedItems({
    super.key,
    this.agent,
    this.agentImage,
    this.agentFirstName,
    this.agentLastName,
    required this.type,
    required this.index,
    required this.onTap,
    required this.onLongPress,
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
                CachedNetworkImage(
                  imageUrl: agentImage ?? AppStrings.noUserImageWhite,
                  width: 100.w,
                  height: 100.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h, left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder(
                        future: EraUser().getById(agent),
                        builder: (context,AsyncSnapshot<EraUser> snapshot){
                          if(snapshot.hasData){
                            return EraText(
                              text: '${snapshot.data?.firstname} ${snapshot.data?.lastname}',
                              color: AppColors.blue,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      EraText(
                        text: type,
                        color: AppColors.black,
                        fontSize: 18.sp,
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
