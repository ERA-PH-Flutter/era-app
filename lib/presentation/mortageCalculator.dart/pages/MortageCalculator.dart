import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/pieChart.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MortageCalculator extends GetView<HomeController> {
  const MortageCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(height: 50),
          Button(
            margin: EdgeInsets.symmetric(horizontal: 0),
            width: 350.w,
            bgColor: AppColors.kRedColor,
            text: 'CALCULATE',
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
