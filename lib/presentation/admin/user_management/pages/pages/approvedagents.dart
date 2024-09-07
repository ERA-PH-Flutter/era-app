import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/agentapproval_gridview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApprovedAgents extends StatelessWidget {
  ApprovedAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          EraText(
            text: 'AGENT NEW APPROVAL',
            color: AppColors.black,
            fontSize: 25.sp,
          ),
          AgentapprovalGridview(
            listing: RealEstateListing.listingsModels,
          ),
        ],
      ),
    );
  }

  //example of model
}
