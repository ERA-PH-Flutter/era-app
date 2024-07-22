import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';

import 'package:eraphilippines/app/models/navbaritems.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/widgets/app_divider.dart';

import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/company_grid.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/listing_properties.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/app/widgets/properties_widgets.dart';

import 'package:eraphilippines/presentation/companynews/pages/companynews.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';

import '../../../app/models/listing.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
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
                  Positioned(
                      top: 120,
                      left: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/next.png',
                          height: 20.h,
                          width: 20.w,
                        ),
                        color: AppColors.white,
                      )),
                  Positioned(
                      top: 120,
                      right: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/icons/next-r.png',
                          height: 20.h,
                          width: 20.w,
                        ),
                        color: AppColors.white,
                      )),
                ],
              ),
              //boxwiget
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: BoxWidget.boxListing(),
              ),
              PropertiesWidgets(listingsModels: PropertiesListing.listings),
              // TextListing(
              //     margin: EdgeInsets.symmetric(horizontal: 30.0),
              //     text: 'PROJECTS',
              //     fontSize: 24.sp,
              //     fontWeight: FontWeight.w600,
              //     color: AppColors.blue),
              TextListing.projectTitle(24.sp, FontWeight.w600, AppColors.blue),
              TextListing.projectSubtitle(
                  12.sp, FontWeight.w500, AppColors.black),
              SizedBox(
                height: 20.h,
              ),
              TextListing(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  text: 'Featured Projects',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kRedColor),
              SizedBox(height: 20.h),
              // haraya residences
              ProjectDivider(textImage: ProjectTextImageModels.textImageModels),

              SizedBox(
                height: 20.h,
              ),
              //NOT SURE where folder to put this dynamic carousel slider
              CarouselSliderWidget(
                images: CarouselModels.carouselModels,
              ),
              SizedBox(
                height: 20.h,
              ),
              Button(
                text: 'VIEW PROJECTS',
                onTap: () {
                  Get.toNamed("/project");
                },
                bgColor: AppColors.kRedColor,
                height: 40.h,
                borderRadius: BorderRadius.circular(30),
              ),
              SizedBox(
                height: 40.h,
              ),
              AppDivider(
                button: true,
              ),
              SizedBox(
                height: 20.h,
              ),
              TextListing(
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  text: 'FEATURED LISTING',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue),
              SizedBox(
                height: 10.h,
              ),
              //Feautured Listing properties
              ListingProperties(
                  listingModels: RealEstateListing.listingsModels),

              TextListing(
                  text: 'COMPANY NEWS',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blue),
              SizedBox(
                height: 10.h,
              ),
              TextListing(
                  text: 'Latest News and Events from ERA PH',
                  fontSize: 12.h,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black),
                  //for home page
              CompanyGrid(companymodels: CompanyModels.companyNewsModels),
              SizedBox(
                height: 20.h,
              ),
              //direct to companynews page. can find it in lib/presentation/companynews/pages/companynews.dart
              Button(
                text: 'MORE NEWS',
                fontSize: 25.sp,
                onTap: () {
                  Get.toNamed("/companynews");
                },
                bgColor: AppColors.blue,
                height: 50.h,
                width: 350.w,
                fontWeight: FontWeight.w500,
                borderRadius: BorderRadius.circular(10),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          CustomNavigationBar(navBarItems: navBarItems, controller: controller),
      //bottom navigation bar
      // bottomNavigationBar: Obx(() {
      //   return CurvedNavigationBar(
      //     height: 70.h,
      //     color: AppColors.blue,
      //     backgroundColor: Colors.white.withOpacity(0),
      //     buttonBackgroundColor: Colors.white.withOpacity(0),
      //     index: controller.selectedIndex.value,
      //     onTap: controller.changeIndex,
      //     items: navBarItems.map((item) {
      //       int currentIndex = navBarItems.indexOf(item);
      //       String iconPath = controller.selectedIndex.value == currentIndex
      //           ? item.selectedIcon
      //           : item.defaultIcon;

      //       return AppNavItems(
      //           iconPath: iconPath,
      //           label: item.label,
      //           isActive: controller.selectedIndex.value == currentIndex);
      //     }).toList(),
      //   );
      // }),
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
