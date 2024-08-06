import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/presentation/agents/pages/agentsDashBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentsAllListings extends StatelessWidget {
  final RealEstateListing agentInfo;
  final Function()? onTap;

  const AgentsAllListings({super.key, required this.agentInfo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          '${agentInfo.user.image}',
          width: 100.w,
          height: 110.h,
        ),
        Padding(
          padding: EdgeInsets.only(top: 5.w, left: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AgentDashBoard.agentText(
                  '${agentInfo.user.firstname} ${agentInfo.user.lastname}',
                  AppColors.blue,
                  18.sp,
                  FontWeight.bold,
                  1.2),
              AgentDashBoard.agentText('${agentInfo.user.role}',
                  AppColors.black, 12.sp, FontWeight.w400, 0.9),
              AgentDashBoard.agentContact(
                  AppEraAssets.whatsappIcon, '${agentInfo.user.whatsApp}'),
              AgentDashBoard.agentContact(
                  AppEraAssets.emailIcon, '${agentInfo.user.email}'),
            ],
          ),
        ),
      ],
    );
  }
}
