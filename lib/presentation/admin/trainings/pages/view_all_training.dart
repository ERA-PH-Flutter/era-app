import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/trainings/controller/trainings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ViewAllTraining extends GetView<TrainingController> {
  const ViewAllTraining({super.key});

  @override
  Widget build(BuildContext context) {
    TrainingController controller = Get.put(TrainingController());

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin),
            child: EraText(
              text: 'AVAILABLE TRAININGS',
              fontWeight: FontWeight.bold,
              color: AppColors.black,
              fontSize: 30.sp,
            ),
          ),
          Obx(() {
            return GridView.builder(
              shrinkWrap: true,
              itemCount: controller.training.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Card(
                    child: Column(
                  children: [
                    EraText(
                        text: controller.training[index]['title'] ?? '',
                        color: AppColors.black),
                    //video im not sure how to display it
                    EraText(
                        text: controller.training[index]['desc'] ?? '',
                        color: AppColors.black),
                  ],
                ));
              },
            );
          })
        ],
      ),
    );
  }
}
