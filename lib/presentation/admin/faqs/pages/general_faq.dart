import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
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
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.faqs.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: EraText(
                        text: controller.faqs[index]['title'] ?? '',
                        color: AppColors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: Text(controller.faqs[index]['answer'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Get.dialog(
                                  _buildEditFAQDialog(index, controller));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              controller.faqRemove(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
      content: Column(
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
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            controller.addFAQ();

            Get.back();
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget _buildEditFAQDialog(int index, FaqsController controller) {
    final currentFAQ = controller.faqs[index];
    controller.typeController.text = currentFAQ['type']!;
    controller.titleController.text = currentFAQ['title']!;
    controller.answerController.text = currentFAQ['answer']!;
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
            controller.editFAQ(index);

            Get.back();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
