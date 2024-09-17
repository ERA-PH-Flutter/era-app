import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/settingAgent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../presentation/agent/agents/pages/agentsDashBoard.dart';
import '../../constants/sized_box.dart';
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
            width: 100.w,
            height: 110.h,
            borderRadius: BorderRadius.circular(8.0),
            ref: imageProvider),
        Padding(
          padding: EdgeInsets.only(left: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              agentText(
                '$firstName $lastName',
                AppColors.blue,
                18.sp,
                FontWeight.bold,
                1.2,
              ),
              sbw90(),
              agentText(
                role!.toUpperCase(),
                AppColors.black,
                12.sp,
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
                color: AppColors.kRedColor,
                text: email,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget agentContact(
      {String? iconPath, String? text, void Function()? onTap, Color? color}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(right: 8.w, top: 8.h, bottom: 8.h),
        decoration: BoxDecoration(
            color: AppColors.subtle, borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Image.asset(
              color: color,
              iconPath!,
              width: 20.w,
              height: 20.h,
            ),
            sbw5(),
            Container(
              width: 190.w,
              child: EraText(
                text: text!,
                fontSize: 12.sp,
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
