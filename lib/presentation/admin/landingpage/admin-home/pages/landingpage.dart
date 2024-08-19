// import 'package:eraphilippines/app/constants/assets.dart';
// import 'package:eraphilippines/app/constants/colors.dart';
// import 'package:eraphilippines/app/widgets/app_text.dart';
// import 'package:eraphilippines/app/widgets/custom_appbar_admin.dart';
// import 'package:eraphilippines/presentation/admin/dashboard/customer_reviews/pages/customer_reviews.dart';
// import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/pages/home_analytics.dart';
// import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';

// import 'package:eraphilippines/presentation/admin/listingsE/add_edit_listings.dart/pages/add_listings.dart';
// import 'package:eraphilippines/presentation/admin/listingsE/add_edit_listings.dart/pages/edit_listings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// //todo: nikko, i want you to check my code if it is correct, so later on you wont have a hard time to fix it.
// List<Widget> _screens = [
//   AddListingsAdmin(), // Index 0
//   HomeAnalytics(),
//   CustomerReviews(),
//   EditListingsAdmin(),
// ];

// var _selectedIndex = 0.obs;

// void _onItemTapped(int index) {
//   _selectedIndex.value = index;
// }

// class LandingPage extends GetView<LandingPageController> {
//   const LandingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         height: 130.h,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: 45.w,
//               color: AppColors.blue,
//               child: Image.asset(
//                 AppEraAssets.eraPhLogo,
//               ),
//             ),
//             Flexible(
//               child: Column(
//                 children: [
//                   Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Image.asset(
//                         AppEraAssets.notifAdmin,
//                         height: 50.h,
//                       ),
//                       Image.asset(
//                         AppEraAssets.helpAdmin,
//                         height: 50.h,
//                       ),
//                       Image.asset(
//                         AppEraAssets.mailAdmin,
//                         height: 60.h,
//                       ),
//                       Image.asset(
//                         AppEraAssets.profileAdmin,
//                         height: 80.h,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(right: 8.w),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             EraText(
//                               text: 'FirstName LastName',
//                               color: AppColors.white,
//                               fontSize: 3.sp,
//                             ),
//                             EraText(
//                               text: 'Status',
//                               color: AppColors.white,
//                               fontSize: 3.sp,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   Spacer(),
//                   Container(
//                     height: 50.h,
//                     width: Get.width,
//                     color: Colors.grey[350],
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 5.w, bottom: 10.h),
//                       child: EraText(
//                         text: ' Dashboard',
//                         color: AppColors.black,
//                         fontSize: 8.sp,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: WillPopScope(
//         onWillPop: () {
//           Get.back();
//           return Future.value(false);
//         },
//         child: SafeArea(
//           child: Obx(() => switch (controller.landingState.value) {
//                 LandingState.loading => _loading(),
//                 LandingState.loaded => _loaded(),
//                 LandingState.error => _error(),
//                 LandingState.empty => _empty()
//               }),
//         ),
//       ),
//     );
//   }

//   _loading() {
//     return Center(
//       child: CircularProgressIndicator(
//         color: AppColors.primary,
//       ),
//     );
//   }

//   _loaded() {
//     //
//     return Row(
//       children: [
//         Container(
//           width: 45.w,
//           color: AppColors.hint.withOpacity(0.3),
//           child: _buildSidebarMenu(),
//         ),
//         Expanded(child: _screens[_selectedIndex.value]),
//       ],
//     );
//   }

//   _error() {
//     //todo add error screen
//   }
//   _empty() {
//     //todo add empty screen
//   }

//   Widget _buildSidebarMenu() {
//     return ListView(
//       children: [
//         _buildExpansionTile(
//           text: "DASHBOARD",
//           image: AppEraAssets.dashboard,
//           children: [
//             _buildMenuItem('Home Analytics', 0),
//             _buildMenuItem('Reviews Customer', 1),
//           ],
//         ),
//         // _buildExpansionTile(
//         //   text: "AGENTS",
//         //   image: AppEraAssets.agentDash,
//         //   children: [
//         //     _buildMenuItem('Home Analytics', 2),
//         //     _buildMenuItem('Reviews Customer', 3),
//         //   ],
//         // ),
//         _buildExpansionTile(
//           text: "LISTINGS",
//           image: AppEraAssets.agentDash,
//           children: [
//             _buildMenuItem('ADD PROJECT', 2),
//             _buildMenuItem('EDIT PROJECT', 3),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMenuItem(String title, int pageIndex) {
//     return Obx(() {
//       bool isSelected = _selectedIndex.value == pageIndex;
//       return Ink(
//         child: ListTile(
//           title: Center(
//             child: EraText(
//               text: title,
//               lineHeight: 0.2.h,
//               fontSize: 3.sp,
//               color: isSelected ? AppColors.kRedColor : AppColors.black,
//             ),
//           ),
//           onTap: () {
//             _onItemTapped(pageIndex);
//           },
//         ),
//       );
//     });
//   }

//   Widget _buildExpansionTile({
//     required String text,
//     required String image,
//     required List<Widget> children,
//   }) {
//     return ExpansionTile(
//       leading: const SizedBox(),
//       title: Column(
//         children: [
//           SizedBox(
//             height: 20.h,
//           ),
//           Image.asset(
//             image,
//             height: 65.h,
//           ),
//           SizedBox(
//             height: 5.h,
//           ),
//           EraText(
//             text: text,
//             fontSize: 2.5.sp,
//             color: AppColors.blue,
//             fontWeight: FontWeight.w700,
//           )
//         ],
//       ),
//       trailing: const SizedBox(),
//       children: children,
//     );
//   }
// }
