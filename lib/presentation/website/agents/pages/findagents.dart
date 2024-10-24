import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/listings/agentlistview.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:eraphilippines/presentation/website/agents/controllers/agents_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../app/constants/screens.dart';
import '../../../../app/services/ai_search.dart';

class FindAgentsWeb extends GetView<AgentsWebController> {
  const FindAgentsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AgentsWebController());
    SearchResultController searchResultController =
        Get.put(SearchResultController());
    ProjectsController projectsController = Get.put(ProjectsController());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: Get.width,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
              fit: BoxFit.cover,
              width: Get.width,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidth, vertical: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Find an ERA Real Estate Agent',
                    fontSize: EraTheme.header,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
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
                                onSuffixTap: () async {
                                  await controller.aiSearch(
                                      searchResultController
                                          .aiSearchController.text);
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
                                    AddListings.dropDownAddlistings1(
                                        color: AppColors.white,
                                        selectedItem:
                                            controller.selectedLocation,
                                        Types: projectsController.location,
                                        onChanged: (value) => controller
                                            .selectedLocation.value = value!,
                                        name: 'Location',
                                        hintText: 'Select Location'),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        EraText(
                                            text: 'Name',
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white),
                                        SizedBox(height: 5.h),
                                        Container(
                                          height: 50.h,
                                          child: TextformfieldWidget(
                                            style: TextStyle(
                                              fontSize: 20.sp,
                                              color: AppColors.hint,
                                              height: 0.0,
                                              fontFamily: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w400)
                                                  .fontFamily,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal:
                                                        EraTheme.paddingWidth),
                                            radius: 99,
                                            controller: controller.agentName,
                                            hintText: '  Find Agent by Name',
                                            maxLines: 1,
                                            keyboardType: TextInputType.text,
                                            hintstlye: TextStyle(
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 20.sp,
                                              color: AppColors.hint,
                                              height: 0.0,
                                              fontFamily: GoogleFonts.lato(
                                                      fontWeight:
                                                          FontWeight.w400)
                                                  .fontFamily,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    SearchWidget.build(() {
                                      controller.search();
                                    }),
                                    SizedBox(height: 20.h),
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
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('status', isEqualTo: 'approved')
                        .count()
                        .get(),
                    builder: (data, snapshot) {
                      if (snapshot.hasData) {
                        return EraText(
                          text: "${snapshot.data!.count} ERA Agents",
                          fontSize: EraTheme.small + 6.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.kRedColor,
                          textAlign: TextAlign.center,
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  EraText(
                    text:
                        "Your Go-To Professionals for Seamless Property Transactions",
                    fontSize: EraTheme.small,
                    fontWeight: FontWeight.w600,
                    color: AppColors.hint,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 20.h),
                  Obx(() => switch (controller.agentState.value) {
                        AgentsStateWeb.loading => _loading(),
                        AgentsStateWeb.loaded => _loaded(),
                        AgentsStateWeb.error => _error(),
                        AgentsStateWeb.empty => _empty(),
                        AgentsStateWeb.blank => _blank(),
                        AgentsStateWeb.noFeaturedAgent => _noFeaturedAgent(),
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _blank() {
    return Container();
  }

  _loading() {
    return Screens.loading();
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
            height: 20.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "No User Found!",
            color: Colors.black,
          ),
          SizedBox(
            height: 20.h,
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
            text: "",
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
