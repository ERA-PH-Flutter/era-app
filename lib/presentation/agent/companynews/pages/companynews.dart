import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/company/companygrid_page.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/companynews_controller.dart';

class CompanyNews extends GetView<CompanyNewsController> {
  const CompanyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                EraText(
                  text: 'LATEST NEWS AND EVENTS FROM ERA PHILIPPINES',
                  color: AppColors.blue,
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CompanyGridPage(
                  companymodels: CompanyModels.companyNewsModels,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
