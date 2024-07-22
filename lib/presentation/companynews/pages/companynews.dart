import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/company_grid.dart';
import 'package:eraphilippines/app/widgets/companygrid_page.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CompanyNews extends GetView<HomeController> {
  const CompanyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: EraText(
                    text: 'LATEST NEWS AND EVENTS FROM ERA PHILIPPINES',
                    color: AppColors.blue,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                  ),
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
