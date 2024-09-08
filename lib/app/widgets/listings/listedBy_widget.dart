import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/assets.dart';

class ListedBy extends StatelessWidget {
  final String? text;

  /// remove this
  final String image;
  final String agentFirstName;
  final String agentLastName;
  final String agentType;
  final String? whatsapp;
  final String? whatsappIcon;
  final String? email;
  final String? emailIcon;
  final String? listingId;
  const ListedBy({
    super.key,
    this.text,
    this.listingId,
    required this.image,
    required this.agentFirstName,
    required this.agentType,
    required this.agentLastName,
    this.whatsapp,
    this.whatsappIcon,
    this.email,
    this.emailIcon,
  });

  @override
  Widget build(BuildContext context) {
    final Uri whatsAppUrl2 = whatsapp != null
        ? Uri.parse('https://wa.me/$whatsapp')
        : Uri.parse('https://wa.me/null');
    final Uri emailUrl = email != null
        ? Uri.parse('mailto:$email?subject=Your%20Subject&body=Your%20Message')
        : Uri.parse('https://mail.google.com/');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: text ?? 'Listed By:',
          fontWeight: FontWeight.bold,
          fontSize: EraTheme.paragraph,
          color: AppColors.black,
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.hint),
                child: CloudStorage().imageLoader(
                  ref: image,
                  width: 55.w,
                  height: 55.w,
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200.w,
                    child: EraText(
                      text: '$agentFirstName $agentLastName',
                      fontSize: EraTheme.paragraph,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  EraText(
                    text: agentType,
                    fontSize: EraTheme.paragraph - 4.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  // SizedBox(height: 5.h),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        if (whatsapp != null && whatsappIcon != null)
          GestureDetector(
            onTap: () async {
              if (listingId != null) {
                await Database().addLeads(listingId);
              }
              launchUrl(whatsAppUrl2);
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
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
                  sbw10(),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: whatsapp!,
                      fontSize: 18.sp,
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
        sb10(),
        if (email != null && emailIcon != null)
          GestureDetector(
            onTap: () async {
              if (listingId != null) {
                await Database().addLeads(listingId);
              }
              launchUrl(emailUrl);
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: 12.w, right: 12.w, top: 12.h, bottom: 12.h),
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
                  sbw10(),
                  Container(
                    width: 250.w,
                    child: EraText(
                      text: email!,
                      fontSize: 18.sp,
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
    );
  }

//   static Widget agentListing(
// // final String text,
//     String image,
//     String agentFirstName,
//     String agentLastName,
//     String agentType,
//     String? whatsapp,
//     String? whatsappIcon,
//     String? email,
//     String? emailIcon,
//   ) {
//     return Stack(
//       children: [
//         Container(
//           margin: EdgeInsets.only(top: 120.h, left: 50.w, right: 50.w),
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//           decoration: BoxDecoration(
//               border:
//                   Border.all(color: AppColors.hint.withOpacity(0.5), width: 3),
//               borderRadius: BorderRadius.circular(8)),
//           child: Column(
//             children: [
//               SizedBox(height: 60.h),
//               EraText(
//                 text: '$agentFirstName $agentLastName',
//                 fontSize: 23.sp,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.blue,
//               ),
//               EraText(
//                 text: agentType,
//                 fontSize: 18.sp,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.black,
//               ),
//               SizedBox(height: 15.h),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     whatsappIcon!,
//                     width: 30.w,
//                     height: 30.h,
//                   ),
//                   SizedBox(width: 8.w),
//                   EraText(
//                     text: whatsapp!,
//                     fontSize: 23.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.black,
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     emailIcon!,
//                     width: 30.w,
//                     height: 30.h,
//                   ),
//                   SizedBox(width: 8.w),
//                   EraText(
//                     text: email!,
//                     fontSize: 23.sp,
//                     fontWeight: FontWeight.w500,
//                     color: AppColors.black,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 30.h,
//           left: 125.w,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(8.w),
//             child: Image.asset(
//               image,
//               height: 150.h,
//               width: 160.w,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
}
