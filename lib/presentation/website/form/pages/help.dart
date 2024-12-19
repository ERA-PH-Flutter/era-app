import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import '../../../global.dart';
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
            _buildHeader(),
            sb80(),
            _buildContactOptions(),
            sb80(),
            _buildFaqSection(),
            sb50(),
            AboutUsWeb.buildJoinUsSection(),
            sb50(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.blue.withOpacity(0.9),
            AppColors.blue2.withOpacity(0.7),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: EraTheme.paddingWidthAdmin * 5,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EraText(
            text: user != null
                ? '${_greetUser()} ${user!.firstname}'
                : _greetUser(),
            fontSize: 24.sp,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
          sb20(),
          EraText(
            text: 'What do you want to know?',
            fontSize: 18.sp,
            color: AppColors.white.withOpacity(0.9),
          ),
          sb40(),
          BoxWidget.build(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: AppTextField(
                hint: 'Use AI Search',
                svgIcon: AppEraAssets.ai3,
                bgColor: AppColors.white,
                isSuffix: true,
                suffixIcons: AppEraAssets.send,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _greetUser() {
    final hour = DateTime.now().hour;

    if (12 < hour) return 'GoodMorning';
    if (18 < hour) return 'Good Afternoon';
    return 'Good Evening';
  }

  Widget _buildContactOptions() {
    return Wrap(
      spacing: 20.w,
      children: [
        _buildContactCard(
          icon2: Icon(
            Icons.email,
            color: AppColors.kRedColor,
            size: 30,
          ),
          color: AppColors.kRedColor,
          title: 'Email Us',
          subtitle: 'We’re here to assist you',
          text: 'sales@eraphilippines.com',
          onTap: () {
            launchUrl(controller.emailUrl);
          },
        ),
        _buildContactCard(
          icon: AppEraAssets.whatsAppIcon3,
          color: AppColors.green,
          title: 'Message Us on WhatsApp',
          subtitle: 'Chat directly with our team',
          text: '+63 917 771 0572',
          onTap: () => launchUrl(controller.whatsappUrl),
        ),
        _buildContactCard(
          icon2: Icon(
            Icons.location_on,
            color: AppColors.black,
            size: 30,
          ),
          color: AppColors.black,
          title: 'Drop By Our Office',
          subtitle: 'We’d love to meet you in person',
          text: 'Find us on Google Maps',
          onTap: () {},
        ),
        _buildContactCard(
          icon2: Icon(
            Icons.call,
            color: AppColors.blue,
            size: 30,
          ),
          color: AppColors.blue,
          title: 'Give Us a Call',
          subtitle: 'Available Mon-Fri, 8 AM to 5 PM',
          text: '+63 917 771 0572',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildContactCard({
    String? icon,
    Widget? icon2,
    required Color color,
    required String title,
    required String subtitle,
    required String text,
    void Function()? onTap,
  }) {
    return Container(
      width: 300.w,
      height: 300.h,
      padding: EdgeInsets.all(20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.2),
            child: icon != null
                ? Image.asset(
                    icon,
                    height: 50.h,
                    width: 50.w,
                    fit: BoxFit.contain,
                  )
                : icon2,
          ),
          sb20(),
          EraText(
            text: title,
            fontSize: EraTheme.h4,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          sb10(),
          EraText(
            text: subtitle,
            fontSize: EraTheme.h5,
            color: AppColors.hint,
          ),
          sb20(),
          GestureDetector(
            onTap: onTap,
            child: EraText(
              text: text,
              fontSize: EraTheme.h6,
              color: color,
              textDecoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'Frequently Asked Questions',
          fontSize: EraTheme.headerWeb,
          color: AppColors.blue,
          fontWeight: FontWeight.bold,
        ),
        Divider(color: AppColors.black, thickness: 2),
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
                  _buildExpansionTile(
                    controller.faqs[i].data()['question'],
                    controller.faqs[i].data()['answer'],
                  ),
                  SizedBox(height: 15.h),
                ],
              ));
            } else {
              faqWidgets.add(Column(
                children: [
                  _buildExpansionTile(
                    controller.faqs[i].data()['question'],
                    controller.faqs[i].data()['answer'],
                  ),
                  SizedBox(height: 15.h),
                ],
              ));
            }
          }
          return Column(children: faqWidgets);
        }),
      ],
    );
  }

  Widget _buildExpansionTile(String title, String content) {
    return Card(
      color: AppColors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ExpansionTile(
        title: EraText(
          text: title,
          fontSize: EraTheme.h3,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(10.h),
            child: EraText(
              text: content,
              fontSize: EraTheme.h4,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
