import 'package:eraphilippines/presentation/admin/statitics/controller/statistics_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StatisticsAdmin extends GetView<StatisticsController> {
  const StatisticsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController());

    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Text(
              'Real Estate Analytics',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            _buildAnalyticsCard(
                'Total Listings', '${controller.totalListings}'),
            SizedBox(height: 10.h),
            _buildAnalyticsCard('Average Price',
                '₱${controller.averagePrice.toStringAsFixed(2)}'),
            SizedBox(height: 10.h),
            _buildAnalyticsCard('Total Leads', '${controller.totalLeads}'),
            SizedBox(height: 10.h),
            _buildAnalyticsCard('Total Views', '${controller.totalViews}'),
            SizedBox(height: 10.h),
            _buildAnalyticsCard('Average Price per Sqm',
                '₱${controller.averagePricePerSqm.toStringAsFixed(2)}'),
            SizedBox(height: 20.h),
            Text(
              'Property Performance',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            _buildPropertyPerformanceLineChart(),
            SizedBox(height: 20.h),
            Text(
              'Agent Performance',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.h),
            _buildAgentPerformanceChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyPerformanceLineChart() {
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  // Ensure index is within bounds of the listings
                  return index < controller.listings.length
                      ? Text(
                          controller.listings[index].type,
                          style: TextStyle(fontSize: 12.sp),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(fontSize: 12.sp),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: controller.getPropertyPerformanceSpots(),
              isCurved: true,
              barWidth: 3.w,
              color: Colors.blue,
              belowBarData:
                  BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
            ),
            LineChartBarData(
              spots: controller.getLeadsPerformanceSpots(),
              isCurved: true,
              barWidth: 3.w,
              color: Colors.orange,
              belowBarData: BarAreaData(
                  show: true, color: Colors.orange.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentPerformanceChart() {
    final agentData = controller.getAgentPerformanceChartData();
    return Container(
      height: 300.h,
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: PieChart(
        PieChartData(
          sections: agentData.entries.map((entry) {
            final totalLeads = agentData.values.reduce((a, b) => a + b);
            final percentage = (entry.value / totalLeads) * 100;
            return PieChartSectionData(
              value: entry.value.toDouble(),
              title: '${entry.key}: ${percentage.toStringAsFixed(1)}%',
              radius: 60.w,
              color: Colors.primaries[
                  agentData.keys.toList().indexOf(entry.key) %
                      Colors.primaries.length],
            );
          }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 50.w,
          pieTouchData: PieTouchData(
            touchCallback: (touchEvent, touchResponse) {},
          ),
        ),
      ),
    );
  }
}
