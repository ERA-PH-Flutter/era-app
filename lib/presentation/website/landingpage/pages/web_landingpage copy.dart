// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../../../app/widgets/web/custom_appbar_web.dart';
// import '../../agents/pages/findagents.dart';
// import '../../form/pages/contactus_web.dart';
// import '../../listings/pages/searchresult.dart';
// import '../controllers/web_landingpage_controller.dart';

// class WebsiteLandingPage extends GetView<WebLandingPageController> {
//   const WebsiteLandingPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     double headerHeight = 80.h;
//     double contentHeight = 400.h;
//     double footerHeight = 100.h;
//     return Stack(
//       children: [
//         LayoutBuilder(
//           builder: (context, constraints) {
//             double screenHeight =
//                 constraints.maxHeight - (headerHeight + footerHeight);
//             return SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: screenHeight,
//                 ),
//                 child: Column(
//                   children: [
//                     MyHeader(height: headerHeight),
//                     MyContents(height: contentHeight),

//                     // Dynamic position of height space widgets..
//                     if (contentHeight < screenHeight) ...[
//                       SizedBox(height: screenHeight - contentHeight)
//                     ],
//                     MyFooter(height: footerHeight),
//                   ],
//                 ),
//               ),
//             );
//           },
//         )
//       ],
//     );
//   }
// }

// class MyHeader extends StatelessWidget {
//   final double height;
//   const MyHeader({Key? key, required this.height}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     var shortestSide = MediaQuery.of(Get.context!).size.shortestSide;
//     WebLandingPageController controller = Get.put(WebLandingPageController());

//     return CustomAppBarWeb(
//       webcontroller: controller,
//       shortestSide: shortestSide,
//       navItemSelected: (index) {
//         controller.pageController.jumpToPage(index);
//       },
//     );
//   }
// }

// class MyContents extends StatelessWidget {
//   final double height;
//   const MyContents({Key? key, required this.height}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     WebLandingPageController controller = Get.put(WebLandingPageController());

//     return SizedBox(
//       height: Get.height,
//       width: Get.width,
//       child: PageView(
//         controller: controller.pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: const [
//           BuyWeb(), //0
//           // FindAgentsWeb(), //0
//           ContactUsWeb(), //1
//           // HomeWeb(), //2
//           // AboutUsWeb(), //01
//           // SellPropertyWeb(),
//           // JoinEraWeb(),
//           // MortageCalculatorWeb(),
//         ],
//       ),
//     );
//   }
// }

// class MyFooter extends StatelessWidget {
//   final double height;
//   const MyFooter({Key? key, required this.height}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black,
//       height: height,
//       child: const Center(
//         child: Text(
//           'Footer Widget',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }
