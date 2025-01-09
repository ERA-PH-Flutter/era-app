// ignore: unused_import
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/listings/agents_items.dart';

class FindAgents extends GetView<AgentsController> {
  const FindAgents({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchResultController searchResultController =
        Get.find<SearchResultController>();
    ProjectsController projectsController = Get.find<ProjectsController>();
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller.scrollController,
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl:
                  'https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/heroimages%2Fimage.png?alt=media&token=1de06091-9a20-4fb2-a6bb-fa2cfcf8daea',
              fit: BoxFit.cover,
              width: Get.width,
            ),
            // YoutubePlayer(
            //   controller: controller.youtubePlayerController,
            //   bottomActions: const [
            //     CurrentPosition(),
            //     ProgressBar(isExpanded: true),
            //     RemainingDuration(),
            //   ],
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidth, vertical: 50.h),
                  child: Column(
                    children: [
                      EraText(
                        text: 'Find an ERA Real Estate Agent',
                        fontSize: EraTheme.header,
                        fontWeight: FontWeight.w600,
                        color: AppColors.kRedColor,
                        textAlign: TextAlign.center,
                      ),
                      BoxWidget.build(
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            if (!searchResultController.showFullSearch.value)
                              SizedBox(
                                height: 60.h,
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: AppTextField(
                                        onPressed: () {},
                                        onChange: (value) {
                                          //  controller.aiObs.value = value;
                                        },
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
                                        suffixIcons: AppEraAssets.send)),
                              ),

                            SizedBox(height: 10.h),
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
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
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
                                              onChanged: (value) {
                                                controller.agentNameObs.value =
                                                    value;
                                              },
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
                                                                  FontWeight
                                                                      .w400)
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
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                  borderSide: BorderSide(
                                                    color: AppColors.primary,
                                                    width: 1,
                                                  ),
                                                ),
                                              ),
                                              controller: controller.agentName,
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                        ],
                                      ),
                                      SizedBox(height: 20.h),

                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 4,
                                              child: Obx(() {
                                                if (Get.find<AgentsController>()
                                                        .agentState
                                                        .value ==
                                                    AgentsState.loading) {
                                                  return Screens.loadingTwo();
                                                }
                                                return SearchWidget(onTap: () {
                                                  controller.search();
                                                });
                                              })),
                                          Obx(
                                            () {
                                              if (controller
                                                          .selectedLocation.value !=
                                                      null ||
                                                  controller
                                                          .agentNameObs.value !=
                                                      "" ||
                                                  controller.aiObs.value !=
                                                      "") {
                                                return Expanded(
                                                    flex: 1,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .selectedLocation
                                                            .value = null;
                                                        controller.agentName
                                                            .clear();
                                                        searchResultController
                                                            .aiSearchController
                                                            .clear();
                                                      },
                                                      icon: Icon(Icons.clear),
                                                      color: AppColors.white,
                                                    ));
                                              }
                                              return Container();
                                            },
                                          )
                                        ],
                                      ),
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
                      AgentsState.loading => _loading(),
                      AgentsState.loaded => _loaded(),
                      AgentsState.error => _error(),
                      AgentsState.empty => _empty(),
                      AgentsState.blank => _blank(),
                      AgentsState.noFeaturedAgent => _noFeaturedAgent(),
                    })
              ],
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidth, vertical: 50.h),
                ),
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
                              controller: searchResultController
                                  .aiSearchAgentsController,
                              hint: 'Use AI Search',
                              svgIcon: AppEraAssets.ai3,
                              bgColor: AppColors.white,
                              isSuffix: true,
                              obscureText: false,
                              onSuffixTap: () async {
                                await controller.aiSearch(searchResultController
                                    .aiSearchAgentsController.text);
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
                                      selectedItem: controller.selectedLocation,
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
                                      SizedBox(
                                        height: 50.h,
                                        child: TextformfieldWidget(
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                            color: AppColors.hint,
                                            height: 0.0,
                                            fontFamily: GoogleFonts.lato(
                                                    fontWeight: FontWeight.w400)
                                                .fontFamily,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
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
                                                    fontWeight: FontWeight.w400)
                                                .fontFamily,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  SearchWidget(onTap: () {
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

                //controller.agentCount.toString()} to count the number of agents
                SizedBox(height: 20.h),
                /*
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
                  */
<<<<<<< HEAD
                  EraText(
                    text: "Featured Agents",
                    fontSize: EraTheme.small + 6.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kRedColor,
                    textAlign: TextAlign.center,
                  ),
                  EraText(
                    text:
                        "Your Go-To Professionals for Seamless Property Transactions",
                    fontSize: EraTheme.small,
                    fontWeight: FontWeight.w600,
                    color: AppColors.hint,
                    textAlign: TextAlign.start,
                  ),
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
=======
                EraText(
                  text: "Featured Agents",
                  fontSize: EraTheme.small + 6.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kRedColor,
                  textAlign: TextAlign.center,
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
                      AgentsState.loading => _loading(),
                      AgentsState.loaded => _loaded(),
                      AgentsState.error => _error(),
                      AgentsState.empty => _empty(),
                      AgentsState.blank => _blank(),
                      AgentsState.noFeaturedAgent => _noFeaturedAgent(),
                    })
              ],
>>>>>>> f3377da (ui changes & fix errors)
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
        () {
          return LoadMore(
            length: (controller.results.length / controller.pageSize).ceil() > 0
                ? (controller.results.length / controller.pageSize).ceil()
                : 1,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.results.length,
              itemBuilder: (context, index) {
                if (index >= controller.count.value - controller.pageSize &&
                    index < controller.count.value) {
                  return AgentsItems(
                    agentInfo: controller.results[index],
                    onTap: () {},
                  );
                }
                return Container();
              },
            ),
          );
        },
      )
    ]);
  }

  LoadMore({
    child,
    length,
  }) {
    return Column(
      children: [
        child,
        if (length > 0 && controller.pageSize > 0)
          NumberPagination(
            fontSize: 18.sp,
            buttonRadius: 10.r,
            controlButtonSize: Size(30, 30),
            numberButtonSize: Size(35, 35),
            sectionSpacing: 1.w,
            betweenNumberButtonSpacing: 1,
            totalPages: length,
            currentPage: (controller.count.value / controller.pageSize).ceil(),
            visiblePagesCount: length < 4 ? length : 4,
            onPageChanged: (page) {
              controller.count.value =
                  controller.pageSize * (page == 0 ? 1 : page);
              controller.scrollController.jumpTo(0);
            },
          ),
        SizedBox(height: 50.h),
      ],
    );
  }
}
