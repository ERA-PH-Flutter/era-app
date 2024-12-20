import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/website/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/website/projects/controllers/projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../app/constants/screens.dart';
import '../../../../app/widgets/listings_web/agentlistview.dart';
import '../../landingpage/controller/homs_controller.dart';
import '../controllers/agentYT_controller.dart';

class FindAgentsWeb extends GetView<AgentsWebController> {
  const FindAgentsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    agentYtController ytController = Get.put(agentYtController());
    Get.put(AgentsWebController());
    SearchResultController searchResultController =
        Get.put(SearchResultController());
    ProjectsWebController projectsController = Get.put(ProjectsWebController());
    return Container(
      width: Get.width,
      child: Column(
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
                fit: BoxFit.cover,
                width: Get.width,
                height: Get.height - 150.h,
              ),
              Container(
                width: Get.width,
                height: Get.height - 150.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 50,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                      text: 'Find Your Trusted Agent',
                      fontSize: EraTheme.h1,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 10.h),
                    EraText(
                      text: 'Connect with professionals ready to assist you.',
                      fontSize: EraTheme.h5,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ],
          ),
          sb50(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: EraTheme.paddingWidthAdmin * 8),
                child: Column(
                  children: [
                    EraText(
                      text: 'Find an ERA Real Estate Agent',
                      fontSize: EraTheme.h1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kRedColor,
                      textAlign: TextAlign.center,
                    ),
                    BoxWidget.build(
                      child: Column(
                        children: [
                          SizedBox(height: 15.h),

                          SizedBox(
                            height: 60.h,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Obx(() {
                                if (!searchResultController
                                    .showFullSearch.value) {
                                  return AppTextField(
                                      onPressed: () {},
                                      controller: searchResultController
                                          .aiSearchController,
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
                            ),
                          ),

                          SizedBox(height: 10.h),
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
                                    fontSize: EraTheme.bodyText,
                                    textDecoration: TextDecoration.underline,
                                  )),
                            ),
                          ),

                          //FILTERED SEARCH
                          Obx(() {
                            if (searchResultController.showFullSearch.value) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                child: Column(
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
                                            text: 'Find Agent',
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.white),
                                        SizedBox(height: 5.h),
                                        Container(
                                          height: 60.h,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColors.white,
                                              hintText: ' Find Agent by Name',
                                              hintStyle: TextStyle(
                                                textBaseline:
                                                    TextBaseline.alphabetic,
                                                fontSize: 20.sp,
                                                color: AppColors.hint,
                                                fontFamily:
                                                    GoogleFonts.montserrat(
                                                            fontWeight:
                                                                FontWeight.w400)
                                                        .fontFamily,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(99),
                                                borderSide: BorderSide(
                                                  color: AppColors.hint,
                                                  width: 1,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(99),
                                                borderSide: BorderSide(
                                                  color: AppColors.primary,
                                                  width: 1,
                                                ),
                                              ),
                                            ),

                                            // contentPadding:
                                            //     EdgeInsets.symmetric(
                                            //         horizontal: EraTheme
                                            //             .paddingWidth),

                                            controller: controller.agentName,
                                          ),
                                        ),
                                        SizedBox(height: 20.h),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    SearchWidget(onTap: () {
                                      controller.search();
                                    }),
                                    // SearchWidget.build(),
                                    SizedBox(height: 20.h),
                                  ],
                                ),
                              );
                            }
                            return Container();
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              sb50(),
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
        ],
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sb40(),

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
                fontSize: EraTheme.h1,
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
          text: "Your Go-To Professionals for Seamless Property Transactions",
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.w600,
          color: AppColors.hint,
          textAlign: TextAlign.start,
        ),
        // Obx(() => EraText(

        Obx(
          () => AgentListViewWeb(agentInfo: controller.results.value),
        )
      ]),
    );
  }
}
