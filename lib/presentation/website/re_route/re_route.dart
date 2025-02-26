import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/presentation/website/re_route/re_route_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/constants/assets.dart';
import '../../../app/constants/colors.dart';
import '../../../app/constants/sized_box.dart';
import '../../../app/constants/theme.dart';
import '../../../app/widgets/app_text.dart';
import '../../../app/widgets/web/navbar.dart';
import '../landingpage/controller/homs_controller.dart';
import '../listings/controllers/listings_web_controller.dart';

class ReRoute extends GetView<ReRouteController> {
  final String? params;
  const ReRoute({this.params, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth > 800) {
        return _desktopView();
      } else {
        return _mobileView();
      }
    }));
  }

  _mobileView() {
    return Column(
      children: [
        Obx(() => controller.isNavbarVisible.value ? Navbar() : SizedBox()),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                controller.args!.page,
                buildFooter(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _desktopView() {
    return CustomScrollView(
      controller: controller.scrollController,
      slivers: [
        Obx(
          () => SliverAppBar(
            automaticallyImplyLeading: false,
            collapsedHeight: 155.h,
            backgroundColor: AppColors.white,
            floating: false,
            pinned: controller.isNavbarVisible.value,
            flexibleSpace: FlexibleSpaceBar(
              title: Get.currentRoute != "/privacy-policy"
                  ? Navbar()
                  : Container(),
              background: Container(
                color: AppColors.white,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Stack(
              children: [
                Column(
                  children: [
                    controller.args!.page,
                    buildFooter(),
                  ],
                ),
              ],
            );
          },
          childCount: 1,
        ))
      ],
    );
  }

  Widget buildFooter() {
    return Column(
      children: [
        Card(
          color: AppColors.white,
          elevation: 7,
          child: Container(
            //color: Colors.black,
            padding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidthAdmin * 3,
            ),
            width: Get.width,
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnListing(),
                      _columnAboutUs(),
                      _columnERAph(),
                    ],
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _columnListing(),
                      SizedBox(height: 20),
                      _columnAboutUs(),
                      SizedBox(height: 20),
                      _columnERAph(),
                    ],
                  );
                }
              },
            ),
          ),
        ),
        Container(
          width: Get.width,
          color: AppColors.blue2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  socialMedia(
                    onTap: () {
                      launchUrl(controller.facebook);
                    },
                    faIcon: FontAwesomeIcons.facebook,
                  ),
                  socialMedia(
                    faIcon: FontAwesomeIcons.instagram,
                    onTap: () {
                      launchUrl(controller.instagram);
                    },
                  ),
                ],
              ),
              EraText(
                text:
                    '© 2024 ERA Real Estate Philippines. All rights reserved.',
                color: AppColors.white,
                fontSize: EraTheme.paragraphWeb - 10.sp,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _columnListing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb30(),
        _sectionTitle(
          'LISTINGS',
        ),
        sb10(),
        _buildLinkText(
            text: 'Projects',
            onTap: () {
              Get.toNamed('/projects');
            }),
        _buildLinkText(
          text: 'Residential',
        ),
        _buildLinkText(
          text: 'Commercial',
        ),
        _buildLinkText(
          text: 'Rental',
        ),
        _buildLinkText(
          text: 'Auction',
        ),
      ],
    );
  }

  Widget _columnAboutUs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb30(),
        _sectionTitle('ABOUT US'),
        sb10(),
        _buildLinkText(
            text: 'Join Us',
            onTap: () {
              Get.toNamed('/join-us');
            }),
        _buildLinkText(
            text: 'Contact Us',
            onTap: () {
              Get.toNamed('/help');
            }),
        _buildLinkText(
            text: 'Privacy Policy',
            onTap: () {
              Get.toNamed('/privacy-policy');
              // selectedIndex.value = 21;
              // Get.find<HomsController>().onNavbarItemSelected(21);
            }),
      ],
    );
  }

  Widget _columnERAph() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sb30(),
        _sectionTitle('ERA PHILIPPINES'),
        sb10(),
        Container(
          height: 300.h,
          width: 500.w,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildLinkText(
                        text:
                            'Address: 1212 Century Spire Bldg.\nCentury City, Kalayaan Ave.\nMakati City',
                        onTap: () {}),
                    _buildLinkTextWithIcon(
                      'Phone: +639177710572',
                      onTap: () {
                        launchUrl(controller.whatsappUrl);
                      },
                    ),
                    _buildLinkTextWithIcon(
                      'Email: sales@eraphilippines.com',
                      onTap: () {
                        launchUrl(controller.emailUrl);
                      },
                    ),
                  ],
                ),
              ),
              //   sbw10(),
              Positioned(
                  top: -20.h,
                  left: 0.w,
                  child: Container(
                    child: Image.asset(
                      AppEraAssets.eraPh,
                      width: 200.w,
                      height: 260.h,
                      fit: BoxFit.cover,
                    ),
                  )),
              sbw10(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: text,
          color: AppColors.blue2,
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.bold,
        ),
        Divider(color: AppColors.blue2, thickness: 2),
      ],
    );
  }

  Widget _buildLinkTextWithIcon(String text, {void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: EraText(
        text: text,
        fontSize: EraTheme.h6,
        color: AppColors.blue2,
      ),
    );
  }

  Widget socialMedia({void Function()? onTap, IconData? faIcon}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        color: AppColors.blue.withOpacity(0.4),
        child:
            FaIcon(faIcon, color: AppColors.white, size: 30).paddingAll(8.sp),
      ),
    );
  }

  Widget _buildLinkText({String? text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap ??
          () async {
            List eraTranslated = [
              ['type', 'pre_selling'],
              ['type', 'pre_selling'],
              ['type', 'pre_selling'],
              ['type', 'pre_selling'],
              ['type', 'pre_selling']
            ];
            List eraList = [
              'PRE-SELLING',
              'RESIDENTIAL',
              'RENTAL',
              'COMMERCIAL',
              'AUCTION'
            ];
            var listings = (await FirebaseFirestore.instance
                    .collection('listings')
                    .where('type', isEqualTo: text!.toLowerCase())
                    .get())
                .docs;
            var data = listings.map((listing) {
              return listing.data();
            }).toList();
            selectedIndex.value = 2;
            Get.find<HomsController>().onIndexChanged();
            Get.find<HomsController>().update();
            Get.find<ListingsWebController>()
                .listingsWebState(ListingsWebState.loading);
            Get.find<ListingsWebController>().searchQuery.value = text;
            await Get.find<ListingsWebController>()
                .loadData(data.map((e) => Listing.fromJSON(e)).toList());
            if (data.isEmpty) {
              Get.find<ListingsWebController>()
                  .listingsWebState(ListingsWebState.empty);
            } else {
              Get.find<ListingsWebController>()
                  .listingsWebState(ListingsWebState.loaded);
            }
          },
      child: EraText(
        text: text!,
        color: AppColors.blue2,
        fontSize: EraTheme.h6,
      ),
    );
  }
}
