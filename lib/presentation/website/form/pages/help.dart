import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/constants/sized_box.dart';
import '../controllers/form_web_controller.dart';

class HelpWeb extends GetView<FormWebController> {
  const HelpWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
        child: Column(
          children: [
            Container(
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage(AppEraAssets.bgWeb),
              //   fit: BoxFit.cover,
              // )),
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidthAdmin * 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text:
                        '${user != null ? '${DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'} ${user!.firstname}'.capitalize : DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'}',
                    fontSize: EraTheme.subHeaderWeb,
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  EraText(
                    text: 'What do you want to know?',
                    fontSize: EraTheme.paragraphWeb,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.w600,
                  ),
                  sb40(),
                  BoxWidget.build(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        AppTextField(
                          hint: 'AI Search',
                          svgIcon: AppEraAssets.ai3,
                          bgColor: AppColors.white,
                          //  controller: controller.aiSearch,
                        ),
                        SizedBox(height: 10.h),
                        SearchWidget.build(() async {}),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            faqTitle(),
            SizedBox(height: 20.h),
            Obx(() {
              List<Widget> faqWidgets = [];
              var lastType = '';
              for (int i = 0; i < controller.faqs.length; i++) {
                if (lastType != controller.faqs[i].data()['type']) {
                  lastType = controller.faqs[i].data()['type'];
                  faqWidgets.add(Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      EraText(
                        text: controller.faqs[i].data()['type'],
                        fontSize: EraTheme.subHeaderWeb,
                        color: AppColors.kRedColor,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 20.h),
                      expansionTile(controller.faqs[i].data()['question'],
                          controller.faqs[i].data()['answer']),
                      SizedBox(height: 15.h),
                    ],
                  ));
                } else {
                  faqWidgets.add(Column(
                    children: [
                      expansionTile(controller.faqs[i].data()['question'],
                          controller.faqs[i].data()['answer']),
                      SizedBox(height: 15.h),
                    ],
                  )); 
                }
              }
              return Column(
                children: faqWidgets,
              );
            }),
            sb50(),
            iconButton(
              icon: AppEraAssets.whatsappIcon,
              icon2: AppEraAssets.emailIcon,
            ),
            sb50(),
          ],
        ),
      ),
    );
  }

  Widget faqTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
            textAlign: TextAlign.start,
            text: 'FAQs',
            fontSize: EraTheme.headerWeb,
            color: AppColors.blue,
            fontWeight: FontWeight.bold),
        Divider(
          color: AppColors.black,
          thickness: 2,
        ),
      ],
    );
  }

  Widget iconButton({
    required String icon,
    required String icon2,
    EdgeInsets? padding,
  }) {
    // final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

    return Container(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              //launchUrl(controller.whatsappUrl);
            },
            child: Container(
              alignment: Alignment.center,
              width: Get.width / 2,
              height: EraTheme.buttonHeightSmall + 10.sp,
              decoration: BoxDecoration(
                color: AppColors.kRedColor,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Center(
                child: EraText(
                  text: 'CONTACT US VIA EMAIL',
                  fontSize: EraTheme.paragraphWeb,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          sb20(),
          GestureDetector(
            onTap: () async {
              launchUrl(controller.whatsappUrl);
            },
            child: Container(
              alignment: Alignment.center,
              width: Get.width / 2,
              height: EraTheme.buttonHeightSmall + 10.sp,
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Center(
                child: EraText(
                  text: 'CONTACT US VIA WHATSAPP',
                  fontSize: EraTheme.paragraphWeb,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget expansionTile(String title, String content) {
    return ExpansionTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: AppColors.hint.withOpacity(0.1),
      collapsedBackgroundColor: AppColors.hint.withOpacity(0.1),
      title: EraText(
        text: title,
        color: AppColors.black,
        fontSize: EraTheme.paragraphWeb,
        fontWeight: FontWeight.w600,
      ),
      children: [
        ListTile(
          title: EraText(
            text: content,
            fontSize: EraTheme.paragraphWeb,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            maxLines: 50,
          ),
        ),
      ],
    );
  }
}
