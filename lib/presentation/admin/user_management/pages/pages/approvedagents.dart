import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/createaccount_widget.dart';
import '../../../../../repository/listing.dart';
import '../../../../../repository/logs.dart';
import '../../../../../repository/user.dart';

class ApprovedAgents extends GetView<AgentAdminController> {
  ApprovedAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          EraText(
            text: 'AGENT NEW APPROVAL',
            color: AppColors.black,
            fontSize: 25.sp,
          ),
          sb20(),
          Container(
            height: 800.h,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('status', isEqualTo: 'disabled')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return agentApproval(
                      listingModels: snapshot.data!.docs.map((doc) {
                        return EraUser.fromJSON(doc.data());
                      }).toList(),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }

  Widget agentApproval({required List<EraUser> listingModels}) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 400.h, crossAxisCount: 3, crossAxisSpacing: 10.w),
      itemCount: listingModels.length,
      itemBuilder: (context, i){
        return Wrap(
          children: [
            Container(
              child: Card(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.hint, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: listingModels[i].image != null
                          ? CircleAvatar(
                        backgroundImage:
                        NetworkImage(listingModels[i].image!),
                      )
                          : CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: EraText(
                        text: 'Agent Name',
                        color: AppColors.hint,
                        fontSize: 12.sp,
                      ),
                      subtitle: EraText(
                        text:
                        "${listingModels[i].firstname!} ${listingModels[i].lastname!}",
                        color: AppColors.black,
                        fontSize: 20.sp,
                      ),
                      // trailing: EraText(
                      //   text: 'AGENT ID: ${listingModels[i].id}',
                      //   color: AppColors.black,
                      //   fontSize: 20.sp,
                      // ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EraText(
                                    text: 'WHATSAPP',
                                    color: AppColors.hint,
                                    fontSize: 14.sp),
                                EraText(
                                  text: '${listingModels[i].whatsApp}',
                                  color: AppColors.black,
                                  fontSize: 20.sp,
                                ),
                              ],
                            ),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 350.h,
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  EraText(
                                      text: 'E-MAIL',
                                      color: AppColors.hint,
                                      textOverflow: TextOverflow.fade,
                                      fontSize: 14.sp),
                                  EraText(
                                    text: '${listingModels[i].email}',
                                    color: AppColors.black,
                                    fontSize: 20.sp,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(height: 10.h),
                    _buildRow(
                      text: 'Status:',
                      listing: '${listingModels[i].role}',
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance.collection('user_info').doc(listingModels[i].id).get(),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          var data = snapshot.data!.data();
                          return Column(
                            children: [
                              _buildRow(
                                text: 'Recruiter:',
                                listing: '${data!['recruiter']}',
                              ),
                              _buildRow(
                                text: 'Years of Experience:',
                                listing: '${data['experience']}',
                              ),
                              _buildRow(
                                text: 'Specialization:',
                                listing: '${data['specialization']}',
                              ),
                              SizedBox(height: 10.h),
                              Divider(
                                color: AppColors.hint,
                                thickness: 1,
                              ),
                            ],
                          );
                        }else{
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 200.w,
                          height: 40.h,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              side: WidgetStateProperty.all(BorderSide(
                                color: AppColors.hint,
                                width: 1,
                              )),
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                              WidgetStateProperty.all(AppColors.white),
                            ),
                            onPressed: () async{
                              listingModels[i].status = "declined";
                              await listingModels[i].update();
                              await Logs(
                                  title: "${user!.firstname} ${user!.lastname} decline an agent with email ${listingModels[i].email}",
                                  type: "account"
                              ).add();
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: AppColors.black,
                            ),
                            label: EraText(
                              text: 'Decline',
                              color: AppColors.black,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200.w,
                          height: 40.h,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor:
                              WidgetStateProperty.all(AppColors.blue),
                            ),
                            onPressed: () {
                              Get.dialog(AlertDialog(
                                backgroundColor: AppColors.white,
                                title: EraText(
                                  text: 'APPROVE AGENT',
                                  color: AppColors.blue,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                content: SizedBox(
                                  height: 200.h,
                                  child: Column(
                                    children: [
                                      EraText(
                                        text:
                                        'Before you approve this agent, please choose what type of agent you want to this user to be.',
                                        color: AppColors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(height: 10.h),
                                      SharedWidgets.dropDown(
                                          controller.selectedAgentType,
                                          controller.agentType,
                                              (value) => controller
                                              .selectedAgentType.value = value!,
                                          'Agent Type',
                                          'Agent Type'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: EraText(
                                      text: 'NO',
                                      color: AppColors.black,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      listingModels[i].position =
                                          controller.selectedAgentType.value;
                                      listingModels[i].eraId =
                                      "ERA_agent${(settings!.agentCount! + 1).toString().padLeft(5,"0")}";
                                      listingModels[i].status = "approved";
                                      await listingModels[i].update();
                                      await Logs(
                                          title: "${user!.firstname} ${user!.lastname} approved an agent with ID ${listingModels[i].eraId}",
                                          type: "account"
                                      ).add();
                                      Get.back();
                                    },
                                    child: EraText(
                                      text: 'YES',
                                      color: AppColors.black,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ));
                            },
                            icon: Icon(
                              Icons.check,
                              color: AppColors.white,
                            ),
                            label: EraText(
                              text: 'Approved',
                              color: AppColors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    sb20(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRow({
    required String text,
    required String listing,
  }) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.w),
          child: EraText(
            text: text,
            color: AppColors.hint,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(width: 5.w),
        EraText(
          text: listing,
          color: AppColors.black,
          fontSize: 20.sp,
        ),
      ],
    );
  }
}

  //example of model
 
