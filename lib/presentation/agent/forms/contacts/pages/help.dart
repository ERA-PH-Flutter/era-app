import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../app/constants/sized_box.dart';
import '../../../../../app/services/ai_search.dart';
import '../../../../global.dart';
import '../controllers/contacts_controller.dart';

class Help extends GetView<ContactusController> {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              EraText(
                text:
                    '${user != null ? '${DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'} ${user!.firstname}'.capitalize : DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'}',
                fontSize: 20.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.h),
              EraText(
                text: 'What do you want to know?',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 10.h),
              BoxWidget.build(
                  child: Column(
                children: [
                  SizedBox(height: 10.h),
                  AppTextField(
                    hint: 'AI Search',
                    svgIcon: AppEraAssets.ai3,
                    bgColor: AppColors.white,
                    controller: controller.aiSearch,
                  ),
                  SizedBox(height: 10.h),
                  SearchWidget.build(() async{
                    controller.faqs.value = await AI(query:controller.aiSearch.text).faqSearch();
                  }),
                  SizedBox(height: 10.h),
                ],
              )),
              SizedBox(height: 20.h),
              Obx((){
                List<Widget> faqWidgets = [];
                var lastType = '';
                for(int i = 0;i<controller.faqs.length;i++){
                  if(lastType != controller.faqs[i].data()['type']){
                    lastType = controller.faqs[i].data()['type'];
                    faqWidgets.add(Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: controller.faqs[i].data()['type'],
                          fontSize: 25.sp,
                          color: AppColors.kRedColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 20.h),
                        expansionTile(controller.faqs[i].data()['type'],controller.faqs[i].data()['answer']),
                        SizedBox(height: 15.h),
                      ],
                    ));
                  }else{
                    faqWidgets.add(Column(
                      children: [
                        expansionTile(controller.faqs[i].data()['type'],controller.faqs[i].data()['answer']),
                        SizedBox(height: 15.h),
                      ],
                    ));
                  }
                }
                return Column(
                  children: faqWidgets,
                );
              }),
              iconButton(
                icon: AppEraAssets.whatsappIcon,
                icon2: AppEraAssets.emailIcon,
              ),
              sb90(),
            ],
          ),
        ),
      ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  //launchUrl(controller.whatsappUrl);
                },
                child: Container(
                  width: Get.width - (EraTheme.paddingWidth * 2),
                  height: EraTheme.buttonHeightSmall,
                  decoration: BoxDecoration(
                    color: AppColors.kRedColor,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Center(
                    child: EraText(
                      text: 'CONTACT US VIA EMAIL',
                      fontSize: 18.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  launchUrl(controller.whatsappUrl);
                },
                child: Container(
                  width: Get.width - (EraTheme.paddingWidth * 2),
                  height: EraTheme.buttonHeightSmall,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Center(
                    child: EraText(
                      text: 'CONTACT US VIA WHATSAPP',
                      fontSize: 18.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
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
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      children: [
        ListTile(
          title: EraText(
            text: content,
            fontSize: 18.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
            maxLines: 50,
          ),
        ),
      ],
    );
  }
}
