import 'dart:math';
import 'dart:ui';

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:architecture/app/models/company_model.dart';
import 'package:architecture/app/models/company_model.dart';
import 'package:architecture/app/models/listing.dart';
import 'package:architecture/app/models/navbaritems.dart';
import 'package:architecture/app/widgets/app_divider.dart';
import 'package:architecture/app/widgets/app_nav_items.dart';
import 'package:architecture/app/widgets/app_text.dart';
import 'package:architecture/app/widgets/app_text_listing.dart';
import 'package:architecture/app/widgets/app_textfield.dart';
import 'package:architecture/app/widgets/button.dart';
import 'package:architecture/app/widgets/companynews_builder.dart';
import 'package:architecture/app/widgets/custom_image_viewer.dart';
import 'package:architecture/app/widgets/image_animation.dart';
import 'package:architecture/app/widgets/listing_items.dart';
import 'package:architecture/app/widgets/listing_properties.dart';
import 'package:architecture/app/widgets/listing_properties.dart';

import 'package:architecture/app/widgets/listing_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:architecture/app/constants/colors.dart';
import 'package:architecture/presentation/home/controllers/home_controller.dart';

import '../../../app/models/company_model.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      'assets/images/e1.JPG',
      'assets/images/e2.JPG',
      'assets/images/e3.JPG',
    ];
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 250.h,
                      child: AnotherCarousel(
                        images: const [
                          AssetImage("assets/images/e1.JPG"),
                          AssetImage("assets/images/e2.JPG"),
                          AssetImage("assets/images/e3.JPG"),
                        ],
                        autoplay: true,
                        showIndicator: true,
                        dotColor: Colors.black,
                        dotSize: 5,
                        dotBgColor: Colors.transparent,
                        borderRadius: false,
                        overlayShadow: false,
                        indicatorBgPadding: 15,
                        dotSpacing: 40,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: AppColors.hint,
                      width: 1.0,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: AppColors.hint,
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        //Location
                        AppTextField(
                          hint: 'Location',
                          svgIcon: 'assets/icons/marker.png',
                          bgColor: AppColors.white,
                        ),
                        //property type
                        SizedBox(height: 20.h),
                        AppTextField(
                          hint: 'Property Type',
                          svgIcon: 'assets/icons/house.png',
                          bgColor: AppColors.white,
                        ),
                        //price range
                        SizedBox(height: 20.h),

                        AppTextField(
                          hint: 'Price Range',
                          svgIcon: 'assets/icons/money.png',
                          bgColor: AppColors.white,
                        ),
                        //ai search
                        SizedBox(height: 20.h),

                        AppTextField(
                          hint: 'Try AI Search',
                          svgIcon: 'assets/icons/send.png',
                          bgColor: AppColors.white,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                    fillColor:
                                        WidgetStatePropertyAll(AppColors.hint),
                                    value: 1,
                                    groupValue: null,
                                    onChanged: null,
                                  ),
                                ),
                                Text(
                                  'SELL',
                                  style: TextStyle(
                                      color: AppColors.hint,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                    fillColor:
                                        WidgetStatePropertyAll(AppColors.hint),
                                    value: 1,
                                    groupValue: null,
                                    onChanged: null,
                                  ),
                                ),
                                Text(
                                  'RENT',
                                  style: TextStyle(
                                      color: AppColors.hint,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.kRedColor,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    CupertinoIcons.search,
                                    color: AppColors.white,
                                    size: 30.sp,
                                  )),
                              FarmerText(
                                text: 'Search',
                                fontSize: 30.sp,
                                fontWeight: FontWeight.w300,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ListingWidget(),

                TextListing(
                    text: 'PROJECTS',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue),
                TextListing(
                    text: 'Perspective by ERA Research & Market Intelligence',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black),
                SizedBox(
                  height: 20.h,
                ),
                TextListing(
                    text: 'FEATURED PROJECTS',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kRedColor),
                SizedBox(height: 20.h),
                Center(
                  child: Image.asset(
                    "assets/images/haraya.jpeg",
                    width: 241.w,
                    height: 91.h,
                  ),
                ),
                //NOT SURE where folder to put this dynamic carousel slider
                Container(
                  decoration: BoxDecoration(color: AppColors.carouselBgColor),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CarouselSlider(
                          items: images.map((imagePath) {
                            return Builder(builder: (BuildContext context) {
                              return CustomImageViewer.show(
                                  context: context,
                                  url: imagePath,
                                  fit: BoxFit.cover,
                                  radius: 25.0);
                            });
                          }).toList(),
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.80,
                            enlargeFactor: .4,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Button(
                  text: 'VIEW PROJECT',
                  onTap: () {},
                  bgColor: AppColors.kRedColor,
                  height: 40.h,
                  borderRadius: BorderRadius.circular(30),
                ),
                SizedBox(
                  height: 40.h,
                ),
                //divider
                AppDivider(),
                SizedBox(
                  height: 20.h,
                ),
                TextListing(
                    text: 'FEATURED LISTING',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue),
                ListingProperties(listingProperties: Listing.listings),
                TextListing(
                    text: 'COMPANY NEWS',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue),
                SizedBox(
                  height: 20.h,
                ),
                TextListing(
                    text: 'Latest News and Events from ERA PH',
                    fontSize: 12.h,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black),
                CompanynewsBuilder(companymodels: CompanyNewsModel.companynews),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          height: 70.h,
          color: AppColors.blue,
          backgroundColor: Colors.white.withOpacity(0),
          buttonBackgroundColor: Colors.white.withOpacity(0),
          index: controller.selectedIndex.value,
          onTap: controller.changeIndex,
          items: navBarItems.map((item) {
            int currentIndex = navBarItems.indexOf(item);
            String iconPath = controller.selectedIndex.value == currentIndex
                ? item.selectedIcon
                : item.defaultIcon;

            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: AppNavItems(
                  iconPath: iconPath,
                  label: item.label,
                  isActive: controller.selectedIndex.value == currentIndex),
            );
          }).toList(),
        );
      }),
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