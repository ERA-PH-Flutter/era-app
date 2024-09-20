import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/repository/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/theme.dart';
import '../controller/faqs_controller.dart';

class GeneralFaq extends GetView<FaqsController> {
  const GeneralFaq({super.key});

  @override
  Widget build(BuildContext context) {
    FaqsController controller = Get.put(FaqsController());
    return SingleChildScrollView(
      child: Container(
        height: Get.height - 150.h,
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                EraText(
                  text: 'FAQs Management',
                  color: AppColors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    controller.typeController.clear();
                    controller.titleController.clear();
                    controller.answerController.clear();
                    Get.dialog(_buildAddFAQDialog(controller));
                  },
                ),
              ],
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('faq').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var faq = FAQ.fromJSON(data[index].data());
                      return Card(
                        child: ListTile(
                          title: EraText(
                            text: faq.question!,
                            color: AppColors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                          subtitle: Text(faq.answer ?? ''),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Get.dialog(_buildEditFAQDialog(faq));
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () async {
                                  await faq.deleteFAQ();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddFAQDialog(FaqsController controller) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Add FAQ'),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.r)),
        width: 500.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller.typeController,
              decoration: InputDecoration(hintText: 'Enter Type'),
            ),
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(hintText: 'Enter title'),
            ),
            TextField(
              controller: controller.answerController,
              decoration: InputDecoration(hintText: 'Enter answer'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            await FAQ(
                    type: controller.typeController.text,
                    question: controller.titleController.text,
                    answer: controller.answerController.text)
                .addFAQ();
            Get.back();
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget _buildEditFAQDialog(FAQ faq) {
    controller.typeController.text = faq.type!;
    controller.titleController.text = faq.question!;
    controller.answerController.text = faq.answer!;
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text('Edit FAQ'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller.typeController,
            // controller:    controller.typeController.text = controller.faqs['type']!,
            decoration: InputDecoration(
              hintText: 'Edit Type',
              labelText: 'Type',
            ),
          ),
          TextField(
            controller: controller.titleController,
            decoration: InputDecoration(
              hintText: 'Edit Title',
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: controller.answerController,
            decoration: InputDecoration(
              hintText: 'Edit Answer',
              labelText: 'Answer',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            faq.answer = controller.answerController.text;
            faq.question = controller.titleController.text;
            faq.type = controller.typeController.text;
            faq.updateFAQ();
            Get.back();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
