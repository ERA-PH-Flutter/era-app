import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../presentation/website/landingpage/controller/homs_controller.dart';
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
        mainAxisExtent: Get.height - 350.h,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
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
          margin: EdgeInsets.symmetric(horizontal: 15.w),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 450.h,
                width: 450.w,
                margin: EdgeInsets.only(top: 200.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.hint.withOpacity(0.3),
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 100.h),
                      EraText(
                        text: '${agent.firstname} ${agent.lastname}',
                        fontSize: EraTheme.h3,
                        fontWeight: FontWeight.w600,
                        lineHeight: 1.2,
                        textAlign: TextAlign.center,
                        color: AppColors.blue,
                      ),
                      EraText(
                        text:
                            '${agent.role == 'agent' ? 'ERA Infinity Agent' : 'ERA Infinity Broker'}',
                        fontSize: EraTheme.h5,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black.withOpacity(0.8),
                        textAlign: TextAlign.center,
                      ),
                      sb20(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildContactButton(
                            onTap: () => launchUrl(whatsAppUrl2),
                            icon: AppEraAssets.whatsappIcon,
                            text: '${agent.whatsApp}',
                          ),
                          sb10(),
                          _buildContactButton(
                            onTap: () => launchUrl(emailUrl),
                            icon: AppEraAssets.emailIcon,
                            text: '${agent.email}',
                          ),
                        ],
                      ),
                      Spacer(),
                      Button(
                        text: 'VIEW LISTING',
                        fontSize: 14.sp,
                        onTap: () {
                          selectedIndex.value = 19;
                          HomsController homsController =
                              Get.find<HomsController>();
                          homsController.onNavbarItemSelected(
                            19,
                          );
                          // Get.to(AgentListings(),
                          //     binding: AgentListingsBinding(),
                          //     arguments: [agent.id]);
                        },
                        bgColor: AppColors.kRedColor,
                        width: 220.w,
                        fontWeight: FontWeight.w500,
                        margin: EdgeInsets.only(bottom: 15.h),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0.h,
                right: 20.w,
                left: 20.w,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CloudStorage().imageLoaderProvider(
                      height: 280.h,
                      width: 300.w,
                      reference:
                          '${agent.image ?? AppStrings.noUserImageWhite}',
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactButton({
    required VoidCallback onTap,
    required String icon,
    required String text,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
        decoration: BoxDecoration(
          color: AppColors.subtle,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 50.w,
              height: 50.h,
            ),
            sbw10(),
            Expanded(
              child: EraText(
                text: text,
                fontSize: EraTheme.h5,
                fontWeight: FontWeight.bold,
                color: AppColors.black.withOpacity(0.9),
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
