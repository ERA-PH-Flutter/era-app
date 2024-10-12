import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../app/constants/theme.dart';
import '../controller/log_list_admin_controller.dart';

class LogListAdmin extends GetView<LogListAdminController> {
  const LogListAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    LogListAdminController controller = Get.put(LogListAdminController());
    return SingleChildScrollView(
        child: Container(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      height: Get.height - 150.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sb30(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EraText(
                text: 'Log List Management',
                color: AppColors.blue,
                fontSize: EraTheme.header + 3.sp,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [

                  Row(
                    children: [
                      Obx(()=>EraText(
                        text: DateFormat('MMMM d, yyyy').format(controller.nextDate.value).toString(),
                        color: Colors.black,
                      )),
                      IconButton(
                        onPressed: ()async{
                          controller.nextDate.value = await showDatePicker(context: context, firstDate: DateTime.now().subtract(Duration(days: 200)), lastDate: DateTime.now()) ?? controller.nextDate.value;
                        },
                        icon: Icon(Icons.calendar_month),
                      )
                    ],
                  ),

                  EraText(
                    text: "to",
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  SizedBox(width: 10.w,),
                  Row(
                    children: [
                      Obx(()=>EraText(
                        text: DateFormat('MMMM d, yyyy').format(controller.initialDate.value).toString(),
                        color: Colors.black,
                      )),
                      IconButton(
                        onPressed: ()async{
                          controller.initialDate.value = await showDatePicker(context: context, firstDate: DateTime.now().subtract(Duration(days: 200)), lastDate: DateTime.now()) ?? controller.initialDate.value;
                        },
                        icon: Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                  SizedBox(width: 20.w,),
                  Obx(()=> DropdownButton(
                    items: [
                      'all',
                      'listing',
                      'account',
                      'project',
                      'settings'
                    ].map((item){
                      return DropdownMenuItem(
                        value: item,
                        child: EraText(
                          text: item,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                    value: controller.selectedFilter.value,
                    onChanged: (value){
                      if(value != 'all'){
                        controller.stream.value = FirebaseFirestore.instance.collection('logs').where('type',isEqualTo: value).snapshots();
                      }else{
                        controller.stream.value = FirebaseFirestore.instance.collection('logs').orderBy('date_created').snapshots();
                      }
                      controller.selectedFilter.value = value!;
                    },
                  )),
                ],
              )
            ],
          ),
          sb20(),
          Obx(()=>StreamBuilder(
            stream: controller.stream.value,
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = snapshot.data!.docs;
                return SizedBox(
                  height: Get.height-275.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      if(controller.initialDate.value.isAfter(data[index]['date_created'].toDate()) && controller.nextDate.value.isBefore(data[index]['date_created'].toDate())){
                        return _builTextField('${data[index]['title']}');
                      }
                      return Container();
                    },
                  ),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ))

        ],
      ),
    ));
  }

  Widget _builTextField(text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(3.w),
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 5,
                spreadRadius: 0,
                color: Colors.blueGrey.withOpacity(0.5)
              )
            ]
          ),
          child: EraText(
              textAlign: TextAlign.start,
              text: text,
              color: AppColors.black,
              fontSize: EraTheme.small,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
