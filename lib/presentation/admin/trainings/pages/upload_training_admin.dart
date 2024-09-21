import 'package:eraphilippines/presentation/admin/trainings/controller/trainings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/app_text.dart';
import '../../../../app/widgets/button.dart';

class UploadTrainingAdmin extends GetView<TrainingController> {
  const UploadTrainingAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    TrainingController controller = Get.put(TrainingController());

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: EraTheme.paddingWidthAdmin),
                child: EraText(
                  text: 'Training Management',
                  color: AppColors.black,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: EraText(text: 'UPLOAD TRAINING', color: AppColors.black),
            children: [
              _builTextField(
                'Enter Title',
                controller.titleController,
                1,
              ),
              _builTextField(
                'Enter Description',
                controller.descController,
                10,
              ),
              _builTextField(
                  'Enter Video URL', controller.videoUrlController, 1),

              sb20(),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.white),
                ),
                onPressed: () {
                  controller.addToPreview(
                    controller.titleController.text,
                    controller.descController.text,
                    controller.videoUrlController.text,
                  );
                  controller.titleController.clear();
                  controller.descController.clear();
                  controller.videoUrlController.clear();
                },
                child: EraText(
                  text: 'SUMBIT TRAINING',
                  color: AppColors.black,
                ),
              ),
              sb20(),
              EraText(
                text: 'UPCOMING TRAINING TO SUMBIT',
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.previewTraining.length,
                  itemBuilder: (context, index) {
                    final preview = controller.previewTraining[index];
                    return ExpansionTile(
                      title: EraText(
                        text: 'UPCOMING TRAINING ${index + 1}',
                        color: AppColors.black,
                      ),
                      trailing: SizedBox(
                        width: 150.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Button(
                              onTap: () {
                                controller.addTrainings();
                                controller.clearPreview();
                              },
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: 80.w,
                              text: 'SUBMIT',
                              bgColor: AppColors.blue,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.previewremoveAt(index);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      children: [
                        EraText(
                          text: 'Title: ${preview['title']}',
                          color: AppColors.black,
                        ),
                        EraText(
                          text: 'Description: ${preview['desc']}',
                          color: AppColors.black,
                        ),
                        EraText(
                          text: 'Video URL: ${preview['videoUrl']}',
                          color: AppColors.black,
                        ),
                      ],
                    );
                  },
                );
              }),
              // Obx(() {
              //   if (controller.youtubePlayerController.value == null) {
              //     return Text('');
              //   }
              //   return YoutubePlayer(
              //     actionsPadding: EdgeInsets.only(
              //         left: 20.w, right: 20.w, top: 50.h, bottom: 50.h),
              //     controller: controller.youtubePlayerController.value!,
              //     showVideoProgressIndicator: true,
              //     progressIndicatorColor: Colors.blueAccent,
              //   );
              // }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _builTextField(
      String labelText, TextEditingController controller, maxLines) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: maxLines,
        controller: controller,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
