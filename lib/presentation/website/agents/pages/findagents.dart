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
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      width: Get.width,
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
            fit: BoxFit.cover,
            width: Get.width,
          ),
          // SizedBox(
          //   height: Get.height - 330.h,
          //   width: Get.width,
          //   child: YoutubePlayer(
          //     controller: ytController.youtubePlayerController,
          //     bottomActions: const [
          //       CurrentPosition(),
          //       ProgressBar(isExpanded: true),
          //       RemainingDuration(),
          //       FullScreenButton(),
          //     ],
          //   ),
          // ),
          sb50(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidthAdmin * 5),
                  child: Column(
                    children: [
                      EraText(
                        text: 'Find an ERA Real Estate Agent',
                        fontSize: EraTheme.headerWeb,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kRedColor,
                        textAlign: TextAlign.center,
                      ),
                      BoxWidget.build(
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),

                            Obx(() {
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

                            SizedBox(height: 5.h),
                            GestureDetector(
                              onTap: () {
                                searchResultController.expanded.value =
                                    !searchResultController.expanded.value;
                                searchResultController.showFullSearch.value =
                                    !searchResultController
                                        .showFullSearch.value;
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10.0.h),
                                child: Obx(() => EraText(
                                      text:
                                          searchResultController.expanded.value
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
                                                .selectedLocation
                                                .value = value!,
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
                                                        horizontal: EraTheme
                                                            .paddingWidth),
                                                radius: 99,
                                                controller:
                                                    controller.agentName,
                                                hintText:
                                                    '  Find Agent by Name',
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.text,
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              fontSize: EraTheme.paragraphWeb + 6.sp,
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
        fontSize: EraTheme.paragraphWeb,
        fontWeight: FontWeight.w600,
        color: AppColors.hint,
        textAlign: TextAlign.start,
      ),
      // Obx(() => EraText(
      //       text: controller.resultText.value,
      //       fontSize: 22.sp,
      //       fontWeight: FontWeight.w600,
      //       color: AppColors.blue,
      //     )),
      Obx(
        () => AgentListViewWeb(agentInfo: controller.results.value),
      )
    ]);
  }
}
