import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//ignore: must_be_immutable
class Piechart extends StatelessWidget {
  var downPayment;
  var interestAmount;
  var initialAmount;
  Piechart(
      {super.key, this.downPayment, this.interestAmount, this.initialAmount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _createLegend('PRINCIPAL', AppColors.yellow),
                _createLegend('INTEREST', AppColors.blue4),
                _createLegend('DOWN PAYMENT', AppColors.grey)
              ],
            ),
          ),
          SizedBox(
            height: 21.h,
          ),
          SizedBox(
            width: 200,
            height: 200,
            child: PieChart(
              PieChartData(
                  centerSpaceRadius: 0,
                  sections: pieChartSection(),
                  sectionsSpace: 0),
            ),
          ),
        ],
      ),
    );
  }

  _createLegend(text, color) {
    return Row(
      children: [
        Container(
          width: 13.w,
          height: 13.w,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(3.r)),
        ),
        SizedBox(
          width: 5.w,
        ),
        EraText(
          text: text,
          color: Colors.black,
          fontSize: 13.sp,
        )
      ],
    );
  }

  List<PieChartSectionData> pieChartSection() {
    List<Color> colors = [
      AppColors.yellow,
      AppColors.blue4,
      AppColors.grey,
    ];
    //List<String> titles = ['PRINCIPAL', 'INTEREST', 'DOWNPAYMENT'];
    return List<PieChartSectionData>.generate(3, (i) {
      const radius = 100.0;
      final fontSize = 15.sp;
      double value = 0;
      if (i == 0) {
        value = initialAmount;
      } else if (i == 1) {
        value = interestAmount;
      } else {
        print(downPayment.toString().toDouble());
        value = downPayment.toString().replaceAll(',', '').toDouble();
      }
      return PieChartSectionData(
        value: value,
        title: '', //${value.toInt()}%'
        titlePositionPercentageOffset: 1.1,
        color: colors[i],
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );
    });
  }
}
