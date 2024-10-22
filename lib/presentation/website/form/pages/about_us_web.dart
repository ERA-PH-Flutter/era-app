import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/button.dart';
import '../../../../app/widgets/createaccount_widget.dart';
import '../../../../app/widgets/textformfield_widget.dart';
import '../../form_widgets.dart';
import '../controllers/form_web_controller.dart';

class AboutUsWeb extends GetView<FormWebController> {
  const AboutUsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FormWebController());

    final width = Get.width;
    final height = Get.height;
    final paddingHorizontal = EraTheme.paddingWidthAdmin + 90.w;

    return SingleChildScrollView(
      child: SizedBox(
        width: Get.width,
        child: Stack(
          children: [
            Column(
              children: [
                sb50(),
                _buildGradientSection(width, height),
                sb80(),
                _buildInfoSection(paddingHorizontal, height),
              ],
            ),
            Positioned(
              top: 10.h,
              right: 100.w,
              left: Get.width * 0.5,
              child:
                  // SizedBox(
                  //   height: Get.height - 330.h,
                  //   width: Get.width,
                  //   child: YoutubePlayer(
                  //     controller: controller.youtubePlayerController,
                  //     bottomActions: const [
                  //       CurrentPosition(),
                  //       ProgressBar(isExpanded: true),
                  //       RemainingDuration(),
                  //       FullScreenButton(),
                  //     ],
                  //   ),
                  // )
                  CachedNetworkImage(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                fit: BoxFit.cover,
                height: Get.height - 330.h,
                width: Get.width,
              ),
            ),
          ],
        ),
      ),
    );

    //   return Container(
    //     width: Get.width,
    //     child: Stack(
    //       children: [
    //         Column(
    //           children: [
    //             sb50(),
    //             Container(
    //               decoration: BoxDecoration(
    //                   gradient: new LinearGradient(
    //                       begin: Alignment.topCenter,
    //                       end: Alignment.bottomCenter,
    //                       colors: const [Color(0xFFC50000), Color(0xFF8C0909)])),
    //               height: Get.height - 350.h,
    //               width: Get.width - 200.h,
    //               child: Row(
    //                 children: [
    //                   Expanded(
    //                     flex: 1,
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         sb30(),
    //                         buildTitle('Join Us Today!',
    //                             fontSize: EraTheme.headerWeb + 20.sp,
    //                             fontWeight: FontWeight.bold,
    //                             color: AppColors.white),
    //                         sb20(),
    //                         buildDescription(
    //                             color: AppColors.white,
    //                             'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
    //                         SizedBox(
    //                           height: 20.h,
    //                         ),
    //                         buildDescription(
    //                             color: AppColors.white,
    //                             'ERA Real Estate was founded on the principle of collaboration.The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared to serve your unique needs.'),
    //                         sb20(),
    //                         buildDescription('Why Join Us?',
    //                             color: AppColors.white,
    //                             fontSize: EraTheme.subHeaderWeb - 4.sp,
    //                             fontWeight: FontWeight.w600),
    //                         ...buildBulletPoints(),
    //                         sb30(),
    //                       ],
    //                     ),
    //                   ),
    //                   Expanded(flex: 1, child: Container()),
    //                 ],
    //               ),
    //             ),
    //             sb80(),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Padding(
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: EraTheme.paddingWidthAdmin + 90.w),
    //                   child: Row(
    //                     children: [
    //                       Expanded(
    //                         flex: 1,
    //                         child: CachedNetworkImage(
    //                             imageUrl:
    //                                 'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
    //                             fit: BoxFit.cover,
    //                             width: 500.w,
    //                             height: Get.height),
    //                       ),
    //                       sbw30(),
    //                       Expanded(
    //                         flex: 1,
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   horizontal: EraTheme.paddingWidth),
    //                               child: EraText(
    //                                   text: 'What We Do',
    //                                   fontSize: EraTheme.headerWeb,
    //                                   fontWeight: FontWeight.w600,
    //                                   color: AppColors.blue2),
    //                             ),
    //                             sb40(),
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   horizontal: EraTheme.paddingWidth),
    //                               child: Container(
    //                                 color: AppColors.kRedColor,
    //                                 height: 2.h,
    //                                 width: 50.w,
    //                               ),
    //                             ),
    //                             sb20(),
    //                             buildTitle(
    //                               'Real Estate Brokerage Services',
    //                             ),
    //                             sb20(),
    //                             buildDescription(
    //                                 'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the process.'),
    //                             sb30(),
    //                             buildTitle(
    //                               'Agent & Broker Training',
    //                             ),
    //                             sb20(),
    //                             buildDescription(
    //                                 'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.'),
    //                             sb30(),
    //                             buildTitle(
    //                               'Franchise Arrangements',
    //                             ),
    //                             sb20(),
    //                             buildDescription(
    //                                 'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.'),
    //                             sb20(),
    //                           ],
    //                         ),
    //                       ),
    //                       Expanded(
    //                         flex: 1,
    //                         child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   horizontal: EraTheme.paddingWidth),
    //                               child: EraText(
    //                                   text: '',
    //                                   fontSize: EraTheme.headerWeb,
    //                                   fontWeight: FontWeight.w600,
    //                                   color: AppColors.blue2),
    //                             ),
    //                             sb40(),
    //                             Padding(
    //                               padding: EdgeInsets.symmetric(
    //                                   horizontal: EraTheme.paddingWidth),
    //                               child: Container(
    //                                 color: AppColors.white,
    //                                 height: 2.h,
    //                                 width: 50.w,
    //                               ),
    //                             ),
    //                             sb20(),
    //                             buildTitle(
    //                               'Property Valuation',
    //                             ),
    //                             sb20(),
    //                             buildDescription(
    //                                 'Accurate property valuation is the cornerstone of successful real estate transactions. At ERA Real Estate Philippines, we offer meticulous property valuation services designed to provide clarity and confidence to buyers, sellers, and investors alike. Backed by comprehensive market analysis and expert insights, our valuation process ensures you receive an informed and fair assessment of your property’s worth.'),
    //                             sb30(),
    //                             buildTitle(
    //                               'Other Services',
    //                             ),
    //                             sb20(),
    //                             ..._buildOtherServices(),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 sb80(),
    //                 Padding(
    //                   padding: EdgeInsets.symmetric(
    //                       horizontal: EraTheme.paddingWidthAdmin + 90.w),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       EraText(
    //                         text: 'JOIN ERA PHILIPPINES',
    //                         fontSize: EraTheme.headerWeb + 10.sp,
    //                         color: AppColors.blue2,
    //                         fontWeight: FontWeight.w900,
    //                       ),
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                             flex: 1,
    //                             child: Container(
    //                               // color: AppColors.hint,
    //                               alignment: Alignment.centerLeft,
    //                               width: Get.width - 200.w,
    //                               child: Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 children: [
    //                                   Padding(
    //                                     padding: EdgeInsets.symmetric(
    //                                         horizontal:
    //                                             EraTheme.paddingWidthXSmall -
    //                                                 10.w),
    //                                     child: Column(
    //                                       children: [
    //                                         SharedWidgets.dropDown(
    //                                           controller.selectedValue,
    //                                           controller.items,
    //                                           (value) {
    //                                             controller.selectedValue.value =
    //                                                 value;
    //                                           },
    //                                           '',
    //                                           'Tell us about yourself',
    //                                         ),
    //                                         SharedWidgets.textFormfield(
    //                                             textInputType: TextInputType.text,
    //                                             hintText: 'Name',
    //                                             controller: controller.phoneNum),
    //                                         sb30(),
    //                                         SharedWidgets.textFormfield(
    //                                             textInputType: TextInputType.text,
    //                                             hintText: 'Phone Number',
    //                                             controller: controller.emailAd),
    //                                         sbw30(),
    //                                         SharedWidgets.textFormfield(
    //                                             textInputType: TextInputType.text,
    //                                             hintText: 'Email Address',
    //                                             controller: controller.name),
    //                                         sb50(),
    //                                         TextformfieldWidget(
    //                                           hintText: 'Enter Description',
    //                                           maxLines: 13,
    //                                           color: AppColors.hint,
    //                                           keyboardType:
    //                                               TextInputType.multiline,
    //                                           textInputAction:
    //                                               TextInputAction.newline,
    //                                           enabledBorder: OutlineInputBorder(
    //                                             borderRadius:
    //                                                 BorderRadius.circular(10),
    //                                             borderSide: BorderSide(
    //                                                 color: AppColors.hint),
    //                                           ),
    //                                         ),
    //                                         Button(
    //                                           alignment: Alignment.centerLeft,
    //                                           onTap: () async {},
    //                                           margin: EdgeInsets.symmetric(
    //                                               horizontal: 5),
    //                                           width: Get.width,
    //                                           text: 'GET IN TOUCH',
    //                                           fontSize: EraTheme.buttonText,
    //                                           bgColor: AppColors.kRedColor,
    //                                           borderRadius:
    //                                               BorderRadius.circular(30),
    //                                         ),
    //                                         sb50(),
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                           sbw30(),
    //                           Expanded(
    //                               flex: 2,
    //                               child: Column(
    //                                 crossAxisAlignment: CrossAxisAlignment.start,
    //                                 children: [
    //                                   EraText(
    //                                     text: 'WHY JOIN US?',
    //                                     fontSize: EraTheme.headerWeb,
    //                                     color: AppColors.kRedColor,
    //                                     fontWeight: FontWeight.bold,
    //                                   ),
    //                                   Column(
    //                                     children: [
    //                                       Row(
    //                                         children: [
    //                                           BottomWidgets.bigCircle(),
    //                                           sbw10(),
    //                                           BottomWidgets.eraJoinTitle(
    //                                             text: 'Training & Development',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       sb20(),
    //                                       Row(
    //                                         children: [
    //                                           BottomWidgets.bigCircle(),
    //                                           sbw10(),
    //                                           BottomWidgets.eraJoinTitle(
    //                                             text:
    //                                                 'Reputable developer properties',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       sb20(),
    //                                       Row(
    //                                         children: [
    //                                           BottomWidgets.bigCircle(),
    //                                           sbw10(),
    //                                           BottomWidgets.eraJoinTitle(
    //                                             text:
    //                                                 'Favorable Commission Terms',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       sb20(),
    //                                       Row(
    //                                         children: [
    //                                           BottomWidgets.bigCircle(),
    //                                           sbw10(),
    //                                           BottomWidgets.eraJoinTitle(
    //                                             text:
    //                                                 'Advanced Digital Platforms',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       sb20(),
    //                                       Row(
    //                                         children: [
    //                                           BottomWidgets.bigCircle(),
    //                                           sbw10(),
    //                                           BottomWidgets.eraJoinTitle(
    //                                             text: 'Administrative Support',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       sb20(),
    //                                       Row(
    //                                         children: [
    //                                           BottomWidgets.bigCircle(),
    //                                           sbw10(),
    //                                           BottomWidgets.eraJoinTitle(
    //                                             text:
    //                                                 'Access to our office spaces & facilities',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       sb20(),
    //                                     ],
    //                                   ),
    //                                   Image.asset(
    //                                     AppEraAssets.careerEra,
    //                                     height: Get.height - 300.h,
    //                                     width: Get.width,
    //                                   )
    //                                 ],
    //                               ))
    //                         ],
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),

    //       ],
    //     ),
    //   );
    // }
  }

  List<Widget> buildBulletPoints() {
    return [
      buildDescription('• Training & Development', color: AppColors.white),
      sb10(),
      buildDescription('• Reputable developer properties',
          color: AppColors.white),
      sb10(),
      buildDescription('• Favourable Commission Terms', color: AppColors.white),
      sb10(),
      buildDescription('• Advanced Digital Platforms', color: AppColors.white),
      sb10(),
      buildDescription('• Administrative Support', color: AppColors.white),
      sb10(),
      buildDescription('• Access to our office spaces & facilities',
          color: AppColors.white),
    ];
  }

  List<Widget> _buildOtherServices() {
    return [
      buildDescription('• Legal'),
      sb10(),
      buildDescription('• Taxation'),
      sb10(),
      buildDescription('• Accounting'),
      sb10(),
      buildDescription('• Marketing'),
      sb10(),
      buildDescription('• Branding'),
    ];
  }

  Widget _buildInfoSection(double paddingHorizontal, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Row(
            children: [
              _buildLeftImageSection(height),
              sbw30(),
              _buildTextColumn(),
              _buildTextColumn(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeftImageSection(double height) {
    return Expanded(
      flex: 1,
      child: CachedNetworkImage(
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
        fit: BoxFit.cover,
        width: 400.w,
        height: Get.height,
      ),
    );
  }

  Widget _buildTextColumn() {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSectionTitle('What We Do', EraTheme.headerWeb),
          sb40(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
            child: Container(
              color: AppColors.kRedColor,
              height: 2.h,
              width: 50.w,
            ),
          ),
          sb20(),
          buildTitle(
            'Real Estate Brokerage Services',
          ),
          sb20(),
          buildDescription(
              'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the process.'),
          sb30(),
          buildTitle(
            'Agent & Broker Training',
          ),
          sb20(),
          buildDescription(
              'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.'),
          sb30(),
          buildTitle(
            'Franchise Arrangements',
          ),
          sb20(),
          buildDescription(
              'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.'),
          sb20(),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String text, double fontSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: AppColors.blue2,
      ),
    );
  }

  Widget buildDivider(Color color) {
    return Container(
      color: color,
      height: 2.h,
      width: 50.w,
    );
  }

  buildTitle(text, {fontWeight, fontSize, color}) {
    return Container(
      width: Get.width - 200.w,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb - 10.sp,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: color ?? AppColors.black,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }

  buildDescription(text, {fontWeight, fontSize, color}) {
    return Container(
      width: Get.width - 200.w,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.text15,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.hint,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildJoinUsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sb30(),
        buildTitle('Join Us Today!',
            fontSize: EraTheme.headerWeb + 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.white),
        sb20(),
        buildDescription(
          'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.',
          color: AppColors.white,
        ),
        sb20(),
        buildDescription(
          'ERA Real Estate was founded on the principle of collaboration...',
          color: AppColors.white,
        ),
        sb20(),
        buildDescription('Why Join Us?',
            color: AppColors.white,
            fontSize: EraTheme.subHeaderWeb - 4.sp,
            fontWeight: FontWeight.w600),
        ...buildBulletPoints(),
        sb30(),
      ],
    );
  }

  Widget _buildGradientSection(double width, double height) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: const [Color(0xFFC50000), Color(0xFF8C0909)],
        ),
      ),
      height: height - 350.h,
      width: width - 200.h,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: buildJoinUsSection(),
          ),
          const Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}
