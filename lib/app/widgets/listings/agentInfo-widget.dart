import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../presentation/agent/agents/pages/agentsDashBoard.dart';

class AgentInfoWidget {
  static Widget agentInformation( imageProvider, String firstName,
      String lastName, String whatsApp, String email, String role) {
    return Row(
      children: [
        CloudStorage().imageLoaderProvider(
          width: 100.w,
          height: 110.h,
          borderRadius: BorderRadius.circular(8.0),
          ref: imageProvider
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AgentDashBoard.agentText('$firstName $lastName', AppColors.blue,
                  18.sp, FontWeight.bold, 1.2),
              AgentDashBoard.agentText(role.toUpperCase(), AppColors.black,
                  12.sp, FontWeight.w400, 0.9),
              AgentDashBoard.agentContact(AppEraAssets.whatsappIcon, whatsApp),
              AgentDashBoard.agentContact(AppEraAssets.emailIcon, email),
            ],
          ),
        ),
      ],
    );
  }
}
