import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presentation/agent/agents/pages/agentsDashBoard.dart';

class AgentInfoWidget {
  static Widget agentInformation(String images, String firstName,
      String lastName, String whatsApp, String email, String role) {
    return Row(
      children: [
        Image.asset(
          images,
          width: 100.w,
          height: 110.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AgentDashBoard.agentText('$firstName $lastName', AppColors.blue,
                  18.sp, FontWeight.bold, 1.2),
              AgentDashBoard.agentText(
                  role, AppColors.black, 12.sp, FontWeight.w400, 0.9),
              AgentDashBoard.agentContact(
                  AppEraAssets.whatsappIcon, whatsApp),
              AgentDashBoard.agentContact(AppEraAssets.emailIcon, email),
            ],
          ),
        ),
      ],
    );
  }
}
