import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/pieChart.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/MortageCalculator_controller.dart';

class MortageCalculator extends GetView<MortageCalculatorController> {
  const MortageCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'MORTGAGE CALCULATOR',
                fontSize: 25.sp,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 15.h),
              Container(
                height: 330.h,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.kRedColor.withOpacity(0.7), width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: EraText(
                        text: 'Mortgage Payment Breakdown',
                        fontSize: 18.sp,
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    Piechart(),
                  ],
                ),
              ),
              SizedBox(height: 30.h),
              EraText(
                text: 'Property Amount',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              TextformfieldWidget(
                hintText: 'eg: 100000.00',
                maxLines: 1,
              ),
              SizedBox(height: 10),
              EraText(
                text: 'Down Payment',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              TextformfieldWidget(
                hintText: 'eg: 10000.00',
                maxLines: 1,
              ),
              SizedBox(height: 10),
              EraText(
                text: 'Loan Term',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              TextformfieldWidget(
                hintText: 'eg:30',
                maxLines: 1,
              ),
              SizedBox(height: 10),
              EraText(
                text: 'Interest Rate',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              TextformfieldWidget(
                hintText: 'eg: 5.000',
                maxLines: 1,
              ),
              SizedBox(height: 10),
              EraText(
                text: 'Monthly Payment',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              TextformfieldWidget(
                hintText: 'eg: 20000.00',
                maxLines: 1,
              ),
              SizedBox(height: 40),
              Button(
                margin: EdgeInsets.symmetric(horizontal: 0),
                width: 350.w,
                bgColor: AppColors.kRedColor,
                text: 'CALCULATE',
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                onTap: () {},
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
