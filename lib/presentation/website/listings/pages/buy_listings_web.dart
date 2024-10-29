// import 'package:eraphilippines/app/constants/colors.dart';

// import 'package:eraphilippines/app/widgets/app_text.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class BuyWebs extends GetView<ListingsWebController> {
//   const BuyWebs({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.put(ListingsWebController());
//     return Column(
//       children: [
//         WillPopScope(
//           onWillPop: () => _onWillPop(),
//           child: SafeArea(
//             child: Obx(() => switch (controller.buylandingState.value) {
//                   ListingsWebState.loading => _loading(),
//                   ListingsWebState.loaded => _loaded(),
//                   ListingsWebState.error => _error(),
//                   ListingsWebState.empty => _empty()
//                 }),
//           ),
//         ),
//       ],
//     );
//   }

//   Future<bool> _onWillPop() {
//     Get.back();
//     return Future.value(false);
//   }

//   _loading() {
//     return Center(
//       child: CircularProgressIndicator(
//         color: AppColors.primary,
//       ),
//     );
//   }

//   _loaded() {
//     return Column(
//       children: [
//         Container(
//           child: EraText(
//             text: 'THIS IS BUY',
//             color: AppColors.black,
//           ),
//         )
//       ],
//     );
//   }

//   _error() {
//     return EraText(
//       text: 'errorrrr',
//       color: AppColors.black,
//     );
//   }

//   _empty() {
//     return Container(
//       child: EraText(
//         text: 'No content available',
//         color: AppColors.black,
//       ),
//     );
//   }
// }

// _buildMenuCard(text, callback, isActive) {
//   return GestureDetector(
//     onTap: callback,
//     child: Card(
//       color: isActive ? AppColors.kRedColor : AppColors.white,
//       elevation: 4,
//       child: Container(
//         height: 45.h,
//         child: Row(
//           children: [
//             Expanded(
//               child: Center(
//                 child: SizedBox(
//                   width: Get.width,
//                   child: EraText(
//                     textOverflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                     text: text,
//                     color: isActive ? AppColors.white : AppColors.black,
//                     fontSize: 40.sp,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//   );
// }
// // drawer: Drawer(
// //   child: ListView(
// //     padding: EdgeInsets.zero,
// //     children: [
// //       DrawerHeader(
// //         decoration: BoxDecoration(
// //           color: Colors.blue,
// //         ),
// //         child: navLink(text: 'Home'.toUpperCase()),
// //       ),
// //       ListTile(
// //         title: navLink(text: 'Buy'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         title: navLink(text: 'Sell'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         title: navLink(text: 'Rent'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         title: navLink(text: 'Projects'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         title: navLink(text: 'News'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         title: navLink(text: 'Contact Us'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //       ListTile(
// //         title: navLink(text: 'Join Era'.toUpperCase()),
// //         onTap: () {},
// //       ),
// //     ],
// //   ),
// // ),
