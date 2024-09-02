import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyNewsPage extends StatelessWidget {
  final CompanyModels companymodelss;

  const CompanyNewsPage({super.key, required this.companymodelss});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: EdgeInsets.all(EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: companymodelss.title,
              color: AppColors.kRedColor,
              fontSize: 23.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 10.h),
            Image.asset(
              companymodelss.image,
              height: 250.h,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.h),
            EraText(
              text: companymodelss.description,
              color: AppColors.black,
              fontSize: 16.sp,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
