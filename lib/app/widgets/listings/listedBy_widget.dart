import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListedBy extends StatelessWidget {
  final String text;
  final String image;
  final String agentFirstName;
  final String agentLastName;
  final String agentType;
  final String? whatsapp;
  final String? whatsappIcon;
  final String? email;
  final String? emailIcon;

  const ListedBy({
    super.key,
    required this.text,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: EraText(
            text: text,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
            color: AppColors.black,
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.hint),
                child: Image.asset(
                  image,
                  width: 47.w,
                  height: 47.h,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: '$agentFirstName $agentLastName',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                  EraText(
                    text: agentType,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                  // SizedBox(height: 5.h),
                ],
              ),
            ],
          ),
        ),
        if (whatsapp != null && whatsappIcon != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 65.w),
            child: Row(
              children: [
                Image.asset(
                  whatsappIcon!,
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(width: 8.w),
                EraText(
                  text: whatsapp!,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
          ),
        if (email != null && emailIcon != null)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 65.w),
            child: Row(
              children: [
                Image.asset(
                  emailIcon!,
                  width: 30.w,
                  height: 30.h,
                ),
                SizedBox(width: 8.w),
                EraText(
                  text: email!,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ],
            ),
          )
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
