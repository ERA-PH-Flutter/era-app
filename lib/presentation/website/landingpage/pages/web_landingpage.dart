import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/website/buy_website/pages/buy_web.dart';

import 'package:eraphilippines/presentation/website/form/pages/about_us_web.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_era_web.dart';
import 'package:eraphilippines/presentation/website/home_website/pages/home_web.dart';
import 'package:eraphilippines/presentation/website/landingpage/controllers/web_landingpage_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../router/route_string.dart';
import '../../../admin/authentication.dart';

class WebsiteLandingPage extends GetView<WebLandingPageController> {
  const WebsiteLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;

    Get.put(WebLandingPageController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120.h,
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        title: shortestSide > 600
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppEraAssets.eraPh,
                    height: 120.h,
                  ),
                  navigation(),
                  Button(
                    borderRadius: BorderRadius.circular(20),
                    width: 300.w,
                    onTap: () {
                      // controller.login();
                      Get.toNamed(RouteString.webLoginPage);
                      print('print click!!!');
                    },
                    text: "AGENT/BROKER LOGIN",
                    bgColor: AppColors.kRedColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              )
            : Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppEraAssets.eraPh,
                        height: 120.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.controller.isShowing
                              ? controller.controller.hide()
                              : controller.controller.show();
                        },
                        child: OverlayPortal(
                            controller: controller.controller,
                            overlayChildBuilder: (BuildContext context) {
                              return Positioned(
                                top: 103,
                                right: 0,
                                child: Wrap(
                                  children: [
                                    Container(
                                      width: Get.width / 2,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(13.r),
                                        color: Colors.white.withOpacity(0.9),
                                      ),
                                      child: Column(
                                        children: [
                                          _buildMenuCard('Home', () {
                                            controller.currentPage(0);
                                          }, true),
                                          _buildMenuCard('Buy', () {
                                            print('buy print'
                                                '${controller.currentPage(1)}');
                                            controller.currentPage(1);
                                          }, false),
                                          _buildMenuCard('Sell', () {}, false),
                                          _buildMenuCard('Rent', () {}, false),
                                          _buildMenuCard(
                                              'Projects', () {}, false),
                                          _buildMenuCard('News', () {}, false),
                                          _buildMenuCard(
                                              'Contact Us', () {}, false),
                                          _buildMenuCard(
                                              'Join Era', () {}, false),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Image.asset(
                              AppEraAssets.menubar,
                              height: 65,
                              width: 65,
                            )),
                      ),
                      // Builder(builder: (context) {
                      //   return IconButton(
                      //     iconSize: 50.h,
                      //     icon: Icon(
                      //       Icons.menu,
                      //     ),
                      //     onPressed: () {
                      //       Scaffold.of(context).openDrawer();
                      //     },
                      //   );
                      // })
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    top: 100,
                    child: Divider(
                      thickness: 5,
                      color: AppColors.kRedColor,
                    ),
                  ),
                ],
              ),
      ),
      //  drawer:

      body: WillPopScope(
        onWillPop: () => _onWillPop(),
        child: SafeArea(
          child: Obx(() => switch (controller.weblandingState.value) {
                WebLandingState.loading => _loading(),
                WebLandingState.loaded => _loaded(),
                WebLandingState.error => _error(),
                WebLandingState.empty => _empty()
              }),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    Get.back();
    return Future.value(false);
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.kRedColor,
      ),
    );
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Row(
        children: [
          Obx(() {
            return IndexedStack(
              index: controller.currentPage.value,
              children: const [
                HomeWeb(), //0
                AboutUsWeb(), //01

                BuyWeb(),
                AboutUsWeb(), //01
                AboutUsWeb(), //01
                JoinEraWeb()
                // BuyWeb(),
              ],
            );
          })
        ],
      ),
    );
  }

  _error() {
    return EraText(
      text: 'errorrrr',
      color: AppColors.black,
    );
  }

  _empty() {
    return Container(
      child: EraText(
        text: 'No content available',
        color: AppColors.black,
      ),
    );
  }

  Widget navigation() {
    return Flexible(
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          navLink(
              text: 'Home'.toUpperCase(),
              onPressed: () {
                controller.currentPage(0);
              }),
          sbw10(),
          navLink(
              text: 'Find Properties'.toUpperCase(),
              onPressed: () {
                controller.currentPage(1);
              }),
          sbw10(),
          navLink(
              text: 'Projects'.toUpperCase(),
              onPressed: () {
                controller.currentPage(2);
              }),
          navLink(
              text: 'Find Agents'.toUpperCase(),
              onPressed: () {
                controller.currentPage(3);
              }),
          sbw10(),
          navLink(
              text: 'About us'.toUpperCase(),
              onPressed: () {
                controller.currentPage(4);
              }),
          sbw10(),
          navLink(
              text: 'Join Era'.toUpperCase(),
              onPressed: () {
                controller.currentPage(5);
              }),
          sbw10(),
          navLink(
              text: 'Sell Property'.toUpperCase(),
              onPressed: () {
                controller.currentPage(5);
              }),
          sbw10(),
          navLink(
              text: 'Contact Us'.toUpperCase(),
              onPressed: () {
                controller.currentPage(1);
              }),
          sbw10(),
          navLink(
              text: 'Mortgage Calculator'.toUpperCase(),
              onPressed: () {
                controller.currentPage(1);
              }),
        ],
      ),
    );
  }

  Widget navLink({
    final String? text,
    required Function onPressed,
  }) {
    var isClick = false.obs;

    return TextButton(
      onPressed: () {
        onPressed();
      },
      child: EraText(
        text: text!,
        color: AppColors.hint,
        fontWeight: FontWeight.bold,
        fontSize: EraTheme.subHeader - 5.sp,
      ),
    );
  }
}

_buildMenuCard(text, callback, isActive) {
  return GestureDetector(
    onTap: callback,
    child: Card(
      color: isActive ? AppColors.kRedColor : AppColors.white,
      elevation: 4,
      child: Container(
        height: 45.h,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: Get.width,
                  child: EraText(
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    text: text,
                    color: isActive ? AppColors.white : AppColors.black,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
// drawer: Drawer(
//   child: ListView(
//     padding: EdgeInsets.zero,
//     children: [
//       DrawerHeader(
//         decoration: BoxDecoration(
//           color: Colors.blue,
//         ),
//         child: navLink(text: 'Home'.toUpperCase()),
//       ),
//       ListTile(
//         title: navLink(text: 'Buy'.toUpperCase()),
//         onTap: () {},
//       ),
//       ListTile(
//         title: navLink(text: 'Sell'.toUpperCase()),
//         onTap: () {},
//       ),
//       ListTile(
//         title: navLink(text: 'Rent'.toUpperCase()),
//         onTap: () {},
//       ),
//       ListTile(
//         title: navLink(text: 'Projects'.toUpperCase()),
//         onTap: () {},
//       ),
//       ListTile(
//         title: navLink(text: 'News'.toUpperCase()),
//         onTap: () {},
//       ),
//       ListTile(
//         title: navLink(text: 'Contact Us'.toUpperCase()),
//         onTap: () {},
//       ),
//       ListTile(
//         title: navLink(text: 'Join Era'.toUpperCase()),
//         onTap: () {},
//       ),
//     ],
//   ),
// ),
