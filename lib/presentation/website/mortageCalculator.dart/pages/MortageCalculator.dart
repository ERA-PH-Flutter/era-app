import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/widgets/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';
 
import '../controllers/MortageCalculator_controller.dart';

class MortgageCalculatorWeb extends GetView<MortageCalculatorWController> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Text(
            "Mortgage Calculator",
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Simply calculate your mortgage payment.",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 30.h),

           Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildInputSection(),
              ),
              SizedBox(width: 20.w),
              Expanded(
                flex: 1,
                child: _buildPieChartSection(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField("Property Amount", controller.propertyAmount),
          SizedBox(height: 15.h),
          _buildTextField("Down Payment (%)", controller.downPayment),
          SizedBox(height: 15.h),
          _buildTextField("Loan Term (Years)", controller.loanTerm),
          SizedBox(height: 15.h),
          _buildTextField("Interest Rate (%)", controller.interestRate),
          SizedBox(height: 25.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              backgroundColor: Colors.blue.shade600,
            ),
            onPressed: () async {
              var initial =
                  controller.propertyAmount.text.replaceAll(',', '').toInt();
              controller.downP.value =
                  (controller.downPayment.text.toInt() * initial / 100)
                      .toString()
                      .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                          (Match m) => '${m[1]},');
              controller.initialAmount.value = (initial -
                      (controller.downPayment.text.toInt() * initial / 100))
                  .toDouble();
              var loanTerms = (controller.loanTerm.text.toInt() * 12);
              var interest =
                  (controller.interestRate.text.toDouble() / 100) / 12;
              controller.monthlyAmount.value = (controller.initialAmount.value *
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
            child: Center(
              child: Text(
                "CALCULATE",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.blue.shade700,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
          ),
        ),
      ],
    );
  }

  Widget _buildPieChartSection() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Payment Breakdown",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade700,
            ),
          ),
          SizedBox(height: 20.h),
          Obx(() {
            return Piechart(
              downPayment: controller.downP.value,
              interestAmount: controller.interestAmount.value,
              initialAmount: controller.initialAmount.value,
            );
          }),
          SizedBox(height: 20.h),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              backgroundColor: Colors.red.shade600,
            ),
            onPressed: () => controller.reset(),
            child: Center(
              child: Text(
                "RESET",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 
}
