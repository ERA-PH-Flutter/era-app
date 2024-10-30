import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../presentation/agent/agents/bindings/agent_listings_binding.dart';
import '../../../presentation/agent/agents/pages/agent_listings.dart';
import '../../constants/assets.dart';
import '../../constants/colors.dart';
import '../../constants/sized_box.dart';
import '../../constants/strings.dart';
import '../../constants/theme.dart';
import '../../services/firebase_storage.dart';
import '../button.dart';

class AgentListViewWeb extends StatelessWidget {
  final List agentInfo;
  const AgentListViewWeb({super.key, required this.agentInfo});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: Get.height - 300.h,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: agentInfo.length,
      itemBuilder: (context, index) {
        final agent = agentInfo[index];
        final Uri whatsAppUrl2 = agent!.whatsApp != null
            ? Uri.parse('https://wa.me/${agent!.whatsApp}')
            : Uri.parse('https://wa.me/null');
        final Uri emailUrl = agent!.email != null
            ? Uri.parse(
                'mailto:${agent.email}?subject=Your%20Subject&body=Your%20Message')
            : Uri.parse('https://mail.google.com/');
        return Container(
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  height: 400.h,
                  width: 400
                      .w, // margin: EdgeInsets.only(top: 120.h, left: 60.w, right: 60.w),
                  margin: EdgeInsets.only(
                    top: 250.h,
                    left: 45.w,
                    right: 45.w,
                  ),
                  padding: EdgeInsets.only(left: 15.w, right: 15.w),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.hint.withOpacity(0.5), width: 3.w),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      SizedBox(height: 80.h),
                      EraText(
                        text: '${agent.firstname} ${agent.lastname}',
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                        lineHeight: 1.0,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        color: AppColors.blue,
                      ),
                      EraText(
                        text:
                            '${agent.role == 'agent' ? 'ERA Infinity Agent' : 'ERA Infinity Broker'}',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      sb10(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              launchUrl(whatsAppUrl2);
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                  top: 12.h,
                                  bottom: 12.h),
                              decoration: BoxDecoration(
                                  color: AppColors.subtle,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    AppEraAssets.whatsappIcon,
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  sbw5(),
                                  EraText(
                                    text: '${agent.whatsApp}',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          sb10(),
                          GestureDetector(
                            onTap: () => launchUrl(emailUrl),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 12.w,
                                  right: 12.w,
                                  top: 12.h,
                                  bottom: 12.h),
                              decoration: BoxDecoration(
                                  color: AppColors.subtle,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Row(
                                children: [
                                  Image.asset(
                                    color: AppColors.kRedColor,
                                    AppEraAssets.emailIcon,
                                    width: 40.w,
                                    height: 40.h,
                                  ),
                                  sbw5(),
                                  Container(
                                    width: 190.w,
                                    child: EraText(
                                      text: '${agent.email}',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      sb40(),
                      Button(
                        text: 'VIEW LISTING',
                        fontSize: 13.sp,
                        onTap: () {
                          Get.to(AgentListings(),
                              binding: AgentListingsBinding(),
                              arguments: [agent.id]);
                        },
                        bgColor: AppColors.kRedColor,
                        width: 200.w,
                        fontWeight: FontWeight.w400,
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      //????
                    ],
                  )),
              Positioned(
                  top: 10.h,
                  left: 100.w,
                  right: 100.w,
                  child: CloudStorage().imageLoaderProvider(
                      height: 300.h,
                      width: Get.width,
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ref: '${agent.image ?? AppStrings.noUserImageWhite}')),
            ],
          ),
        );
      },
    );
  }
}
