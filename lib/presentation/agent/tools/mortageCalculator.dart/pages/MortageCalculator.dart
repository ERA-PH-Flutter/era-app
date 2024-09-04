import 'dart:math';

import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/pieChart.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import '../controllers/MortageCalculator_controller.dart';

class MortageCalculator extends GetView<MortageCalculatorController> {
  const MortageCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidth, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'MORTGAGE CALCULATOR',
                fontSize: EraTheme.header,
                color: AppColors.kRedColor,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 15.h),
              Container(
                height: 350.h,
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
                    SizedBox(height: 10.h),
                    Obx(() => Piechart(
                        downPayment: controller.downPayment.text,
                        interestAmount: controller.interestAmount.value,
                        initialAmount: controller.initialAmount.value))
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              EraText(
                text: 'Property Amount',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              SizedBox(height: 10.h),
              TextformfieldWidget(
                onChanged: (value) {
                  value = value.replaceAll(',', '');
                  controller.propertyAmount.text = value.replaceAllMapped(
                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                      (Match m) => '${m[1]},');
                },
                suffixIcon: Align(
                  widthFactor: 1.5,
                  child: Image.asset(
                    AppEraAssets.currency,
                    height: 35.h,
                    color: AppColors.kRedColor,
                  ),
                ),
                hintText: 'eg: 100000.00',
                keyboardType: TextInputType.number,
                controller: controller.propertyAmount,
                maxLines: 1,
              ),
              EraText(
                text: 'Down Payment',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              SizedBox(height: 10.h),
              TextformfieldWidget(
                suffixIcon: Align(
                  widthFactor: 1.5,
                  child: Image.asset(
                    AppEraAssets.percentage,
                    height: 35.h,
                    color: AppColors.kRedColor,
                  ),
                ),
                hintText: 'eg: 10%',
                keyboardType: TextInputType.number,
                controller: controller.downPayment,
                maxLines: 1,
              ),
              EraText(
                text: 'Loan Term',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              SizedBox(height: 10.h),
              TextformfieldWidget(
                onChanged: (value) {},
                suffixIcon: Align(
                  widthFactor: 1.5,
                  child: Image.asset(
                    AppEraAssets.loan,
                    height: 35.h,
                    color: AppColors.kRedColor,
                  ),
                ),
                hintText: 'eg: 10 years',
                keyboardType: TextInputType.number,
                controller: controller.loanTerm,
                maxLines: 1,
              ),
              SizedBox(height: 10.h),
              EraText(
                text: 'Interest Rate',
                fontSize: 20.sp,
                color: AppColors.black,
              ),
              SizedBox(height: 10.h),
              TextformfieldWidget(
                suffixIcon: Align(
                  widthFactor: 1.5,
                  child: Image.asset(
                    AppEraAssets.percentage,
                    height: 35.h,
                    color: AppColors.kRedColor,
                  ),
                ),
                hintText: 'eg: 10%',
                keyboardType: TextInputType.number,
                controller: controller.interestRate,
                maxLines: 1,
              ),
              SizedBox(height: 30.h),
              SizedBox(height: 10.h),
              Button(
                width: Get.width,
                bgColor: AppColors.kRedColor,
                text: 'CALCULATE',
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                onTap: () async {
                  controller.initialAmount.value = (controller
                              .propertyAmount.text
                              .replaceAll(',', '')
                              .toInt() -
                          (controller.downPayment.text.toInt() *
                              controller.propertyAmount.text.toInt() /
                              100))
                      .toDouble();
                  var loanTerms = (controller.loanTerm.text.toInt() * 12);
                  var interest =
                      (controller.interestRate.text.toDouble() / 100) / 12;
                  controller.monthlyAmount.value =
                      (controller.initialAmount.value *
                              interest *
                              pow(1 + interest, loanTerms)) /
                          (pow(1 + interest, loanTerms) - 1);
                  controller.interestAmount.value =
                      (controller.monthlyAmount.value * loanTerms) -
                          controller.initialAmount.value;
                  controller.monthlyP.text = NumberFormat.currency(
                    locale: 'en_PH',
                    symbol: 'Php ',
                  ).format(controller.monthlyAmount.value);
                },
              ),
              SizedBox(height: 20.h),
              Center(
                child: EraText(
                  text: 'Monthly Payment',
                  fontSize: 20.sp,
                  color: AppColors.black,
                ),
              ),
              TextField(
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50.sp,
                    color: AppColors.downPayment,
                    fontWeight: FontWeight.bold),
                controller: controller.monthlyP,
                readOnly: true,
                decoration: new InputDecoration.collapsed(hintText: ''),
              ),
              Center(
                child: EraText(text: ''),
              ),
              Center(
                child: TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.blue),
                    ),
                    onPressed: () {
                      controller.reset();
                    },
                    child: EraText(
                      text: 'RESET',
                      color: AppColors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textField({
    String? hintText,
    TextEditingController? controller,
  }) {
    return SizedBox(
      width: 300.w,
      child: Row(
        children: [
          TextformfieldWidget(
            hintText: hintText!,
            maxLines: 1,
            keyboardType: TextInputType.number,
            controller: controller,
          ),
          Image.asset(
            AppEraAssets.currency,
            height: 30.h,
            color: AppColors.kRedColor,
          )
        ],
      ),
    );
  }
}
