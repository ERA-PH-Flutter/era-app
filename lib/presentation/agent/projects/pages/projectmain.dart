import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/carousel_models.dart';
import 'package:eraphilippines/app/models/projects_models.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/carousel/carousel_slider.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/project_divider.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/haraya.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/assets.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/app_textfield.dart';
import '../controllers/projects_controller.dart';

class ProjectMain extends GetView<ProjectsController> {
  const ProjectMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            Column(
              children: ProjectsModels2.projects1.map((project) {
                return projectMainContainer(project);
              }).toList(),
            ),
          ],
        )),
      ),
    );
  }

  Widget projectMainContainer(ProjectsModels2 project) {
    final SearchResultController searchController =
        Get.put(SearchResultController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //AppDivider(),
        SizedBox(height: 20.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: EraText(
            text: 'Find Cutting-Edge Real Estate Projects',
            fontSize: 30.sp,
            color: AppColors.kRedColor,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: BoxWidget.build(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Obx(() {
                  if (!searchController.showFullSearch.value) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: AppTextField(
                          onPressed: () {},
                          controller: searchController.aiSearchController,
                          hint: 'Use AI Search',
                          svgIcon: AppEraAssets.ai3,
                          bgColor: AppColors.white,
                          isSuffix: true,
                          obscureText: false,
                          suffixIcons: AppEraAssets.send),
                    );
                  }
                  return Container();
                }),

                SizedBox(height: 5.h),
                GestureDetector(
                  onTap: () {
                    searchController.expanded.value =
                        !searchController.expanded.value;
                    searchController.showFullSearch.value =
                        !searchController.showFullSearch.value;
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10.0.h),
                    child: Obx(() => EraText(
                          text: searchController.expanded.value
                              ? "Back to AI Search"
                              : "Filtered Search",
                          fontSize: 15.sp,
                          textDecoration: TextDecoration.underline,
                        )),
                  ),
                ),

                //FILTERED SEARCH
                Obx(() {
                  if (searchController.showFullSearch.value) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            children: [
                              //different controller for each dropdown
                              //Location
                              AddListings.dropDownAddlistings1(
                                  color: AppColors.white,
                                  selectedItem: controller.selectedLocation,
                                  Types: controller.location,
                                  onChanged: (value) => controller
                                      .selectedLocation.value = value!,
                                  name: 'Location',
                                  hintText: 'Select Location'),

                              AddListings.dropDownAddlistings1(
                                  color: AppColors.white,
                                  selectedItem: controller.selectedPropertyType,
                                  Types: controller.propertType,
                                  onChanged: (value) => controller
                                      .selectedPropertyType.value = value!,
                                  name: 'Property Type',
                                  hintText: 'Select Property Type'),
                              AddListings.dropDownAddlistings1(
                                  color: AppColors.white,
                                  selectedItem: controller.selectedDeveloper,
                                  Types: controller.developerType,
                                  onChanged: (value) => controller
                                      .selectedDeveloper.value = value!,
                                  name: 'Developer',
                                  hintText: 'Select Developer'),

                              SearchWidget.build(() async {
                                var data;
                                var searchQuery = "";
                                if (searchController.aiSearchController.text ==
                                    "") {
                                  data = await Database().searchListing(
                                      location: searchController
                                          .locationController.text,
                                      property: searchController
                                          .propertyController.text);
                                  if (searchController
                                          .locationController.text !=
                                      "") {
                                    searchQuery +=
                                        "Location: ${searchController.locationController.text}";
                                  } else if (searchController
                                          .propertyController.text !=
                                      "") {
                                    searchQuery +=
                                        "Property Type: ${searchController.locationController.text}";
                                  } else if (searchController
                                          .priceController.text !=
                                      "") {
                                    searchQuery +=
                                        "With price less than: ${searchController.priceController.text}";
                                  }
                                } else {
                                  searchQuery =
                                      searchController.aiSearchController.text;
                                }
                                selectedIndex.value = 2;
                                searchController.searchResultState.value =
                                    SearchResultState.loading;
                                searchController.searchQuery.value =
                                    searchQuery;
                                searchController.expanded.value = false;
                                searchController.showFullSearch.value = false;
                                searchController.loadData(data);
                              }),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
        SizedBox(height: 40.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: featuredProject(),
        ),
        sb20(),
        ProjectDivider(textImage: ProjectTextImageModels.textImageModels),
        SizedBox(height: 20.h),
        CarouselSliderWidget(images: CarouselModels.carouselModels),
        SizedBox(height: 20.h),
        projectContent1(project),
        sb60(),
        // //buttons
        Button(
          text: 'VIEW MORE',
          onTap: () {
            Get.toNamed("/haraya");
          },
          bgColor: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        sb90(),
        ProjectDivider(
            textImage: ProjectTextImageModels.textImageModels2,
            height: 150.h,
            width: 430.w,
            text: ' '),
        //temporary carousel
        sb20(),

        CarouselSliderWidget(
            images: CarouselModels.layaCarouselImages,
            color: AppColors.carouselBgColor),
        SizedBox(height: 20.h),
        projectContent2(project),
        sb60(),
        Button(
          text: 'VIEW MORE',
          onTap: () {
            Get.toNamed("/laya");
          },
          bgColor: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        sb90(),

        ProjectDivider(
          textImage: ProjectTextImageModels.textImageModels3,
          height: 200.h,
          width: Get.width,
        ),
        sb20(),

        CarouselSliderWidget(
            images: CarouselModels.aureliaCarouselImages,
            color: AppColors.carouselBgColor),
        SizedBox(height: 30.h),
        projectContent3(project),
        sb60(),

        Button(
          text: 'VIEW MORE',
          onTap: () {
            Get.toNamed('/aurelia');
          },
          bgColor: AppColors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        sb60(),
      ],
    );
  }

  Widget projectContent1(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HarayaProject.paddingTextTitle(
            project.text1,
            EraTheme.header - 3.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            project.text2,
            EraTheme.paragraph,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }

  Widget projectContent2(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 15.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HarayaProject.paddingText(
            project.text3,
            EraTheme.header - 3.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            project.text4,
            EraTheme.paragraph,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }

  Widget projectContent3(ProjectsModels2 project) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.0.h),
      child: Column(
        children: [
          HarayaProject.paddingTextTitle(
            project.text5,
            EraTheme.header - 3.sp,
            FontWeight.bold,
            AppColors.kRedColor,
            0,
          ),
          SizedBox(height: 20.h),
          HarayaProject.paddingText(
            project.text6,
            EraTheme.paragraph,
            FontWeight.w500,
            AppColors.black,
            0,
          ),
        ],
      ),
    );
  }

  static Widget featuredProject() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
            text: 'Featured Projects',
            fontSize: EraTheme.header + 5.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.kRedColor),
        EraText(
            text:
                'Dive into the future of real estate with our spotlight on upcoming innovative projects.',
            fontSize: EraTheme.subHeader - 2.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.hint),
      ],
    );
  }
}
