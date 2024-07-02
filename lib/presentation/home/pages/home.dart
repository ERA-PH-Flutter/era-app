import 'dart:math';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:architecture/app/constants/colors.dart';
import 'package:architecture/presentation/home/controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          'assets/images/eraph_logo.png',
          fit: BoxFit.cover,
          height: 50.h,
          width: 50.w,
        ),
        backgroundColor: AppColors.white,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10.0),
        //   child: IconButton(
        //     icon: Icon(
        //       CupertinoIcons.profile_circled,
        //       color: AppColors.white,
        //     ),
        //     iconSize: 45,
        //     onPressed: () {},
        //   ),
        // ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.bars,
              color: AppColors.black,
            ),
            iconSize: 50,
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 250.h,
                  child: AnotherCarousel(
                    images: const [
                      AssetImage("assets/images/c1.jpg"),
                      AssetImage("assets/images/c1.jpg"),
                      AssetImage("assets/images/c1.jpg"),
                    ],
                    autoplay: true,
                    showIndicator: true,
                    dotColor: Colors.black,
                    dotSize: 10,
                    dotBgColor: Colors.transparent,
                    borderRadius: false,
                    overlayShadow: false,
                    indicatorBgPadding: 5,
                    dotSpacing: 40,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                //Location

                //property type

                //price range

                //ai search
              ],
            ),
          ],
        ),
      ),
    );
  }
}





// import 'package:architecture/app/constants/colors.dart';
// import 'package:architecture/presentation/home/controllers/home_controller.dart';
// import 'package:architecture/presentation/login_page/controllers/login_page_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';


// class Home extends GetView<HomeController> {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Silakan Login",
//           style: TextStyle(
//             color: AppColors.white,
//             fontSize: 20.sp,
//           ),
//         ),
//         backgroundColor: AppColors.kRedColor,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 10.0),
//           child: IconButton(
//             icon: Icon(
//               CupertinoIcons.profile_circled,
//               color: AppColors.white,
//             ),
//             iconSize: 45,
//             onPressed: () {},
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               CupertinoIcons.qrcode,
//               color: AppColors.white,
//             ),
//             onPressed: () {},
//           )
//         ],
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Stack(
//                 children: [
//                   SizedBox(
//                       width: double.infinity,
//                       height: 300.h,
//                       child: PageView.builder(
//                           controller: controller.pagesController,
//                           itemCount: imagePaths.length,
//                           itemBuilder: (context, index) {
//                             return controller.pages[index];
//                           })),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }