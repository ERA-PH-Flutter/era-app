import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';

class ViewProject extends StatelessWidget {
  const ViewProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(EraTheme.paddingWidthAdmin - 5.w),
      alignment: Alignment.topCenter,
      height: Get.height - 150.h,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('projects').snapshots(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
                var d = data[index].data();
                var developerName = "";
                d['data'].forEach((lego){
                  if(lego['type'] == "Developer Name"){
                    developerName = lego['developer_name'];
                  }
                });
                return Card(
                  child: ListTile(
                    title: EraText(
                        text: 'Developer Name: $developerName',
                        color: AppColors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                    trailing: IconButton(
                      onPressed: ()async{
                        await FirebaseFirestore.instance.collection('projects').doc(d['id']).delete();
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }
}
