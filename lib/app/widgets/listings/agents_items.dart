import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/agent/agents/bindings/agent_listings_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/agent_listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/sized_box.dart';

class AgentsItems extends StatelessWidget {
  final agentInfo;
  final Function()? onTap;

  AgentsItems({super.key, required this.agentInfo, this.onTap});
  var selected = false.obs;

  void toggleSelected() {
    selected.value = !selected.value;
  }

  @override
  Widget build(BuildContext context) {
    final Uri whatsAppUrl2 = agentInfo!.whatsApp != null
        ? Uri.parse('https://wa.me/${agentInfo!.whatsApp}')
        : Uri.parse('https://wa.me/null');
    final Uri emailUrl = agentInfo!.email != null
        ? Uri.parse(
            'mailto:${agentInfo!.email}?subject=Your%20Subject&body=Your%20Message')
        : Uri.parse('https://mail.google.com/');

    return GestureDetector(
      onTap: () {
        toggleSelected();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => AnimatedContainer(
              duration: Duration(milliseconds: 2000),
              curve: Curves.fastEaseInToSlowEaseOut,
              height: selected.value ? 350.h : 335.h,
              width: 500
                  .w, // margin: EdgeInsets.only(top: 120.h, left: 60.w, right: 60.w),
              margin: selected.value
                  ? EdgeInsets.only(top: 250.h, left: 40.w, right: 40.w)
                  : EdgeInsets.only(top: 200.h, left: 40.w, right: 40.w),

              padding: EdgeInsets.only(left: 15.w, right: 15.w),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: AppColors.hint.withOpacity(0.5), width: 3.w),
                  borderRadius: BorderRadius.circular(8)),
              child: selected.value
                  ? Column(
                      children: [
                        SizedBox(height: 70.h),
                        EraText(
                          text: '${agentInfo.firstname} ${agentInfo.lastname}',
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1.0,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          color: AppColors.blue,
                        ),
                        EraText(
                          text: '${agentInfo.role ?? 'Agent'}',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),

                        Container(
                          height: 150.h,
                          child: Column(
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
                                        text: '${agentInfo.whatsApp}',
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
                                          text: '${agentInfo.email}',
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
                        ),
                        //????
                        Button(
                          text: 'VIEW LISTING',
                          fontSize: 13.sp,
                          onTap: () {
                            Get.to(AgentListings(),
                                binding: AgentListingsBinding(),
                                arguments: [agentInfo.id]);
                          },
                          bgColor: AppColors.kRedColor,
                          width: 200.w,
                          fontWeight: FontWeight.w400,
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(height: 44.h),
                        EraText(
                          text: '${agentInfo.firstname} ${agentInfo.lastname}',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blue,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        EraText(
                          text: '${agentInfo.role ?? 'Agent'}',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          textOverflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                        sb20(),
                        Container(
                          child: Column(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AppEraAssets.whatsappIcon,
                                            width: 40.w,
                                            height: 40.h,
                                          ),
                                          sbw5(),
                                          EraText(
                                            text: '${agentInfo.whatsApp}',
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
                                          borderRadius:
                                              BorderRadius.circular(30)),
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
                                              text: '${agentInfo.email}',
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                              textOverflow:
                                                  TextOverflow.ellipsis,
                                              maxLines: 3,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        sb10(),
                        Button(
                          text: 'VIEW LISTINGS',
                          fontSize: 15.sp,
                          onTap: () {
                            Get.to(AgentListings(),
                                arguments: [agentInfo.id],
                                binding: AgentListingsBinding());
                          },
                          bgColor: AppColors.kRedColor,
                          width: 200.w,
                          fontWeight: FontWeight.w400,
                          margin: EdgeInsets.symmetric(horizontal: 35),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
            ),
          ),
          Obx(
            () => selected.value
                ? Positioned(
                    top: 50.h,
                    left: 50.w,
                    right: 50.w,
                    bottom: 280.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: FutureBuilder(
                        future: CloudStorage().getFileDirect(
                            docRef:
                                '${agentInfo.image ?? AppStrings.noUserImageWhite}'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              height: 200.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    snapshot.data!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  )
                : Positioned(
                    top: 50.h,
                    left: 100.w,
                    right: 100.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.w),
                      child: FutureBuilder(
                        future: CloudStorage().getFileDirect(
                            docRef:
                                '${agentInfo.image ?? AppStrings.noUserImageWhite}'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              height: 200.h,
                              width: 50.w,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    snapshot.data!,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
