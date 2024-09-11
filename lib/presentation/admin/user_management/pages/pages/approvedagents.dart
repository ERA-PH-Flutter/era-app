import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../app/widgets/createaccount_widget.dart';

class ApprovedAgents extends GetView<AgentAdminController> {
  ApprovedAgents({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          EraText(
            text: 'AGENT NEW APPROVAL',
            color: AppColors.black,
            fontSize: 25.sp,
          ),
          agentApproval(
            listingModels: RealEstateListing.listingsModels,
          ),
        ],
      ),
    );
  }

  Widget agentApproval({required List<RealEstateListing> listingModels}) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 370.h, crossAxisCount: 3, crossAxisSpacing: 10.w),
      itemCount: listingModels.length,
      itemBuilder: (context, i) => Wrap(
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
                    leading: listingModels[i].user.image != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(listingModels[i].user.image!),
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
                          "${listingModels[i].user.firstname!} ${listingModels[i].user.lastname!}",
                      color: AppColors.black,
                      fontSize: 20.sp,
                    ),
                    trailing: EraText(
                      text: 'AGENT ID: ${listingModels[i].user.id}',
                      color: AppColors.black,
                      fontSize: 20.sp,
                    ),
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
                                text: '${listingModels[i].user.whatsApp}',
                                color: AppColors.black,
                                fontSize: 20.sp,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                EraText(
                                    text: 'E-MAIL',
                                    color: AppColors.hint,
                                    fontSize: 14.sp),
                                EraText(
                                  text: '${listingModels[i].user.email}',
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
                    listing: '${listingModels[i].user.role}',
                  ),
                  _buildRow(
                    text: 'Recruiter:',
                    listing: 'N/A:',
                  ),
                  _buildRow(
                    text: 'Years of Experience:',
                    listing: '6 YEARS',
                  ),
                  _buildRow(
                    text: 'Specialization:',
                    listing: 'RENTAL',
                  ),
                  SizedBox(height: 10.h),
                  Divider(
                    color: AppColors.hint,
                    thickness: 1,
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
                          onPressed: () {},
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
                                  onTap: () {
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

                ],
              ),
            ),
          ),
        ],
      ),
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
 
