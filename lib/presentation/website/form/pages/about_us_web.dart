// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:eraphilippines/app/constants/assets.dart';
// import 'package:eraphilippines/app/constants/sized_box.dart';
// import 'package:eraphilippines/app/widgets/app_text.dart';
// import 'package:eraphilippines/presentation/website/authentication/create_account_web.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import '../../../../app/constants/colors.dart';
// import '../../../../app/constants/theme.dart';
// import '../../../../app/widgets/button.dart';
// import '../../../../app/widgets/createaccount_widget.dart';
// import '../../../../app/widgets/textformfield_widget.dart';
// import '../../authentication.dart';
// import '../../form_widgets.dart';
// import '../controllers/form_web_controller.dart';

// class AboutUsWeb extends GetView<FormWebController> {
//   const AboutUsWeb({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(FormWebController());

//     final width = Get.width;
//     final height = Get.height;
//     final paddingHorizontal = EraTheme.paddingWidthAdmin;

//     return SingleChildScrollView(
//         child: SizedBox(
//       width: Get.width,
//       child: Stack(
//         children: [
//           Column(
//             children: [
//               sb50(),
//               _buildGradientSection(width, height),
//               sb80(),
//               _buildInfoSection(paddingHorizontal, height),
//               sb50(),
//               bottomWidget(controller: controller),
//             ],
//           ),
//           Positioned(
//             top: 30.h,
//             right: 100.w,
//             left: Get.width * 0.5,
//             child:
//                 // SizedBox(
//                 //   height: Get.height - 330.h,
//                 //   width: Get.width,
//                 //   child: YoutubePlayer(
//                 //     controller: controller.youtubePlayerController,
//                 //     bottomActions: const [
//                 //       CurrentPosition(),
//                 //       ProgressBar(isExpanded: true),
//                 //       RemainingDuration(),
//                 //       FullScreenButton(),
//                 //     ],
//                 //   ),
//                 // )
//                 CachedNetworkImage(
//               imageUrl:
//                   'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',

//               // height: Get.height - 200.h,
//               // width: 600.w,
//             ),
//           ),
//         ],
//       ),
//     ));
//   }

//   static Widget bottomWidget({required dynamic controller}) {
//     return Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               EraText(
//                 text: 'JOIN ERA PHILIPPINES',
//                 fontSize: EraTheme.headerWeb + 10.sp,
//                 color: AppColors.blue2,
//                 fontWeight: FontWeight.w900,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   buildFormWidget(controller: controller),
//                   sbw30(),
//                   joinUs()
//                 ],
//               ),
//             ]));
//   }

