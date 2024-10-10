import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/project_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/constants/screens.dart';

import '../../../../app/widgets/project_views.dart';

import '../../../admin/properties/controllers/project_list_controller.dart';
import '../../../admin/properties/controllers/project_view_binding.dart';
//todo add text

class ProjectsList extends GetView<ProjectsListController> {
  const ProjectsList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.projectsListState.value) {
                ProjectsListState.loading => _loading(),
                ProjectsListState.loaded => _loaded(),
                ProjectsListState.error => _error(),
                ProjectsListState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _loaded() {
    // final SearchResultController searchController =
    //     Get.put(SearchResultController());
    return SingleChildScrollView(
      child: Column(
        children: [
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          //   child: EraText(
          //     text: 'Find Cutting-Edge Real Estate Projects',
          //     fontSize: 30.sp,
          //     color: AppColors.kRedColor,
          //     fontWeight: FontWeight.bold,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
          // sb10(),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          //   child: BoxWidget.build(
          //     child: Column(
          //       children: [
          //         SizedBox(height: 10.h),
          //         Obx(() {
          //           if (!searchController.showFullSearch.value) {
          //             return Padding(
          //               padding: EdgeInsets.symmetric(horizontal: 10.w),
          //               child: AppTextField(
          //                   onPressed: () {},
          //                   controller: searchController.aiSearchController,
          //                   hint: 'Use AI Search',
          //                   svgIcon: AppEraAssets.ai3,
          //                   bgColor: AppColors.white,
          //                   isSuffix: true,
          //                   obscureText: false,
          //                   suffixIcons: AppEraAssets.send),
          //             );
          //           }
          //           return Container();
          //         }),

          //         SizedBox(height: 5.h),
          //         GestureDetector(
          //           onTap: () {
          //             searchController.expanded.value =
          //                 !searchController.expanded.value;
          //             searchController.showFullSearch.value =
          //                 !searchController.showFullSearch.value;
          //           },
          //           child: Padding(
          //             padding: EdgeInsets.all(10.0.h),
          //             child: Obx(() => EraText(
          //                   text: searchController.expanded.value
          //                       ? "Back to AI Search"
          //                       : "Filtered Search",
          //                   fontSize: 15.sp,
          //                   textDecoration: TextDecoration.underline,
          //                 )),
          //           ),
          //         ),

          //         //FILTERED SEARCH
          //         Obx(() {
          //           if (searchController.showFullSearch.value) {
          //             return Column(
          //               children: [
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(horizontal: 10.w),
          //                   child: Column(
          //                     children: [
          //                       //different controller for each dropdown
          //                       //Location
          //                       AddListings.dropDownAddlistings1(
          //                           color: AppColors.white,
          //                           selectedItem: controller.selectedLocation,
          //                           Types: controller.location,
          //                           onChanged: (value) => controller
          //                               .selectedLocation.value = value!,
          //                           name: 'Location',
          //                           hintText: 'Select Location'),

          //                       AddListings.dropDownAddlistings1(
          //                           color: AppColors.white,
          //                           selectedItem:
          //                               controller.selectedPropertyType,
          //                           Types: controller.propertType,
          //                           onChanged: (value) => controller
          //                               .selectedPropertyType.value = value!,
          //                           name: 'Property Type',
          //                           hintText: 'Select Property Type'),
          //                       AddListings.dropDownAddlistings1(
          //                           color: AppColors.white,
          //                           selectedItem:
          //                               controller.selectedDeveloper,
          //                           Types: controller.developerType,
          //                           onChanged: (value) => controller
          //                               .selectedDeveloper.value = value!,
          //                           name: 'Developer',
          //                           hintText: 'Select Developer'),

          //                       SearchWidget.build(() async {
          //                         var data;
          //                         var searchQuery = "";
          //                         if (searchController
          //                                 .aiSearchController.text ==
          //                             "") {
          //                           data = await Database().searchListing(
          //                               location: searchController
          //                                   .locationController.text,
          //                               property: searchController
          //                                   .propertyController.text);
          //                           if (searchController
          //                                   .locationController.text !=
          //                               "") {
          //                             searchQuery +=
          //                                 "Location: ${searchController.locationController.text}";
          //                           } else if (searchController
          //                                   .propertyController.text !=
          //                               "") {
          //                             searchQuery +=
          //                                 "Property Type: ${searchController.locationController.text}";
          //                           } else if (searchController
          //                                   .priceController.text !=
          //                               "") {
          //                             searchQuery +=
          //                                 "With price less than: ${searchController.priceController.text}";
          //                           }
          //                         } else {
          //                           data = await AI(
          //                                   query: searchController
          //                                       .aiSearchController.text)
          //                               .search();
          //                           searchQuery = searchController
          //                               .aiSearchController.text;
          //                         }
          //                         //  selectedIndex.value = 2;
          //                         searchController.searchResultState.value =
          //                             SearchResultState.loading;
          //                         searchController.searchQuery.value =
          //                             searchQuery;
          //                         searchController.expanded.value = false;
          //                         searchController.showFullSearch.value =
          //                             false;
          //                         searchController.loadData(data);
          //                       }),
          //                       SizedBox(height: 10.h),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             );
          //           }
          //           return Container();
          //         }),
          //       ],
          //     ),
          //   ),
          // ),

          Builder(builder: (context) {
            List<Widget> projects = [];
            print({'controller.projects.length': controller.projects.length});
            for (int i = 0; i < controller.projects.length; i++) {
              projects.add(GestureDetector(
                onTap: () {
                  Get.to(ProjectView(),
                      binding: ProjectViewBinding(),
                      arguments: controller.projects[i]);
                },
                child: Wrap(children: [
                  Column(
                    children: ProjectViews(project: controller.projects[i])
                        .buildPreview(),
                  ),
                ]),
              ));
            }
            return Column(children: projects);
          }),
          // ListView.builder(
          //     shrinkWrap: true,
          //     itemCount: controller.projects.length,
          //     itemBuilder: (context, index) {
          //       return GestureDetector(
          //         onTap: () {
          //           Get.to(ProjectView(),
          //               binding: ProjectViewBinding(),
          //               arguments: controller.projects[index]);
          //         },
          //         child: Container(
          //           child: Column(
          //             children:
          //                 ProjectViews(project: controller.projects[index])
          //                     .buildPreview(),
          //           ),
          //         ),
          //       );
          //     }),
        ],
      ),
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
}
