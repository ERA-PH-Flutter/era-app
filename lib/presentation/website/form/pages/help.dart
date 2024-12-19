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
import 'about_us_web.dart';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  EraText(
                    text:
                        '${user != null ? '${DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'} ${user!.firstname}'.capitalize : DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon, Hannah' : 'Good Evening, Hannah'}',
                    fontSize: EraTheme.headerWeb,
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
                      child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 60.h,
                          child: AppTextField(
                              hint: 'Use AI Search',
                              svgIcon: AppEraAssets.ai3,
                              bgColor: AppColors.white,
                              isSuffix: true,
                              obscureText: false,
                              suffixIcons: AppEraAssets.send),
                        ),
                      ],
                    ),
                  )),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            sb80(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildCard(
                    icon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.email,
                          color: AppColors.kRedColor,
                        )),
                    title: 'Send Us an Email',
                    subtitle: 'We’re here to assist you',
                    text: 'sales@eraphilippines.com',
                  ),
                ),
                sbw15(),
                Expanded(
                  flex: 1,
                  child: _buildCard(
                    icon: Image.asset(
                      color: AppColors.green,
                      AppEraAssets.whatsAppIcon3,
                    ),
                    //  icon2: AppEraAssets.whatsappIcon,
                    title: 'Message Us on WhatsApp',
                    subtitle: 'Chat directly with our team',
                    text: '+63 917 771 0572',
                  ),
                ),
                sbw15(),
                Expanded(
                  flex: 1,
                  child: _buildCard(
                    icon: IconButton(
                      onPressed: () {
                        launchUrl(controller.whatsappUrl);
                      },
                      icon: Icon(Icons.location_city),
                      color: AppColors.black,
                    ),
                    title: 'Drop By Our Office',
                    subtitle: 'We’d love to meet you in person',
                    text: 'Find us on Google Maps',
                  ),
                ),
                sbw15(),
                Expanded(
                  flex: 1,
                  child: _buildCard(
                    icon: IconButton(
                      onPressed: () {
                        launchUrl(controller.whatsappUrl);
                      },
                      icon: Icon(Icons.call),
                      color: AppColors.blue,
                    ),
                    title: 'Give Us a Call',
                    subtitle: 'Available Mon-Fri, 8 AM to 5 PM',
                    text: '+63 917 771 0572',
                  ),
                ),
              ],
            ),
            sb80(),
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
            AboutUsWeb.joinUs(),
            // EraText(
            //   text: 'Reach Out to Us!',
            //   fontSize: EraTheme.headerWeb,
            //   color: AppColors.black,
            //   fontWeight: FontWeight.bold,
            // ),

            // iconButton(
            //   icon: AppEraAssets.whatsappIcon,
            //   icon2: AppEraAssets.emailIcon,
            // ),
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
            text: 'Frequently Asked Questions',
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
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.kRedColor,
              borderRadius: BorderRadius.circular(99),
            ),
            child: GestureDetector(
              onTap: () async {
                //launchUrl(controller.whatsappUrl);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                alignment: Alignment.center,
                height: EraTheme.buttonH60,
                child: Center(
                  child: EraText(
                    text: 'CONTACT US VIA EMAIL',
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          sbw10(),
          Container(
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(99),
            ),
            child: GestureDetector(
              onTap: () async {
                launchUrl(controller.whatsappUrl);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                alignment: Alignment.center,
                height: EraTheme.buttonH60,
                child: Center(
                  child: EraText(
                    text: 'CONTACT US VIA WHATSAPP',
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
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

  Widget _buildCard({
    Widget? icon,
    String? title,
    String? subtitle,
    String? text,
  }) {
    return Container(
      child: Card(
        elevation: 7,
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 20.h, left: 20.w, bottom: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(elevation: 7, color: AppColors.white, child: icon!),
              sb80(),
              EraText(
                text: title!,
                fontSize: EraTheme.paragraphWeb,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
              EraText(
                text: subtitle!,
                fontSize: 15.sp,
                color: AppColors.hint,
              ),
              sb30(),
              EraText(
                text: text!,
                fontSize: 15.sp,
                color: AppColors.black,
                lineHeight: 1,
                textDecoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
