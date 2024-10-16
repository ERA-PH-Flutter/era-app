import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/theme.dart';

class AboutUsWeb extends StatelessWidget {
  const AboutUsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              sb50(),
              Container(
                decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: const [Color(0xFFC50000), Color(0xFF8C0909)])),
                height: Get.height - 350.h,
                width: Get.width - 200.h,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          sb30(),
                          _buildTitle('Join Us Today!',
                              fontSize: EraTheme.headerWeb,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                          _buildDescription(
                              color: AppColors.white,
                              'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
                          SizedBox(
                            height: 20.h,
                          ),
                          _buildDescription(
                              color: AppColors.white,
                              'ERA Real Estate was founded on the principle of collaboration.The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared to serve your unique needs.'),
                          sb20(),
                          _buildDescription('Why Join Us?',
                              color: AppColors.white,
                              fontSize: EraTheme.subHeaderWeb - 4.sp,
                              fontWeight: FontWeight.w600),
                          ..._buildBulletPoints(),
                          sb30(),
                        ],
                      ),
                    ),
                    Expanded(flex: 1, child: Container()),
                  ],
                ),
              ),
              sb80(),
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidthAdmin + 90.w),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                            fit: BoxFit.cover,
                            width: 500.w,
                            height: Get.height),
                      ),
                      sbw30(),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: EraTheme.paddingWidth),
                              child: EraText(
                                  text: 'What We Do',
                                  fontSize: EraTheme.headerWeb,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue2),
                            ),
                            sb40(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: EraTheme.paddingWidth),
                              child: Container(
                                color: AppColors.kRedColor,
                                height: 2.h,
                                width: 50.w,
                              ),
                            ),
                            sb20(),
                            _buildTitle(
                              'Real Estate Brokerage Services',
                            ),
                            sb20(),
                            _buildDescription(
                                'Discover unparalleled expertise and personalized guidance with our premier real estate brokerage services. Whether you’re buying, selling, or investing, our seasoned professionals are committed to guiding you through every step of the process.'),
                            sb30(),
                            _buildTitle(
                              'Agent & Broker Training',
                            ),
                            sb20(),
                            _buildDescription(
                                'Elevate the careers of our agents and brokers with our comprehensive training and development programs. Our courses are designed to enhance their skills and boost their success, covering everything from mastering market trends and effective client communication to advanced negotiation tactics and cutting-edge technology.'),
                            sb30(),
                            _buildTitle(
                              'Franchise Arrangements',
                            ),
                            sb20(),
                            _buildDescription(
                                'Explore limitless possibilities of real estate franchising through our dynamic franchise arrangements. As part of our network, you’ll benefit from a proven business model, robust marketing support, and extensive operational resources tailored to maximize your growth and profitability.'),
                            sb20(),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: EraTheme.paddingWidth),
                              child: EraText(
                                  text: '',
                                  fontSize: EraTheme.headerWeb,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blue2),
                            ),
                            sb40(),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: EraTheme.paddingWidth),
                              child: Container(
                                color: AppColors.white,
                                height: 2.h,
                                width: 50.w,
                              ),
                            ),
                            sb20(),
                            _buildTitle(
                              'Property Valuation',
                            ),
                            sb20(),
                            _buildDescription(
                                'Accurate property valuation is the cornerstone of successful real estate transactions. At ERA Real Estate Philippines, we offer meticulous property valuation services designed to provide clarity and confidence to buyers, sellers, and investors alike. Backed by comprehensive market analysis and expert insights, our valuation process ensures you receive an informed and fair assessment of your property’s worth.'),
                            sb30(),
                            _buildTitle(
                              'Other Services',
                            ),
                            sb20(),
                            ..._buildOtherServices(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10.h,
            right: 100.w,
            left: Get.width * 0.5,
            child: CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
              fit: BoxFit.cover,
              height: Get.height - 300.h,
              width: Get.width,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildBulletPoints() {
    return [
      _buildDescription('• Training & Development', color: AppColors.white),
      sb10(),
      _buildDescription('• Reputable developer properties',
          color: AppColors.white),
      sb10(),
      _buildDescription('• Favourable Commission Terms',
          color: AppColors.white),
      sb10(),
      _buildDescription('• Advanced Digital Platforms', color: AppColors.white),
      sb10(),
      _buildDescription('• Administrative Support', color: AppColors.white),
      sb10(),
      _buildDescription('• Access to our office spaces & facilities',
          color: AppColors.white),
    ];
  }

  List<Widget> _buildOtherServices() {
    return [
      _buildDescription('• Legal'),
      sb10(),
      _buildDescription('• Taxation'),
      sb10(),
      _buildDescription('• Accounting'),
      sb10(),
      _buildDescription('• Marketing'),
      sb10(),
      _buildDescription('• Branding'),
    ];
  }

  _buildTitle(text, {fontWeight, fontSize, color}) {
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

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return Container(
      width: Get.width - 200.w,
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: EraText(
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb - 15.sp,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.hint,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }
}
