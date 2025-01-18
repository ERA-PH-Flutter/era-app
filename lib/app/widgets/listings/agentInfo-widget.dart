import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/sized_box.dart';
import '../../constants/theme.dart';
import '../app_text.dart';

class AgentInfoWidget {
  // ignore: unnecessary_brace_in_string_interps

  static Widget agentInformation({
    imageProvider,
    String? firstName,
    String? lastName,
    String? whatsApp,
    String? email,
    String? role,
  }) {
    final Uri whatsAppUrl2 = Uri.parse('https://wa.me/$whatsApp');

    final Uri emailUrl =
        Uri.parse('mailto:$email?subject=Your%20Subject&body=Your%20Message');
    return Row(
      children: [
        CloudStorage().imageLoaderProvider(
            width: 200.w,
            height: 220.h,
            borderRadius: BorderRadius.circular(8.0),
            reference: imageProvider),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              agentText(
                '$firstName $lastName',
                AppColors.blue,
                EraTheme.h2,
                FontWeight.bold,
                1.2,
              ),
              sbw90(),
              agentText(
                role!.toUpperCase(),
                AppColors.black,
                EraTheme.h4,
                FontWeight.w400,
                0.9,
              ),
              sb5(),
              agentContact(
                onTap: () => launchUrl(whatsAppUrl2),
                iconPath: AppEraAssets.whatsappIcon,
                text: whatsApp,
              ),
              sb3(),
              agentContact(
                onTap: () => launchUrl(emailUrl),
                iconPath: AppEraAssets.emailIcon,
                text: email,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget agentInformationWeb({
    imageProvider,
    String? firstName,
    String? lastName,
    String? whatsApp,
    String? email,
    String? role,
  }) {
    final Uri whatsAppUrl2 = Uri.parse('https://wa.me/$whatsApp');
    final Uri emailUrl =
        Uri.parse('mailto:$email?subject=Your%20Subject&body=Your%20Message');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CloudStorage().imageLoaderProvider(
          width: 200.w,
          height: 220.h,
          borderRadius: BorderRadius.circular(10.0),
          reference: imageProvider,
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              agentText(
                '$firstName $lastName',
                AppColors.blue,
                EraTheme.paragraphWeb,
                FontWeight.bold,
                1.2,
              ),
              SizedBox(height: 10.h),
              agentText(
                role!.toUpperCase(),
                AppColors.black,
                EraTheme.paragraphWeb - 10.sp,
                FontWeight.w400,
                0.9,
              ),
              SizedBox(height: 15.h),
              agentContact(
                onTap: () => launchUrl(whatsAppUrl2),
                iconPath: AppEraAssets.whatsappIcon,
                text: whatsApp,
                width: 40.w,
                height: 40.h,
              ),
              SizedBox(height: 15.h),
              agentContact(
                onTap: () => launchUrl(emailUrl),
                iconPath: AppEraAssets.emailIcon,
                text: email,
                width: 40.w,
                height: 40.h,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget agentContact(
      {String? iconPath,
      String? text,
      void Function()? onTap,
      Color? color,
      width,
      height}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w, right: 10.w),
        decoration: BoxDecoration(
            color: AppColors.subtle, borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Image.asset(
              color: color,
              iconPath!,
              width: width,
              height: height,
            ),
            sbw5(),
            SizedBox(
              width: 250.w,
              child: EraText(
                text: text!,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget agentText(String text, Color color, double fontSize,
      FontWeight fontWeight, double lineHeight) {
    return EraText(
      text: text,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      lineHeight: lineHeight,
    );
  }
}
