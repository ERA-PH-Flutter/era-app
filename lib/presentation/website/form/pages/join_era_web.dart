import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/screens.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/authentication/controller/authentication_controller.dart';
import 'package:eraphilippines/presentation/website/form/pages/about_us_web.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_us_terms_condition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/widgets/button.dart';
import '../../authentication/pages/create_account_web.dart';
import '../controllers/form_web_controller.dart';

class JoinEraWeb extends GetResponsiveView<FormWebController> {
  JoinEraWeb({super.key});

  Widget _buildContent(width, height) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.kRedColor,
                    AppColors.kRedColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    left: -50,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -70,
                    right: -70,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 40.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('cms')
                                .doc('about_us')
                                .get(),
                            builder: (contect, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.data();
                                print('DATA PHOTO: ${data!['photo']}');
                                return CloudStorage().imageLoader(
                                  reference: data['photo'],
                                  height: Get.height * 0.8,
                                  width: Get.width * 0.85,
                                  fit: BoxFit.cover,
                                );
                              }
                              return Screens.loading();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb15(),
              //text era
              joinUsToday(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sb50(),
                          EraText(
                            text: 'About Us',
                            fontSize: EraTheme.h1,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kRedColor,
                          ),
                          sb20(),
                          _buildDescription(
                            'Welcome to a new ERA of property discovery and management.',
                          ),
                          sb40(),
                          _buildDescription(
                              'ERA Real Estate Philippines is a proud member of ERA Real Estate, the largest real estate network in the Asia-Pacific region with more than 23,400 trusted advisers in over 640 offices across 13 countries. We provide exceptional real estate services, guiding you through buying, selling, and investing.'),
                          sb40(),
                        ],
                      )),
                  sbw50(),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: buildWidgetColumn3(),
                    ),
                  ),
                ],
              ),

              _buildDescription(
                  'We envision a world where searching for and managing real estate is as simple as a few taps on your phone. With the ERA Real Estate Philippines app, we aim to redefine the property landscape in the Philippines by providing cutting-edge tools and resources that enable you to make informed decisions with confidence.'),
              sb40(),
              _buildDescription(
                  'At ERA Real Estate Philippines, we empower you to achieve your real estate dreams. Discover the ERA difference today!'),
              sb50(),
              EraText(
                text: 'What We Do',
                fontSize: EraTheme.h1,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              sb30(),
              buildServices(),
              sb40(),
              sb50(),
            ],
          ),
        ),
      ],
    );
  }

  Widget joinUsToday() {
    return Column(
      children: [
        sb20(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(flex: 1, child: _buildTextJoinEra()),
            sbw50(),
            Expanded(
              flex: 1,
              child: Container(
                width: Get.width,
                height: 350.h,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.kRedColor,
                      AppColors.kRedColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EraText(
                      text: 'Join ERA Today!',
                      fontSize: EraTheme.h1,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                      textAlign: TextAlign.center,
                    ),
                    EraText(
                      text:
                          'Be part of an international brand with 2,390 offices globally.',
                      fontSize: EraTheme.h6,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.7),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 15.h),
                    Button(
                      text: "Get Started",
                      fontSize: EraTheme.h6,
                      bgColor: AppColors.white,
                      onTap: () {
                        showDialog(
                            context: Get.context!,
                            builder: (context) {
                              return Dialog(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none),
                                  insetPadding: EdgeInsets.symmetric(
                                      horizontal:
                                          EraTheme.paddingWidthAdmin * 6,
                                      vertical: EraTheme.paddingWidthAdmin * 2),
                                  backgroundColor: AppColors.white,
                                  child: Scaffold(
                                    appBar: AppBar(
                                      backgroundColor: AppColors.white,
                                      surfaceTintColor: AppColors.white,
                                      automaticallyImplyLeading: false,
                                      centerTitle: true,
                                      title: EraText(
                                        text: 'Terms and Conditions',
                                        fontSize: EraTheme.paragraphWeb,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.black,
                                      ),
                                      scrolledUnderElevation: 4,
                                      toolbarHeight: 100.h,
                                      elevation: 0,
                                    ),
                                    body: Stack(
                                      children: [
                                        // SliverAppBar(),
                                        CustomScrollView(
                                          controller:
                                              controller.scrollController,
                                          slivers: [
                                            SliverToBoxAdapter(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: EraTheme
                                                          .paddingWidthAdmin -
                                                      10.sp,
                                                ),
                                                child:
                                                    termsAndConditionWidget(),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: BottomAppBar(
                                            color: AppColors.white,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Obx(
                                                  () => Button(
                                                    text: 'Accept',
                                                    color: AppColors.blue,
                                                    width: Get.width / 5,
                                                    onTap: controller
                                                            .isAtBottom.value
                                                        ? () {
                                                            AuthenticationWebController
                                                                controllerAuth =
                                                                Get.put(
                                                                    AuthenticationWebController());
                                                            // Get.toNamed(RouteString
                                                            //     .createaccountweb);
                                                            createAccountWeb(
                                                                controller:
                                                                    controllerAuth);
                                                          }
                                                        : null,

                                                    fontSize:
                                                        EraTheme.paragraphWeb,

                                                    bgColor: controller
                                                            .isAtBottom.value
                                                        ? AppColors.white
                                                        : AppColors.hint
                                                            .withOpacity(0.2),
                                                    // borderSide: BorderSide(color: AppColors.blue),
                                                    border: Border.all(
                                                        color: AppColors.blue),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                ),
                                                sbw20(),
                                                Button(
                                                  text: 'Decline',
                                                  width: Get.width / 5,
                                                  fontSize:
                                                      EraTheme.paragraphWeb,
                                                  onTap: () {
                                                    Get.back();
                                                  },
                                                  bgColor: AppColors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            });
                      },
                      color: AppColors.kRedColor,
                      borderRadius: BorderRadius.circular(30),
                      width: 200.w,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextJoinEra() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb50(),
        EraText(
            textAlign: TextAlign.start,
            text: 'Join Us Today!',
            fontSize: EraTheme.headerWeb,
            fontWeight: FontWeight.w600,
            color: AppColors.kRedColor),
        sb40(),
        _buildDescription(
            'Be part of an international brand with 2,390 offices and over 40,500 realtors globally.'),
        sb40(),
        _buildDescription(
            'ERA Real Estate was founded on the principle of collaboration.'),
        _buildDescription(
            'The idea that by working together and supporting one another, we can create a stronger, more knowledgeable community of real estate professionals who are better prepared to serve your unique needs.'),
      ],
    );
  }

  Widget _buildRichText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By continuing, you agree to our ',
              style: TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w500,
                fontSize: EraTheme.paragraphWeb - 10.sp,
              ),
              children: [
                TextSpan(
                  text: 'Terms',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                  ),
                ),
                TextSpan(
                  text: ' and ',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: EraTheme.paragraphWeb - 10.sp,
                  ),
                ),
              ]),
        ),
      ],
    );
  }

  _buildDescription(text, {fontWeight, fontSize, color}) {
    return EraText(
        textAlign: TextAlign.start,
        text: text,
        maxLines: 50,
        fontSize: fontSize ?? EraTheme.paragraphWeb,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.black);
  }

  Widget text(String text) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: EraText(
              text: text,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
              maxLines: 50,
            )),
      ],
    );
  }

  Widget _buildTablet(width, height) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: Get.height,
              width: Get.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.kRedColor,
                    AppColors.kRedColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    left: -50,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -70,
                    right: -70,
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 40.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection('cms')
                                .doc('about_us')
                                .get(),
                            builder: (contect, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!.data();
                                print('DATA PHOTO: ${data!['photo']}');
                                return CloudStorage().imageLoader(
                                  reference: data['photo'],
                                  height: Get.height * 0.8,
                                  width: Get.width * 0.85,
                                  fit: BoxFit.cover,
                                );
                              }
                              return Screens.loading();
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sb15(),
              //text era
              joinUsToday(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sb50(),
                          EraText(
                            text: 'About Us',
                            fontSize: EraTheme.h1,
                            fontWeight: FontWeight.bold,
                            color: AppColors.kRedColor,
                          ),
                          sb20(),
                          _buildDescription(
                            'Welcome to a new ERA of property discovery and management.',
                          ),
                          sb40(),
                          _buildDescription(
                              'ERA Real Estate Philippines is a proud member of ERA Real Estate, the largest real estate network in the Asia-Pacific region with more than 23,400 trusted advisers in over 640 offices across 13 countries. We provide exceptional real estate services, guiding you through buying, selling, and investing.'),
                          sb40(),
                        ],
                      )),
                  sbw50(),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: buildWidgetColumn3(),
                    ),
                  ),
                ],
              ),

              _buildDescription(
                  'We envision a world where searching for and managing real estate is as simple as a few taps on your phone. With the ERA Real Estate Philippines app, we aim to redefine the property landscape in the Philippines by providing cutting-edge tools and resources that enable you to make informed decisions with confidence.'),
              sb40(),
              _buildDescription(
                  'At ERA Real Estate Philippines, we empower you to achieve your real estate dreams. Discover the ERA difference today!'),
              sb50(),
              EraText(
                text: 'What We Do',
                fontSize: EraTheme.h1,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              sb30(),
              buildServices(),
              sb40(),
              sb50(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhone(width, height) {
    return Container();
  }

  @override
  Widget phone() =>
      Center(child: _buildPhone(Get.width * 0.9, Get.height * 0.4));

  @override
  Widget tablet() =>
      Center(child: _buildTablet(Get.width * 0.6, Get.height * 0.5));

  @override
  Widget desktop() =>
      Center(child: _buildContent(Get.width * 0.4, Get.height * 0.5));
}
