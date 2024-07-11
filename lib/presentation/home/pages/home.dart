
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/widgets/app_nav_items.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/app/widgets/listing_widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';

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
                      height: 269.h,
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
                SizedBox(height: 40.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
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
                          hint: 'Location',
                          svgIcon: 'assets/icons/house.png',
                          bgColor: AppColors.white,
                        ),
                        //price range
                        SizedBox(height: 20.h),

                        AppTextField(
                          hint: 'Location',
                          svgIcon: 'assets/icons/money.png',
                          bgColor: AppColors.white,
                        ),
                        //ai search
                        SizedBox(height: 20.h),

                        AppTextField(
                          hint: 'Location',
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
                SizedBox(
                  height: 30.h,
                ),
                ListingWidget(),
                SizedBox(
                  height: 20.h,
                ),
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
                //NOT SURE where folder to put this dynamic carousel slider
                Container(
                  padding: EdgeInsets.all(15.0),
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
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 0.8,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 360.w,
                  height: 343.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/c1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/eraph_logo.png',
                        fit: BoxFit.cover,
                        height: 50.h,
                        width: 50.w,
                      ),
                      Text(''),
                      Button(
                        text: 'VIEW PROJECT',
                        onTap: () {},
                        bgColor: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          height: 75.h,
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

            return AppNavItems(iconPath: iconPath, label: item.label,isActive: controller.selectedIndex.value == currentIndex);
          }).toList(),
        );
      }),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Business',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.school),
      //       label: 'School',
      //     ),
      //   ],
      //   // currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.amber[800],
      //   // onTap: _onItemTapped,
      // ),
    );
  }
}

// import 'package:eraphilippines/app/constants/colors.dart';
// import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
// import 'package:eraphilippines/presentation/login_page/controllers/login_page_controller.dart';
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
