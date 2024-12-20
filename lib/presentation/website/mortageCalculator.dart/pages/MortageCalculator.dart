// import 'package:eraphilippines/app/constants/assets.dart';
// import 'package:eraphilippines/app/constants/colors.dart';
// import 'package:eraphilippines/app/constants/strings.dart';
// import 'package:eraphilippines/app/widgets/pieChart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'dart:math';

// import '../../../../app/constants/sized_box.dart';
// import '../../../../app/constants/theme.dart';
// import '../../../../app/widgets/app_text.dart';
// import '../../../../app/widgets/button.dart';
// import '../controllers/MortageCalculator_controller.dart';

// class MortgageCalculatorWeb extends GetView<MortageCalculatorWController> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               padding: EdgeInsets.symmetric(vertical: 20),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.blue.withOpacity(0.7),
//                     AppColors.kRedColor.withOpacity(0.8)
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     EraText(
//                       text: 'Mortgage Calculator',
//                       fontSize: EraTheme.h1,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     SizedBox(height: 10),
//                     EraText(
//                       text: 'Easily calculate your mortgage payments',
//                       fontSize: EraTheme.h6,
//                       color: AppColors.white.withOpacity(0.7),
//                     ),
//                     SizedBox(height: 20),
//                     Image.asset(
//                       'assets/icons/mortgage-loan.png',
//                       height: 200,
//                       color: AppColors.white,
//                     ),
//                     SizedBox(height: 30.h),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             flex: 2,
//                             child: _buildInputSection(),
//                           ),
//                           SizedBox(width: 20.w),
//                           Expanded(
//                             flex: 1,
//                             child: pieChart(),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ])),
//         ],
//       ),
//     );
//   }

//   Widget _buildInputSection() {
//     return Card(
//       color: AppColors.white,
//       elevation: 8,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(20.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildTextField(
//               label: 'Property Amount',
//               controller: controller.propertyAmount,
//               onChanged: (value) {
//                 String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
//                 String formattedValue = digitsOnly.replaceAllMapped(
//                   RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
//                   (Match m) => '${m[1]},',
//                 );
//                 controller.propertyAmount.text = formattedValue;
//                 controller.propertyAmount.selection =
//                     TextSelection.fromPosition(
//                   TextPosition(offset: formattedValue.length),
//                 );
//               },
//             ),
//             sbw30(),
//             _buildTextField(
//               label: 'Down Payment (%)',
//               controller: controller.downPayment,
//             ),
//             sbw30(),
//             _buildTextField(
//               label: 'Loan Term (Years)',
//               controller: controller.loanTerm,
//             ),
//             sbw30(),
//             _buildTextField(
//               label: 'Interest Rate (%)"',
//               controller: controller.interestRate,
//             ),
//             sb30(),
//             Button(
//               borderRadius: BorderRadius.circular(20.r),
//               width: Get.width,
//               bgColor: AppColors.kRedColor.withOpacity(0.8),
//               text: 'CALCULATE',
//               fontSize: EraTheme.paragraphWeb,
//               fontWeight: FontWeight.w500,
//               height: EraTheme.buttonH60,
//               onTap: () async {
//                 var initial =
//                     controller.propertyAmount.text.replaceAll(',', '').toInt();
//                 controller.downP.value =
//                     (controller.downPayment.text.toInt() * initial / 100)
//                         .toString()
//                         .replaceAllMapped(
//                             RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
//                             (Match m) => '${m[1]},');
//                 controller.initialAmount.value = (initial -
//                         (controller.downPayment.text.toInt() * initial / 100))
//                     .toDouble();
//                 var loanTerms = (controller.loanTerm.text.toInt() * 12);
//                 var interest =
//                     (controller.interestRate.text.toDouble() / 100) / 12;
//                 controller.monthlyAmount.value =
//                     (controller.initialAmount.value *
//                             interest *
//                             pow(1 + interest, loanTerms)) /
//                         (pow(1 + interest, loanTerms) - 1);
//                 controller.interestAmount.value =
//                     (controller.monthlyAmount.value * loanTerms) -
//                         controller.initialAmount.value;
//                 controller.monthlyP.text = NumberFormat.currency(
//                   locale: 'en_PH',
//                   symbol: 'Php ',
//                 ).format(controller.monthlyAmount.value);
//               },
//             ),

//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//       {String? label,
//       TextEditingController? controller,
//       void Function(String)? onChanged}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         EraText(
//           text: label!,
//           fontSize: EraTheme.h6,
//           fontWeight: FontWeight.w600,
//           color: AppColors.blue,
//         ),
//         SizedBox(height: 10.h),
//         TextField(
//           onChanged: onChanged,
//           controller: controller,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: Colors.grey.shade100,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12.r),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding:
//                 EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget pieChart() {
//     return Card(
//       color: AppColors.white,
//       elevation: 8,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(20.sp),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.all(8.sp),
//               child: EraText(
//                 text: 'Mortgage Payment Breakdown',
//                 fontSize: EraTheme.h2,
//                 color: AppColors.blue,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10.h),
//             Obx(() => Piechart(
//                 downPayment: controller.downP.value,
//                 interestAmount: controller.interestAmount.value,
//                 initialAmount: controller.initialAmount.value)),
//             EraText(
//                 text: 'Summary of Payment',
//                 fontSize: EraTheme.subHeaderWeb,
//                 color: AppColors.kRedColor),
//             Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       EraText(
//                         text: 'Downpayment: ',
//                         fontSize: EraTheme.buttonText,
//                         color: AppColors.black,
//                       ),
//                       Obx(
//                         () => EraText(
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               fontSize: 30.sp,
//                               color: AppColors.downPayment,
//                               fontWeight: FontWeight.bold),
//                           text: controller.downP.value,
//                         ),
//                       ),
//                     ],
//                   ),
//                   EraText(
//                     text: 'Monthly Payment: ',
//                     fontSize: EraTheme.buttonText,
//                     color: AppColors.black,
//                   ),
//                   TextField(
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 30.sp,
//                         color: AppColors.downPayment,
//                         fontWeight: FontWeight.bold),
//                     controller: controller.monthlyP,
//                     readOnly: true,
//                     decoration: InputDecoration.collapsed(hintText: ''),
//                   )
//                 ],
//               ),
//             ),
//             Center(
//               child: IconButton(
//                 alignment: Alignment.center,
//                 onPressed: () {
//                   controller.reset();
//                 },
//                 icon: Image.asset(
//                   AppEraAssets.reset,
//                   height: 50.h,
//                   color: AppColors.blue,
//                   width: 50.w,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
 import 'dart:math';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/pieChart.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controllers/MortageCalculator_controller.dart';

class MortgageCalculatorWeb extends GetView<MortageCalculatorWController> {
  const MortgageCalculatorWeb({super.key});

  @override
  Widget build(BuildContext context) {
    //   Get.put(MortageCalculatorWController());
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Mortgage Calculator',
            fontSize: EraTheme.h1,
            color: AppColors.kRedColor,
            fontWeight: FontWeight.bold,
          ),
          EraText(
            text: 'Simply Calculate Your Mortgage Payment',
            fontSize: EraTheme.h3,
            color: AppColors.black,
            fontWeight: FontWeight.w400,
          ),
          sb50(),

          // Form Fields and Pie Chart Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: _rowTextField(),
              ),
              sbw40(),
              Expanded(
                flex: 1,
                child: pieChart(),
              ),
            ],
          ),
          sb50(),
        ],
      ),
    );
  }

  Widget pieChart() {
    return Container(
      padding: EdgeInsets.all(20.sp),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: AppColors.kRedColor.withOpacity(0.7), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: EraText(
              text: 'Mortgage Payment Breakdown',
              fontSize: EraTheme.h2,
              color: AppColors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Obx(() => Piechart(
              downPayment: controller.downP.value,
              interestAmount: controller.interestAmount.value,
              initialAmount: controller.initialAmount.value)),
          EraText(
              text: 'Summary of Payment',
              fontWeight: FontWeight.bold,
              fontSize: EraTheme.h2,
              color: AppColors.kRedColor),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    EraText(
                      text: 'Downpayment: ',
                      fontSize: EraTheme.h3,
                      color: AppColors.black,
                    ),
                    Obx(
                      () => EraText(
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: AppColors.downPayment,
                            fontWeight: FontWeight.bold),
                        text: controller.downP.value,
                      ),
                    ),
                  ],
                ),
                sb10(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: EraText(
                        text: 'Monthly Payment: ',
                        fontSize: EraTheme.h3,
                        color: AppColors.black,
                      ),
                    ),
                    Flexible(
                      child: TextField(
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 30.sp,
                            color: AppColors.downPayment,
                            fontWeight: FontWeight.bold),
                        controller: controller.monthlyP,
                        readOnly: true,
                        decoration: InputDecoration.collapsed(hintText: ''),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Center(
            child: IconButton(
              alignment: Alignment.center,
              onPressed: () {
                controller.reset();
              },
              icon: Image.asset(
                AppEraAssets.reset,
                height: 50.h,
                color: AppColors.blue,
                width: 50.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rowTextField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildTextField(
          title: 'Property Amount',
          controller: controller.propertyAmount,
          onChanged: (value) {
            String digitsOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
            String formattedValue = digitsOnly.replaceAllMapped(
              RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
              (Match m) => '${m[1]},',
            );
            controller.propertyAmount.text = formattedValue;
            controller.propertyAmount.selection = TextSelection.fromPosition(
              TextPosition(offset: formattedValue.length),
            );
          },
        ),
        sb10(),
        _buildTextField(
          title: 'Down Payment (%)',
          controller: controller.downPayment,
        ),
        sb10(),
        _buildTextField(
          title: 'Loan Term (Years)',
          controller: controller.loanTerm,
        ),
        sb10(),
        _buildTextField(
          title: 'Interest Rate (%)',
          controller: controller.interestRate,
        ),
        sb30(),
        Button(
          borderRadius: BorderRadius.circular(20.r),
          width: Get.width,
          bgColor: AppColors.kRedColor,
          text: 'CALCULATE',
          fontSize: EraTheme.paragraphWeb,
          fontWeight: FontWeight.w500,
          height: EraTheme.buttonH60,
          onTap: () async {
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
            var interest = (controller.interestRate.text.toDouble() / 100) / 12;
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
        ),
      ],
    );
  }

  Widget _buildTextField({
    String? title,
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title!,
          fontSize: EraTheme.h3,
          color: AppColors.black,
        ),
        SizedBox(height: 10.h),
        TextformfieldWidget(
          onChanged: onChanged,
          suffixIcon: Align(
            widthFactor: 1.5,
            child: Image.asset(
              AppEraAssets.currency,
              height: 35.h,
              color: AppColors.kRedColor,
            ),
          ),
          keyboardType: TextInputType.number,
          controller: controller,
          maxLines: 1,
        ),
      ],
    );
  }
}
