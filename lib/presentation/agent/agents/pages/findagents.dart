import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/listings/agentInfo-widget.dart';
import 'package:eraphilippines/app/widgets/listings/agentlistview.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/agents_items.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FindAgents extends GetView<AgentsController> {
  const FindAgents({super.key});

  @override
  Widget build(BuildContext context) {
    SearchResultController searchResultController =
        Get.put(SearchResultController());
    ProjectsController projectsController = Get.put(ProjectsController());
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: EraTheme.paddingWidth, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EraText(
                text: 'Find an ERA Real Estate Agent',
                fontSize: EraTheme.header + 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.kRedColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              BoxWidget.build(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Obx(() {
                      if (!searchResultController.showFullSearch.value) {
                        return AppTextField(
                            onPressed: () {},
                            controller:
                                searchResultController.aiSearchController,
                            hint: 'Use AI Search',
                            svgIcon: AppEraAssets.ai3,
                            bgColor: AppColors.white,
                            isSuffix: true,
                            obscureText: false,
                            onSuffixTap: () {
                              controller.search();
                            },
                            suffixIcons: AppEraAssets.send);
                      }
                      return Container();
                    }),

                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        searchResultController.expanded.value =
                            !searchResultController.expanded.value;
                        searchResultController.showFullSearch.value =
                            !searchResultController.showFullSearch.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Obx(() => EraText(
                              text: searchResultController.expanded.value
                                  ? "Back to AI Search"
                                  : "Filtered Search",
                              fontSize: 15.sp,
                              textDecoration: TextDecoration.underline,
                            )),
                      ),
                    ),

                    //FILTERED SEARCH
                    Obx(() {
                      if (searchResultController.showFullSearch.value) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 10.h),
                                AddListings.dropDownAddlistings(
                                    color: AppColors.white,
                                    selectedItem:
                                        projectsController.selectedLocation,
                                    Types: projectsController.location,
                                    onChanged: (value) => projectsController
                                        .selectedLocation.value = value!,
                                    name: 'Location',
                                    hintText: 'Select Location'),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: EraTheme.paddingWidth),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      EraText(
                                          text: 'Name',
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.white),
                                      SizedBox(height: 5.h),
                                      TextformfieldWidget(
                                        controller: controller.agentName,
                                        hintText: 'Find Agent by Name',
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        hintstlye: TextStyle(
                                            color: AppColors.hint,
                                            fontSize:
                                                EraTheme.paragraph + 2.sp),
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                SearchWidget.build(() {
                                  controller.search();
                                }),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ],
                        );
                      }
                      return Container();
                    }),
                  ],
                ),
              ),
// AgentListView(agentsModels:AgentsItems.agentsModels),
              // EraText(
              //   text: 'HAVE AN AGENT ALREADY?',
              //   fontSize: EraTheme.subHeader,
              //   fontWeight: FontWeight.w600,
              //   color: AppColors.blue,
              // ),
              // SizedBox(height: 5.h),
              // TextformfieldWidget(
              //   controller: controller.agentName,
              //   hintText: 'Type Name Here',
              //   maxLines: 1,
              //   keyboardType: TextInputType.text,
              //   hintstlye: TextStyle(
              //       color: AppColors.hint, fontSize: EraTheme.paragraph + 2.sp),
              // ),
              // SizedBox(height: 10.h),
              // EraText(
              //   text: 'SEARCH VIA AGENT ID',
              //   fontSize: EraTheme.subHeader,
              //   fontWeight: FontWeight.w600,
              //   color: AppColors.blue,
              // ),
              // SizedBox(height: 5.h),
              // TextformfieldWidget(
              //   controller: controller.agentId,
              //   hintText: 'Enter Agent ID',
              //   maxLines: 1,
              //   //agent id is a nuumber or not
              //   keyboardType: TextInputType.text,
              //   hintstlye: TextStyle(
              //       color: AppColors.hint, fontSize: EraTheme.paragraph + 2.sp),
              // ),
              // SizedBox(height: 10.h),
              // EraText(
              //   text: 'LOOKING FOR ONE?',
              //   fontSize: EraTheme.subHeader,
              //   fontWeight: FontWeight.w600,
              //   color: AppColors.blue,
              // ),
              // SizedBox(height: 5.h),
              // TextformfieldWidget(
              //   controller: controller.agentLocation,
              //   hintText: 'Type Your Location',
              //   maxLines: 1,
              //   keyboardType: TextInputType.text,
              //   hintstlye: TextStyle(
              //       color: AppColors.hint, fontSize: EraTheme.paragraph + 2.sp),
              // ),
              // SizedBox(height: 20.h),
              // Button(
              //   text: 'SEARCH',
              //   fontSize: 25.sp,
              //   onTap: () {
              //     controller.search();
              //   },
              //   bgColor: AppColors.kRedColor,
              //   height: 48.h,
              //   width: 500.w,
              //   fontWeight: FontWeight.w600,
              //   margin: EdgeInsets.symmetric(horizontal: 0),
              // ),

              //controller.agentCount.toString()} to count the number of agents
              SizedBox(height: 20.h),
              EraText(
                text: "120 ERA Agents",
                fontSize: EraTheme.header + 5.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
                textAlign: TextAlign.center,
              ),
              EraText(
                text:
                    "Your Go-To Professionals for Seeamless Property Transactions",
                fontSize: EraTheme.small,
                fontWeight: FontWeight.w600,
                color: AppColors.hint,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 25.h),
              Obx(() => switch (controller.agentState.value) {
                    AgentsState.loading => _loading(),
                    AgentsState.loaded => _loaded(),
                    AgentsState.error => _error(),
                    AgentsState.empty => _empty(),
                    AgentsState.blank => _blank(),
                    AgentsState.noFeaturedAgent => _noFeaturedAgent(),
                  })
            ],
          ),
        ),
      ),
    );
  }

  _blank() {
    return Container();
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  _error() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "Something went Wrong!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _empty() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "No User Found!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _noFeaturedAgent() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "No Agent was Found!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _loaded() {
    return Column(children: [
      Obx(() => EraText(
            text: controller.resultText.value,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blue,
          )),
      Obx(
        () => AgentListView(agentsModels: controller.results.value),
      )
    ]);
  }
}
