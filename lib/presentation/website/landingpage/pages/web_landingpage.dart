import 'package:eraphilippines/app/constants/colors.dart';

import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar_web.dart';

import 'package:eraphilippines/presentation/website/form/pages/about_us_web.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_era_web.dart';
import 'package:eraphilippines/presentation/website/home_website/pages/home_web.dart';
import 'package:eraphilippines/presentation/website/landingpage/controllers/web_landingpage_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../agents/pages/findagents.dart';
import '../../form/pages/contactus_web.dart';
import '../../form/pages/sell_property_web.dart';
import '../../listings/pages/buy_listings_web.dart';
import '../../mortageCalculator.dart/pages/MortageCalculator.dart';

class WebsiteLandingPage extends GetView<WebLandingPageController> {
  const WebsiteLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;

    Get.put(WebLandingPageController());
    return Scaffold(
      appBar: CustomAppBarWeb(
        controller: controller,
        shortestSide: shortestSide,
        navItemSelected: (index) {
          controller.pageController.jumpToPage(index);
        },
        //    navItemSelected:   ),
      ),
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
    return PageView(
      controller: controller.pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        BuyWeb(), //0
        FindAgentsWeb(), //0
        ContactUsWeb(), //1
        HomeWeb(), //2
        AboutUsWeb(), //01
        SellPropertyWeb(),
        JoinEraWeb(),
        MortageCalculatorWeb(),
      ],
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
}
     // return Row(
    //   children: [
    //     Obx(() {
    //       return IndexedStack(
    //         index: controller.currentPage.value,
    //         children: const [
    //           FindAgentsWeb(), //0
    //           ContactUsWeb(), //1
    //           HomeWeb(), //2
    //           AboutUsWeb(), //01
    //           SellPropertyWeb(),
    //           JoinEraWeb(),
    //           MortageCalculatorWeb(),
    //         ],
    //       );
    //     })
    //   ],
    // );
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