//   static Widget buildFormWidget({required dynamic controller}) {
//     return Expanded(
//       flex: 1,
//       child: Container(
//         color: Colors.transparent,
//         alignment: Alignment.centerLeft,
//         width: Get.width,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: EraTheme.paddingWidthXSmall - 10.w),
//               child: Column(
//                 children: [
//                   SharedWidgets.dropDown(
//                     controller.selectedValue,
//                     controller.items,
//                     (value) {
//                       controller.selectedValue.value = value;
//                     },
//                     '',
//                     'Tell us about yourself',
//                   ),
//                   SharedWidgets.textFormfield(
//                       keyboardType: TextInputType.text,
//                       hintText: 'Name',
//                       controller: controller.phoneNum),
//                   SharedWidgets.textFormfield(
//                       keyboardType: TextInputType.text,
//                       hintText: 'Phone Number',
//                       controller: controller.emailAd),
//                   sbw30(),
//                   SharedWidgets.textFormfield(
//                       keyboardType: TextInputType.text,
//                       hintText: 'Email Address',
//                       controller: controller.name),
//                   sb30(),
//                   TextformfieldWidget(
//                     hintText: 'Enter Description',
//                     maxLines: 13,
//                     color: AppColors.hint,
//                     keyboardType: TextInputType.multiline,
//                     textInputAction: TextInputAction.newline,
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: AppColors.hint),
//                     ),
//                   ),
//                   sb50(),
//                   Button(
//                     alignment: Alignment.centerLeft,
//                     onTap: () async {
//                       CreateAccountWeb();
//                     },
//                     margin: EdgeInsets.symmetric(horizontal: 5),
//                     width: Get.width,
//                     text: 'GET IN TOUCH',
//                     fontSize: EraTheme.buttonText,
//                     bgColor: AppColors.kRedColor,
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   sb50(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> buildBulletPoints() {
//     return [
//       buildDescription('    • Training & Development', color: AppColors.white),
//       sb10(),
//       buildDescription('    • Reputable developer properties',
//           color: AppColors.white),
//       sb10(),
//       buildDescription('    • Favourable Commission Terms',
//           color: AppColors.white),
//       sb10(),
//       buildDescription('    • Advanced Digital Platforms',
//           color: AppColors.white),
//       sb10(),
//       buildDescription('    • Administrative Support', color: AppColors.white),
//       sb10(),
//       buildDescription('    • Access to our office spaces & facilities',
//           color: AppColors.white),
//     ];
//   }

//   List<Widget> _buildOtherServices() {
//     return [
//       buildDescription('• Legal'),
//       sb10(),
//       buildDescription('• Taxation'),
//       sb10(),
//       buildDescription('• Accounting'),
//       sb10(),
//       buildDescription('• Marketing'),
//       sb10(),
//       buildDescription('• Branding'),
//     ];
//   }

//   Widget _buildInfoSection(double paddingHorizontal, double height) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth200),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               _buildLeftImageSection(height),
//               sbw30(),
//               _buildTextColumn(),
//               _buildTextColumn1(),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildLeftImageSection(double height) {
//     return Expanded(
//       flex: 1,
//       child: CachedNetworkImage(
//         imageUrl:
//             'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
//         fit: BoxFit.cover,
//         height: Get.height - 100.h,
//       ),
//     );
//   }

//   Widget _buildTextColumn() {
//     return Expanded(
//       flex: 1,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           buildSectionTitle('What We Do', EraTheme.headerWeb),
//           sb40(),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
//             child: Container(
//               color: AppColors.kRedColor,
//               height: 2.h,
//               width: 50.w,
//             ),
//           ),
//           sb20(),
//           buildTitle(
//             'Real Estate Brokerage Services',
//           ),
//           sb20(),
//           buildDescription(
//               'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the process.'),
//           sb30(),
//           buildTitle(
//             'Agent & Broker Training',
//           ),
//           sb20(),
//           buildDescription(
//               'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.'),
//           sb30(),
//           buildTitle(
//             'Franchise Arrangements',
//           ),
//           sb20(),
//           buildDescription(
//               'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.'),
//           sb20(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextColumn1() {
//     return Expanded(
//         flex: 1,
//         child: Column(children: [
//           sb40(),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
//             child: Container(
//               color: AppColors.white,
//               height: 2.h,
//               width: 50.w,
//             ),
//           ),
//           sb20(),
//           buildTitle(
//             'Property Valuation',
//           ),
//           sb20(),
//           buildDescription(
//               'Accurate property valuation is the cornerstone of successful real estate transactions. At ERA Real Estate Philippines, we offer meticulous property valuation services designed to provide clarity and confidence to buyers, sellers, and investors alike. Backed by comprehensive market analysis and expert insights, our valuation process ensures you receive an informed and fair assessment of your property’s worth.'),
//           sb30(),
//           buildTitle(
//             'Other Services',
//           ),
//           sb20(),
//           ..._buildOtherServices(),
//         ]));
//   }

//   Widget buildSectionTitle(String text, double fontSize) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
//       child: EraText(
//         text: text,
//         fontSize: fontSize,
//         fontWeight: FontWeight.w600,
//         color: AppColors.blue2,
//       ),
//     );
//   }

//   Widget buildDivider(Color color) {
//     return Container(
//       color: color,
//       height: 2.h,
//       width: 50.w,
//     );
//   }

//   buildTitle(text, {fontWeight, fontSize, color}) {
//     return Container(
//       width: Get.width - 200.w,
//       padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
//       child: EraText(
//         text: text,
//         maxLines: 50,
//         fontSize: fontSize ?? EraTheme.paragraphWeb - 10.sp,
//         fontWeight: fontWeight ?? FontWeight.bold,
//         color: color ?? AppColors.black,
//         textOverflow: TextOverflow.ellipsis,
//       ),
//     );
//   }

//   buildDescription(text, {fontWeight, fontSize, color}) {
//     return Container(
//       width: Get.width - 200.w,
//       padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
//       child: EraText(
//         text: text,
//         maxLines: 50,
//         fontSize: fontSize ?? EraTheme.text20,
//         fontWeight: fontWeight ?? FontWeight.w500,
//         color: color ?? AppColors.hint,
//         textOverflow: TextOverflow.ellipsis,
//       ),
//     );
//   }

//   Widget buildJoinUsSection() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth + 10.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           sb30(),
//           buildTitle('Join Us Today!',
//               fontSize: EraTheme.headerWeb + 20.sp,
//               fontWeight: FontWeight.bold,
//               color: AppColors.white),
//           buildDescription(
//             'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.',
//             color: AppColors.white,
//           ),
//           sb20(),
//           buildDescription(
//             'ERA Real Estate was founded on the principle of collaboration. The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared serve your unique needs.',
//             color: AppColors.white,
//           ),
//           sb20(),
//           buildDescription('Why Join Us?',
//               color: AppColors.white,
//               fontSize: EraTheme.subHeaderWeb - 4.sp,
//               fontWeight: FontWeight.w600),
//           ...buildBulletPoints(),
//           sb30(),
//         ],
//       ),
//     );
//   }

//   Widget _buildGradientSection(double width, double height) {
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: const [Color(0xFFC50000), Color(0xFF8C0909)],
//         ),
//       ),
//       height: height - 250.h,
//       width: width - 200.h,
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: buildJoinUsSection(),
//           ),
//           const Expanded(flex: 1, child: SizedBox()),
//         ],
//       ),
//     );
//   }
// }

import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/assets.dart';
import '../../form_widgets.dart';
import '../controllers/form_web_controller.dart';

// class AboutUsWeb extends GetView<FormWebController> {
//   const AboutUsWeb({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.find<FormWebController>();
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Stack(
//             children: [
//               Image.network(
//                 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
//                 fit: BoxFit.cover,
//                 height: Get.height - 150.h,
//                 width: Get.width,
//               ),
//               Container(
//                 height: Get.height - 150.h,
//                 width: Get.width,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.black.withOpacity(0.6),
//                       Colors.transparent,
//                     ],
//                     begin: Alignment.bottomCenter,
//                     end: Alignment.topCenter,
//                   ),
//                 ),
//               ),
//               Positioned(
//                 bottom: 30,
//                 left: 30,
//                 child: EraText(
//                   text: 'Welcome to a New ERA of Real Estate',
//                   fontSize: EraTheme.headerWeb,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: EraTheme.paddingWidthAdmin * 3, vertical: 40.h),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 EraText(
//                   text: 'About Us',
//                   fontSize: EraTheme.h1,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.kRedColor,
//                 ),
//                 sb20(),
//                 _buildDescription(
//                   'Welcome to a new ERA of property discovery and management.',
//                 ),
//                 sb20(),
//                 _buildDescription(
//                     'ERA Real Estate Philippines is a proud member of ERA Real Estate, the largest real estate network in the Asia-Pacific region with more than 23,400 trusted advisers in over 640 offices across 13 countries. We provide exceptional real estate services, guiding you through buying, selling, and investing.'),
//                 sb20(),
//                 _buildDescription(
//                     'We envision a world where searching for and managing real estate is as simple as a few taps on your phone. With the ERA Real Estate Philippines app, we aim to redefine the property landscape in the Philippines by providing cutting-edge tools and resources that enable you to make informed decisions with confidence.'),
//                 sb20(),
//                 _buildDescription(
//                     'At ERA Real Estate Philippines, we empower you to achieve your real estate dreams. Discover the ERA difference today!'),
//                 sb40(),
//                 EraText(
//                   text: 'What We Do',
//                   fontSize: EraTheme.h1,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.kRedColor,
//                 ),
//                 sb30(),
//                 _buildServices(),
//                 sb40(),
//                 buildJoinUsSection(),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _buildDescription(String text, {FontWeight? fontWeight, double? fontSize}) {
//     return EraText(
//       text: text,
//       fontSize: fontSize ?? EraTheme.paragraphWeb,
//       fontWeight: fontWeight ?? FontWeight.w500,
//       color: AppColors.black,
//       maxLines: 50,
//     );
//   }

//   Widget _buildServices() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 1,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildServiceTile(
//                 'Real Estate Brokerage Services',
//                 'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the processionals are committed to guiding you through every step of the process.',
//               ),
//               _buildServiceTile(
//                 'Agent & Broker Training',
//                 'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.',
//               ),
//               _buildServiceTile(
//                 'Franchise Arrangements',
//                 'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.',
//               ),
//             ],
//           ),
//         ),
//         SizedBox(width: 30),
//         Expanded(
//           flex: 1,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildServiceTile(
//                 'Property Valuation',
//                 'Accurate property valuation is the cornerstone of successful real estate transactions. At ERA Real Estate Philippines, we offer meticulous property valuation services designed to provide clarity and confidence to buyers, sellers, and investors alike. Backed by comprehensive market analysis and expert insights, our valuation process ensures you receive an informed and fair assessment of your property’s worth.',
//               ),
//               _buildServiceTile('Other Services:',
//                   '• Legal\n• Taxation\n• Accounting\n• Marketing\n• Branding'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildServiceTile(String title, String description) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 20.sp),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           EraText(
//             text: title,
//             fontSize: EraTheme.h2,
//             fontWeight: FontWeight.bold,
//             color: AppColors.kRedColor,
//           ),
//           sb10(),
//           EraText(
//             text: description,
//             fontSize: EraTheme.bodyText,
//             color: AppColors.black,
//           ),
//         ],
//       ),
//     );
//   }

//   static Widget buildJoinUsSection() {
//     return Container(
//       padding: EdgeInsets.all(30),
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.white, AppColors.hint.withOpacity(0.6)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 10,
//             offset: Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: buildWidgetColumn3(),
//                 ),
//               ),
//               Expanded(
//                 child: Positioned(
//                   left: 0,
//                   right: 0,
//                   child: Opacity(
//                     opacity: 0.8,
//                     child: Image.asset(
//                       AppEraAssets.careerEra,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

// static Widget joinUs() {
//   return Stack(
//     children: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               EraText(
//                 text: 'Why Join Us?',
//                 fontSize: EraTheme.headerWeb,
//                 color: AppColors.kRedColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               sb20(),
//               ...buildWidgetColumn3(),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             child: Image.asset(
//               height: 150.h,
//               AppEraAssets.careerEra,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ],
//       )
//     ],
//   );
// }

List<Widget> buildWidgetColumn3() {
  return [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'Why Join Us?',
          fontSize: EraTheme.headerWeb,
          fontWeight: FontWeight.bold,
          color: AppColors.kRedColor,
        ),
        sb20(),
        BottomWidgets.bigCircle(
          text: 'Training & Development',
        ),
        sb20(),
        BottomWidgets.bigCircle(
          text: 'Reputable developer properties',
        ),
        sb20(),
        BottomWidgets.bigCircle(
          text: 'Favorable Commission Terms',
        ),
        sb20(),
        BottomWidgets.bigCircle(
          text: 'Advanced Digital Platforms',
        ),
        sb20(),
        BottomWidgets.bigCircle(
          text: 'Administrative Support',
        ),
        sb20(),
        BottomWidgets.bigCircle(
          text: 'Access to our office spaces & facilities',
        ),
        sb20(),
      ],
    ),
  ];
}
