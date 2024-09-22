import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/statitics/controller/statistics_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';

class StatisticsAdmin extends GetView<StatisticsController> {
  StatisticsAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StatisticsController());

    return Container(
      color: Colors.grey[100],
      height: Get.height - 150.h,
      padding: EdgeInsets.symmetric(horizontal: 41.0.w),
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
            SizedBox(height: 30.h),
            Row(
              children: [
                _createSummaryTile(text: "Total Users",target: FirebaseFirestore.instance.collection("users").snapshots(),difference: "100%"),
                SizedBox(width: 15.w,),
                _createSummaryTile(text: "Total Listings",target: FirebaseFirestore.instance.collection("listings").snapshots(),difference: "100%",icon: Icons.real_estate_agent_rounded),
                SizedBox(width: 15.w,),
                _createSummaryTile(text: "Total Projects",target:FirebaseFirestore.instance.collection("projects").snapshots(),difference: "100%",icon: Icons.apartment),
                SizedBox(width: 15.w,),
                _createSummaryTile(text: "Total Sold Listings",target: FirebaseFirestore.instance.collection("listings").where('isSold', isEqualTo: "true").snapshots(),difference: "100%",icon: Icons.attach_money),
              ],
            ),
            SizedBox(height: 20.h,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 3,
                  child: _buildGraph(),
                ),
                Flexible(
                  flex: 1,
                  child: _buildSold(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  _createSummaryTile({
    text,
    required Stream<QuerySnapshot<Map<String, dynamic>>> target,
    difference,
    icon,
  }){
    return Flexible(
      child: Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 3,
                  spreadRadius: 0,
                  color: Colors.black12
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: text,
                          fontSize: 17.sp,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                        StreamBuilder(
                          stream: target,
                          builder: (context,snapshot){
                            int count = 0;
                            if(snapshot.hasData){
                              count = snapshot.data!.docs.length;
                            }
                            return EraText(
                              text: count.toString(),
                              fontSize: 35.sp,
                              color: Colors.black,
                            );
                          },
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 2,
                                spreadRadius: 0,
                                color: AppColors.kRedColor.withOpacity(0.3)
                            )
                          ],
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10.r)
                      ),
                      padding: EdgeInsets.all(12.5.w),
                      child: Icon(icon ?? Icons.person,size: 25.sp,),
                    )
                  ],
                ),
                Row(
                  children: [
                    EraText(
                      text: "vs Last Week",
                      fontSize: 17.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(width: 10.w,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(5.r)
                      ),
                      child: Row(
                        children: [
                          EraText(
                            text: difference,
                            fontSize: 20.sp,
                            color: Colors.green,
                            fontWeight: FontWeight.w400,
                          ),
                          SizedBox(width: 5.w,),
                          Icon(
                            Icons.north_east,
                            size: 22.sp,
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  _buildGraph(){
    DateTime selectedDate = DateTime.now();
    final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('listings')
          .where('date_created', isGreaterThanOrEqualTo: startOfWeek)
          .where('date_created', isLessThanOrEqualTo: endOfWeek).get(),
      builder: (context,snapshot){
        List<FlSpot> graphData = [];
        if(snapshot.hasData){
          var data = snapshot.data!;
          int highest = 0;
          for(int i = 6;i!=0;i--){
            int count = 0;
            for (var doc in data.docs) {
              if(doc['date_created'].toDate().day == selectedDate.subtract(Duration(days: i)).day){
                count++;
              }
            }
            highest = count > highest ? count : highest;
            graphData.add(FlSpot(i.toDouble(), count.toDouble()));
          }
          controller.maxValue = highest + (highest / 3).floor();
          return Container(
            margin: EdgeInsets.only(right: 5.w),
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 3,
                    spreadRadius: 0,
                    color: Colors.black12
                )
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Listings Added this Week',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h,),
                SizedBox(
                  height: 530.h,
                  child: LineChart(
                    LineChartData(
                      lineTouchData: const LineTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: bottomTitleWidgets,
                            interval: 1,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: leftTitleWidgets,
                            reservedSize: 42,
                            interval: 1,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border.all(color: const Color(0xff37434d),width: 0.5),
                      ),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: controller.maxValue.toDouble()
                      ,
                      lineBarsData: [
                        LineChartBarData(
                          spots: graphData,
                          isCurved: true,
                          gradient: LinearGradient(
                            colors: [
                              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                                  .lerp(0.2)!,
                              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                                  .lerp(0.2)!,
                            ],
                          ),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                                    .lerp(0.2)!
                                    .withOpacity(0.1),
                                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                                    .lerp(0.2)!
                                    .withOpacity(0.1),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
  _buildSold(){
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(left: 10.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 3,
              spreadRadius: 0,
              color: Colors.black12
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent listings sold',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h,),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('listings').where('is_sold',isEqualTo: true).limit(10).snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Container(
                      width: Get.width,
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
                      decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              spreadRadius: 0,
                              color: Colors.black12
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: EraText(
                        text: "${index+1}. ${data.docs[index]['name']}",
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    );
                  },
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
  List<Color> gradientColors = [
    AppColors.kRedColor,
    AppColors.blue,
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('SUN', style: style);
        break;
      case 1:
        text = const Text('MON', style: style);
        break;
      case 2:
        text = const Text('TUE', style: style);
        break;
      case 3:
        text = const Text('WED', style: style);
        break;
      case 4:
        text = const Text('THU', style: style);
        break;
      case 5:
        text = const Text('FRI', style: style);
        break;
      case 6:
        text = const Text('SAT', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    int maxValue = controller.maxValue;
    if(maxValue > 10){
      if(value.toInt() % 3 == 0){
        return Text(value.toInt().toString(), style: style, textAlign: TextAlign.left);
      }
    }
    return Container();
  }
}