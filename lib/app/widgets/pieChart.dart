import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Piechart extends StatelessWidget {
  var downPayment;
  var interestAmount;
  var initialAmount;
  Piechart({super.key,this.downPayment,this.interestAmount,this.initialAmount});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: PieChart(
          PieChartData(
              centerSpaceRadius: 0,
              sections: pieChartSection(),
              sectionsSpace: 0),
        ),
      ),
    );
  }

  List<PieChartSectionData> pieChartSection() {
    List<Color> colors = [
      AppColors.kRedColor,
      AppColors.blue,
      AppColors.hint,
    ];
    List<String> titles = ['PRINCIPAL', 'INTEREST', 'DOWNPAYMENT'];
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
        value = downPayment.toString().toDouble();
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
        badgePositionPercentageOffset: 1.38,
        badgeWidget: EraText(
          text: titles[i],
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
      );
    });
  }
}
