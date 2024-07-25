import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/agents_models.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
 import 'package:eraphilippines/app/widgets/agentlistview.dart';

import 'package:eraphilippines/app/widgets/agents_items.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentProfile extends StatelessWidget {
  const AgentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'AGENT PROFILE',
                fontSize: 25.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
              SizedBox(height: 60.h),
              AgentListView(agentsModels: AgentsModels.agentsModels),
              SizedBox(height: 20.h),
              Center(
                child: EraText(
                  text: 'LISTED PROPERTIES',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kRedColor,
                ),
              ),
              SizedBox(height: 10.h),
              FindingProperties(
                listingModels: RealEstateListing.listingsModels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
