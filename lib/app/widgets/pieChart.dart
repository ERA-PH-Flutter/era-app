// import 'package:eraphilippines/app/constants/colors.dart';
// import 'package:eraphilippines/app/widgets/app_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class MortageCalculator extends StatelessWidget {
//   final List<MortageData> data;
//   const MortageCalculator({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return SfCircularChart(
//       series: <CircularSeries>[
//         PieSeries<MortageData, String>(
//           dataSource: data,
//           xValueMapper: (MortageData data, _) => data.title,
//           yValueMapper: (MortageData data, _) => data.value,
//           dataLabelSettings: DataLabelSettings(
//             textStyle: TextStyle(
//               color: AppColors.black,
//               fontSize: 15.sp,
//             ),
//             labelIntersectAction: LabelIntersectAction.none,
//             labelAlignment: ChartDataLabelAlignment.middle,
//             isVisible: true,
//             labelPosition: ChartDataLabelPosition.outside,
//             connectorLineSettings: ConnectorLineSettings(
//               type: ConnectorType.curve,
//             ),
//           ),
//           pointColorMapper: (MortageData data, _) => data.title == 'Principal'
//               ? AppColors.blue
//               : data.title == 'Interest'
//                   ? AppColors.kRedColor
//                   : AppColors.hint,
//           dataLabelMapper: (MortageData data, _) => data.title == 'Principal'
//               ? 'Principal'
//               : data.title == 'Interest'
//                   ? 'Interest'
//                   : 'Tax & Insurance',
//         )
//       ],
//     );
//   }
// }

// class MortageData {
//   final String title;
//   final int value;
//   MortageData(this.title, this.value);
//   static List<MortageData> getChartData() {
//     final List<MortageData> chartData = [
//       MortageData('Interest', 10),
//       MortageData('Tax & Insurance', 30),
//       MortageData('Principal', 70),
//     ];
//     return chartData;
//   }
// }
import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Piechart extends StatelessWidget {
  const Piechart({super.key});

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
    List<String> titles = ['PRINCIPAL', 'INTEREST', 'TAX &\n        INSURANCE'];
    return List<PieChartSectionData>.generate(3, (i) {
      final radius = 100.0;
      final fontSize = 15.sp;
      double value = 0;
      if (i == 0) {
        value = 70;
      } else if (i == 1) {
        value = 10;
      } else {
        value = 30;
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
