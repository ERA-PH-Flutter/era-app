import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/web/mobile_drawer.dart';
import '../../../../app/widgets/web/navbar.dart';
import '../../listings/controllers/listings_web_controller.dart';

class HomePages extends GetResponsiveView<HomsController> {
  HomePages({super.key});

  @override
  Widget phone() {
    return Scaffold(
      key: controller.scaffoldKey,
      endDrawer: AppDrawer(),
      body: Stack(children: [
        Obx(() => SizedBox(
            width: Get.width,
            height: Get.height,
            child: controller.pages[selectedIndex.value])),
        Align(
          alignment: Alignment.topCenter,
          child: Navbar(),
        )
      ]),
    );
  }

  @override
  Widget desktop() {
    Get.put(HomsController());
    return Scaffold(
      body: CustomScrollView(
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
                title: Navbar(),
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
                      Obx(
                        () => SizedBox(
                          width: Get.width,
                          child: controller.pages[selectedIndex.value],
                        ),
                      ),
                      buildFooter(),
                    ],
                  ),
                ],
              );
            },
            childCount: 1,
          ))
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Column(
      children: [
        Card(
          color: AppColors.white,
          elevation: 7,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: EraTheme.paddingWidthAdmin * 3, vertical: 20),
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _columnListing(),
                _columnAboutUs(),
                _columnERAph(),
              ],
            ),
          ),
        ),

        /// not final
        Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(vertical: 20),
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
                      faIcon: FontAwesomeIcons.facebook),
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
              selectedIndex.value = 1;
              Get.find<HomsController>().onNavbarItemSelected(1);
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
              selectedIndex.value = 5;
              Get.find<HomsController>().onNavbarItemSelected(5);
            }),
        // _buildLinkText(text: 'Why Us?', onTap: () {
        //   selectedIndex.value = 4;
        //       Get.find<HomsController>().onNavbarItemSelected(4);
        // }),
        // _buildLinkText('ERA Teach Tools'),
        //  _buildLinkText('Ultimate Agent'),
        //    _buildLinkText('Training'),
        //     _buildLinkText('Our Services'),
        _buildLinkText(
            text: 'Contact Us',
            onTap: () {
              selectedIndex.value = 4;
              Get.find<HomsController>().onNavbarItemSelected(4);
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
        Row(
          children: [
            Image.asset(
              AppEraAssets.eraPh,
              width: 200.w,
              height: 220.h,
              fit: BoxFit.cover,
            ),
            sbw10(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
          ],
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
            List<Listing> data = listings.map((listing) {
              return Listing.fromJSON(listing.data());
            }).toList();
            selectedIndex.value = 2;
            Get.find<HomsController>().onIndexChanged();
            Get.find<HomsController>().update();
            Get.find<ListingsWebController>()
                .listingsWebState(ListingsWebState.loading);
            Get.find<ListingsWebController>().searchQuery.value = text;
            await Get.find<ListingsWebController>().loadData(data);
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
// Widget _urlLaunch(){
//   return GestureDetector(onTap: ,)
// }
}
