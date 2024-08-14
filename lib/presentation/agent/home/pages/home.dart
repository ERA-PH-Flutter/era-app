import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/models/companynews_model.dart';
import 'package:eraphilippines/app/models/hero_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/models/propertieslisting.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_divider.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/company/company_grid.dart';
import 'package:eraphilippines/app/widgets/custom_image_viewer.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/listings/gridView_Listing.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/app/widgets/listings/properties_widgets.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
import '../../searchresult/controllers/searchresult_binding.dart';
import '../../searchresult/pages/searchresult.dart';
import '../controllers/home_controller.dart';

class Home extends GetView<HomeController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      //todo for later
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Obx(() => switch (controller.homeState.value) {
                HomeState.loading => _loading(),
                HomeState.loaded => _loaded(),
                HomeState.error => _error(),
              }),
        ),
      ),
    );
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //carousel
        SizedBox(
            height: 320.h,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CarouselSlider(
                      controller: controller.innerController,
                      items: HeroImage.heroImages.map((imagePath) {
                        return CustomImage(
                          url: imagePath,
                        );
                      }).toList(),
                      options: CarouselOptions(
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlay: true,
                        viewportFraction: 1,
                        aspectRatio: 1.2,
                        onPageChanged: (index, reason) =>
                            controller.carouselIndex.value = index,
                      )),
                ),
                Positioned(
                  bottom: 10,
                  child: SizedBox(
                    width: Get.width,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => AnimatedSmoothIndicator(
                                activeIndex: controller.carouselIndex.value,
                                count: controller.images.length,
                                effect: JumpingDotEffect(
                                  spacing: 25,
                                  dotWidth: 8,
                                  dotHeight: 8,
                                  activeDotColor: AppColors.black,
                                  dotColor: AppColors.hint,
                                ),
                              )),
                        ]),
                  ),
                ),
                Positioned(
                  left: 10.w,
                  child: Container(
                    height: 320.h,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.prevImage();
                        controller.innerController.previousPage();
                      },
                      child: Image.asset(
                        AppEraAssets.next,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  child: Container(
                    height: 320.h,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        controller.nextImage(controller.images.length);
                        controller.innerController.nextPage();
                      },
                      child: Image.asset(
                        AppEraAssets.prev,
                        height: 20.h,
                        width: 20.w,
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: BoxWidget.build(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                //Location
                AppTextField(
                  controller: controller.locationController,
                  hint: 'Location',
                  svgIcon: AppEraAssets.marker,
                  bgColor: AppColors.white,
                ),
                //property type
                SizedBox(height: 20.h),
                AppTextField(
                  controller: controller.propertyController,
                  hint: 'Property Type',
                  svgIcon: AppEraAssets.house,
                  bgColor: AppColors.white,
                ),
                //price range
                SizedBox(height: 20.h),
                AppTextField(
                  controller: controller.priceController,
                  hint: 'Price Range',
                  svgIcon: AppEraAssets.money,
                  bgColor: AppColors.white,
                ),
                //ai search
                SizedBox(height: 20.h),
                AppTextField(
                  controller: controller.aiSearchController,
                  hint: 'AI Search',
                  svgIcon: AppEraAssets.send,
                  bgColor: AppColors.white,
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.9,
                            child: Radio(
                                fillColor: WidgetStateProperty.all(
                                    AppColors.white.withOpacity(0.6)),
                                value: 1,
                                groupValue: controller.isForSale.value,
                                onChanged: (value) {
                                  controller.isForSale.value = value ?? 0;
                                }),
                          ),
                          EraText(
                              text: 'SELL',
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                      Row(
                        children: [
                          Transform.scale(
                            scale: 1.9,
                            child: Radio(
                                fillColor: WidgetStateProperty.all(
                                    AppColors.white.withOpacity(0.6)),
                                value: 2,
                                groupValue: controller.isForSale.value,
                                onChanged: (value) {
                                  controller.isForSale.value = value ?? 0;
                                }),
                          ),
                          EraText(
                              text: 'RENT',
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 15.0.sp,
                              fontWeight: FontWeight.w500),
                        ],
                      ),
                    ],
                  ),
                ),
                SearchWidget.build(() async {
                  var data;
                  if (controller.aiSearchController.text == "") {
                    data = await Database().searchListing(
                        location: controller.locationController.text,
                        price: controller.priceController,
                        type: controller.isForSale.value == 1
                            ? "selling"
                            : "rent",
                        property: controller.propertyController.text);
                  } else {
                    data = await AI(query: controller.aiSearchController.text)
                        .search();
                  }
                  Get.to(() => SearchResult(),
                      binding: SearchResultBinding(),
                      arguments: [data, "sample search"]);
                }),
              ],
            ),
          ),
        ),
        PropertiesWidgets(listingsModels: PropertiesModels.listings),
        TextListing.projectTitle(24.sp, FontWeight.w600, AppColors.blue),
        TextListing.projectSubtitle(12.sp, FontWeight.w500, AppColors.black),
        SizedBox(
          height: 20.h,
        ),
        TextListing(
            margin: EdgeInsets.symmetric(horizontal: 40.0),
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
        CarouselSliderWidget(),
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
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            text: 'FEATURED LISTING',
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blue),
        SizedBox(
          height: 10.h,
        ),
        //Feautured Listing properties
        ListingProperties(listingModels: RealEstateListing.listingsModels),

        TextListing(
            text: 'COMPANY NEWS',
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blue),
        SizedBox(
          height: 15.h,
        ),
        TextListing(
            text: 'Latest News and Events from ERA PH',
            fontSize: 12.h,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
            lineHeight: 0.1),

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
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _error() {
    return Container();
  }
}
 
  // bottomNavigationBar:
      //     CustomNavigationBar(navBarItems: navBarItems, controller: controller),
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
