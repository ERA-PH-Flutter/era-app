import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';

import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/presentation/website/buy_website/controllers/buy_web_controller.dart';
import 'package:eraphilippines/presentation/website/home_website/controllers/home_web_controller.dart';

import 'package:eraphilippines/presentation/website/landingpage/controllers/web_landingpage_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BuyWeb extends GetView<BuyWebController> {
  const BuyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BuyWebController());
    return Column(
      children: [
        WillPopScope(
          onWillPop: () => _onWillPop(),
          child: SafeArea(
            child: Obx(() => switch (controller.buylandingState.value) {
                  BuyWebState.loading => _loading(),
                  BuyWebState.loaded => _loaded(),
                  BuyWebState.error => _error(),
                  BuyWebState.empty => _empty()
                }),
          ),
        ),
      ],
    );
  }

  Future<bool> _onWillPop() {
    Get.back();
    return Future.value(false);
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return Column(
      children: [
        Container(
          child: EraText(
            text: 'THIS IS BUY',
            color: AppColors.black,
          ),
        )
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
