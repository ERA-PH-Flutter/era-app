import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/createaccount_widget.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/presentation/admin/agents/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgentapprovalGridview extends GetView<AgentAdminController> {
  final List<RealEstateListing> listing;

  const AgentapprovalGridview({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: 90.h,
        left: 10.w,
        right: 10.w,
      ),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 250.h, crossAxisCount: 3, crossAxisSpacing: 20.w),
      itemCount: listing.length,
      itemBuilder: (context, i) => Column(
        children: [
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: listing[i].user.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(listing[i].user.image!),
                        )
                      : CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                  title: EraText(
                    text:
                        "${listing[i].user.firstname!} ${listing[i].user.lastname!}",
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                  subtitle: EraText(
                    text: "${listing[i].user.email}",
                    color: AppColors.black,
                    fontSize: 14.sp,
                  ),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            backgroundColor: AppColors.white,
                            title: EraText(
                              text: 'APPROVE AGENT',
                              color: AppColors.blue,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            content: Container(
                              height: 300.h,
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
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('Yes'),
                              ),
                            ],
                          ));
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: EraText(
                    text: 'STATUS: ${listing[i].user.role}',
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: EraText(
                    text: 'RECRUITER: N/A',
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: EraText(
                    text: 'YEARS OF EXPERIENCE: 6 YEARS',
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: EraText(
                    text: 'SPECIALIZATION: RENTAL',
                    color: AppColors.black,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
