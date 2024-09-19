import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/contact_us/controller/contact_us_admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/theme.dart';

class ContactUsAdmin extends GetView<ContactUsAController> {
  const ContactUsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ContactUsAController controller = Get.put(ContactUsAController());
    return SingleChildScrollView(
      child: Container(
        //remove the fixed height since it's causing the overflow
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
                  text: 'Contact Us Management',
                  color: AppColors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            ExpansionTile(
              title: EraText(
                text: 'SEE DETAILS OF CONTACT US',
                color: AppColors.black,
              ),
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.addSellProperty();
                  },
                  child: EraText(
                    text: 'add contact us',
                    color: AppColors.black,
                  ),
                ),
                sb10(),
                Obx(() {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.contactusInfo.length,
                    itemBuilder: (context, index) {
                      final property = controller.contactusInfo[index];
                      return ExpansionTile(
                        title: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  controller.contactusRemove(index);
                                },
                                icon: Icon(Icons.delete)),
                            EraText(
                              text: 'Contact ${index + 1}',
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        children: [
                          _builTextField('Name: ${property['name']}', 1),
                          _builTextField('Phone: ${property['phone']}', 1),
                          _builTextField('Email: ${property['email']}', 1),
                          _builTextField(
                              'Subject Type: ${property['subjectType']}', 10),
                          _builTextField('Message: ${property['message']}', 10),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
            sb50(),
          ],
        ),
      ),
    );
  }

  Widget _builTextField(text, maxLines) {
    return ListTile(
      title: Expanded(
        child: EraText(
          text: text,
          maxLines: maxLines,
          color: AppColors.black,
        ),
      ),
    );
  }
}
