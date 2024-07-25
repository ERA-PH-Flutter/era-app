import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MortageCalculator extends StatelessWidget {
  final List<MortageData> data;
  const MortageCalculator({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<MortageData, String>(
          dataSource: data,
          xValueMapper: (MortageData data, _) => data.title,
          yValueMapper: (MortageData data, _) => data.value,
          dataLabelMapper: (MortageData data, _) =>
              '${data.title} : ${data.value}',
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}

class MortageData {
  final String title;
  final int value;
  MortageData(this.title, this.value);

  List<MortageData> getChartData() {
    final List<MortageData> chartData = [
      MortageData('Principal', 1000),
      MortageData('Interest', 200),
      MortageData('Tax & Insurance', 150),
    ];
    return chartData;
  }
}
