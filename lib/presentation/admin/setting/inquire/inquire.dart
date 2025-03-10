import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/theme.dart';

class InquireAdmin extends StatelessWidget {
  const InquireAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.topCenter,
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Row(
              children: [
                EraText(
                  text: 'Inquire Management',
                  color: AppColors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('inquire_details')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var inquire_details = snapshot.data!.docs;
                  return SizedBox(
                    height: Get.height - 200.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: inquire_details.length,
                      itemBuilder: (context, index) {
                        var inquire = inquire_details[index].data();
                        return ExpansionTile(
                          trailing: SizedBox(
                            width: 100.w,
                            child: IconButton(
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('inquire_details')
                                      .doc(inquire['id'])
                                      .delete();
                                },
                                icon: Icon(Icons.delete, color: Colors.red)),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Row(
                            children: [
                              EraText(
                                text: '${inquire['lname']}',
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          children: [
                            _builTextField(
                                'First Name: ${inquire['fname']}', 2),
                            _builTextField('Last Name: ${inquire['lname']}', 2),
                            _builTextField(
                                'Phone: ${inquire['mobile_num']}', 1),
                            _builTextField('Email: ${inquire['email']}', 2),
                            _builTextField(
                                'Description: ${inquire['desc']}', 10),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )
            // ExpansionTile(
            //   title: EraText(
            //     text: 'MANAGE SELL PROPERTY',
            //     color: AppColors.black,
            //   ),
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         controller.addSellProperty();
            //       },
            //       child: EraText(
            //         text: 'Add Sell Property',
            //         color: AppColors.black,
            //       ),
            //     ),
            //     sb10(),
            //
            //   ],
            // ),
            // sb50(),
          ],
        ),
      ),
    );
  }

  Widget _builTextField(text, maxLines) {
    return ListTile(
      title: EraText(
        text: text,
        maxLines: maxLines,
        color: AppColors.black,
      ),
    );
  }
}
