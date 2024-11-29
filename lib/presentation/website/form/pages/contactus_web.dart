import 'dart:io';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/presentation/website/form/controllers/form_web_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';
import 'about_us_web.dart';

class ContactUsWeb extends GetView<FormWebController> {
  const ContactUsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FormWebController());
    return Container(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AppEraAssets.bgWeb), fit: BoxFit.cover),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sb20(),
            // Contact Us Title with Icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EraText(
                  text: "Contact Us",
                  fontSize: EraTheme.headerWeb,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue,
                ),
                sbw10(),
                Icon(
                  Icons.phone,
                  color: AppColors.blue,
                  size: 80,
                ),
              ],
            ),
            sb20(),
            // Description Text
            EraText(
              text:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non congue libero. Nullam eget odio nisl. In vitae nisi dapibus, mollis enim eget, efficitur est. Morbi euismod leo id nisl consectetur, nec vehicula nunc placerat. Phasellus dictum nibh eleifend sapien egestas, at elementum velit faucibus. Sed ullamcorper lectus ac sapien aliquam, non hendrerit eros ullamcorper.",
              fontSize: EraTheme.paragraphWeb - 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            sb20(),

            // Split the screen into two parts for "Find Us" and "Contacts"
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: findUsWeb(),
                ),
                SizedBox(width: 20.w), // Add space between the columns
                Expanded(
                  flex: 1,
                  child: contactsWeb(),
                ),
              ],
            ),
            sb10(),
            // Join Us section at the bottom
            AboutUsWeb.joinUs(),
          ],
        ),
      ),
    );
  }

  // Contacts Section
  Widget contactsWeb() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SharedWidgets.textFormfield(
          hintText: 'Full Name',
          controller: controller.nameC,
          keyboardType: TextInputType.text,
        ),
        SharedWidgets.textFormfield(
          controller: controller.emailAC,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        SharedWidgets.dropDown(
          controller.selectedSubj,
          controller.subject,
          (value) {
            controller.selectedSubj.value = value;
          },
          '',
          'Select Subject Type',
        ),
        SharedWidgets.textFormfield(
          controller: controller.messageC,
          hintText: 'Type your message here',
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
        sb30(),
        Button.button2(
          Get.width,
          53.h,
          () async {
            await controller.submitContact();
          },
          'Send',
        ),
        sb30(),
      ],
    );
  }

  // Find Us Section
  Widget findUsWeb() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Visit ERA Philippines to learn more about this project.',
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor,
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.only(
              left: 8.w,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppEraAssets.markerIcon,
                  width: 50.w,
                  height: 50.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                EraText(
                  text:
                      '1212 Century Spire Bldg. Century City,\nKalayaan Ave. Makati City',
                  fontSize: 17.sp,
                  color: AppColors.black,
                  maxLines: 2,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          GestureDetector(
            onTap: () {
              launchUrl(controller.whatsappUrl);
            },
            child: Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                    child: Image.asset(
                      AppEraAssets.whatsappIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: '+639177710572',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          sb10(),
          GestureDetector(
            onTap: () {
              launchUrl(controller.emailUrl);
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
                    child: Image.asset(
                      color: AppColors.kRedColor,
                      AppEraAssets.emailIcon,
                      width: 40.w,
                      height: 40.h,
                    ),
                  ),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: 'sales@eraphilippines.com',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
        ],
      ),
    );
  }
}
