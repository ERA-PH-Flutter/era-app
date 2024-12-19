// import 'package:eraphilippines/presentation/website/form/controllers/form_web_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';
// import '../../../../../app/constants/assets.dart';
// import '../../../../../app/constants/colors.dart';
// import '../../../../../app/widgets/app_text.dart';
// import '../../../../../app/widgets/button.dart';
// import '../../../../../app/constants/sized_box.dart';
// import '../../../../app/constants/theme.dart';
// import '../../../../app/widgets/createaccount_widget.dart';
// import 'about_us_web.dart';

// class ContactUsWeb extends GetView<FormWebController> {
//   const ContactUsWeb({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(FormWebController());
//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: EraTheme.paddingWidthAdmin * 3,
//           vertical: 20.h,
//         ),
//         child: Column(
//           children: [
//             // Hero Section
//             Stack(
//               alignment: Alignment.center,
//               children: [
//                 Container(
//                   height: 200.h,
//                   color: AppColors.kRedColor.withOpacity(0.7),
//                 ),
//                 Column(
//                   children: [
//                     EraText(
//                       text: "Get in Touch",
//                       fontSize: EraTheme.headerWeb + 10,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     sb10(),
//                     EraText(
//                       text:
//                           "Have questions? We'd love to help! Reach out to us below.",
//                       fontSize: EraTheme.paragraphWeb,
//                       color: Colors.white,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             sb30(),

//             // Form and Contact Details
//             Card(
//               elevation: 5,
//               margin: EdgeInsets.all(10),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.r),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     EraText(
//                       text: "Send us a message",
//                       fontSize: 20.sp,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.blue,
//                     ),
//                     sb20(),
//                     SharedWidgets.textFormfield(
//                       hintText: 'Full Name',
//                       controller: controller.nameC,
//                       textInputType: TextInputType.text,
//                     ),
//                     sb10(),
//                     SharedWidgets.textFormfield(
//                       controller: controller.emailAC,
//                       hintText: 'Email',
//                       textInputType: TextInputType.emailAddress,
//                     ),
//                     sb10(),
//                     SharedWidgets.dropDown(
//                       controller.selectedSubj,
//                       controller.subject,
//                       (value) {
//                         controller.selectedSubj.value = value;
//                       },
//                       '',
//                       'Select Subject Type',
//                     ),
//                     sb10(),
//                     SharedWidgets.textFormfield(
//                       controller: controller.messageC,
//                       hintText: 'Type your message here',
//                       textInputType: TextInputType.multiline,
//                       MaxLines: 5,
//                     ),
//                     sb30(),
//                     Button.button2(
//                       Get.width,
//                       53.h,
//                       () async {
//                         await controller.submitContact();
//                       },
//                       'Send',
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(width: 20.w),

//             sb30(),

//             // Join Us Section
//             AboutUsWeb.buildJoinUsSection(),
//           ],
//         ),
//       ),
//     );
//   }
// }
