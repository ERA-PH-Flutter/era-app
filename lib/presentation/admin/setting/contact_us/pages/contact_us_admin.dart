import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/constants/theme.dart';
import '../controller/contact_us_admin_controller.dart';

class ContactUsAdmin extends GetView<ContactUsAController> {
  const ContactUsAdmin({super.key});

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
                  text: 'Contact Us Management',
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
                  .collection('contact_us')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var sellProperty = snapshot.data!.docs;
                  return SizedBox(
                    height: Get.height - 200.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: sellProperty.length,
                      itemBuilder: (context, index) {
                        var property = sellProperty[index].data();
                        return ExpansionTile(
                          trailing: SizedBox(
                            width: 100.w,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      launchUrl(Uri.parse(
                                          "mailto:${property['email']}?subject=ERA%20App%20Sell%20Property&body="));
                                    },
                                    icon: Icon(Icons.email)),
                                IconButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('contact_us')
                                          .doc(property['id'])
                                          .delete();
                                    },
                                    icon:
                                        Icon(Icons.delete, color: Colors.red)),
                              ],
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Row(
                            children: [
                              EraText(
                                text: property['name'],
                                color: AppColors.black,
                              ),
                            ],
                          ),
                          children: [
                            _builTextField('Phone: ${property['number']}', 1),
                            _builTextField('Email: ${property['email']}', 1),
                            _builTextField(
                                'Property Type: ${property['type']}', 1),
                            _builTextField(
                                'Description: ${property['message']}', 10),
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
      title: Expanded(
        child: EraText(
          text: text,
          maxLines: maxLines,
          color: AppColors.black,
        ),
      ),
    );
  }
}
