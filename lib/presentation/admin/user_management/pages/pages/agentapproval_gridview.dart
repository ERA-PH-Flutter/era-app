import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/presentation/admin/user_management/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentapprovalGridview extends GetView<AgentAdminController> {
  final List<RealEstateListing> listing;

  const AgentapprovalGridview({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 370.h, crossAxisCount: 3, crossAxisSpacing: 10.w),
      itemCount: listing.length,
      itemBuilder: (context, i) => Column(
        children: [
          SizedBox(
            height: 360.h,
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
                    leading: listing[i].user.image != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(listing[i].user.image!),
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
                          "${listing[i].user.firstname!} ${listing[i].user.lastname!}",
                      color: AppColors.black,
                      fontSize: 20.sp,
                    ),
                    trailing: EraText(
                      text: 'AGENT ID: ${listing[i].user.id}',
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
                                text: '${listing[i].user.whatsApp}',
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
                                  text: '${listing[i].user.email}',
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
                    listing: '${listing[i].user.role}',
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
                  )
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
