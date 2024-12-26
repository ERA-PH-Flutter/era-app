import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listings/agentInfo-widget.dart';
import 'package:eraphilippines/presentation/website/agents/bindings/agent_dashboard_binding.dart';
import 'package:eraphilippines/presentation/website/agents/controllers/agent_dashboard_controller.dart';
import 'package:eraphilippines/presentation/website/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/website/agents/pages/agent_listings.dart';
import 'package:eraphilippines/presentation/website/listings/controllers/listings_web_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/web/companynews_page_web.dart';
import '../../../global.dart';
import '../../landingpage/controller/homs_controller.dart';
import '../controllers/agent_myListingWeb_controller.dart';

class AgentDashBoardWeb extends GetView<AgentDashboardWebController> {
  AgentDashBoardWeb({
    super.key,
  });
  final AgentsWebController agentController = Get.put(AgentsWebController());

  @override
  Widget build(BuildContext context) {
    Get.put(AgentDashboardWebController());

    return WillPopScope(
        onWillPop: () async {
          // selectedIndex.value = 0;
          // pageViewController = PageController(initialPage: 0);
          // currentRoute = '/home';
          // Get.offAll(BaseScaffold(),binding: HomeBinding());
          Get.back();
          return Future.value(false);
        },
        child: SingleChildScrollView(
          //   controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          child: Obx(() {
            if (controller.agentDashboardWebState.value ==
                AgentDashboardWebState.loading) {
              return _loading();
            } else {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: EraTheme.paddingWidthAdmin * 3,
                        vertical: 80.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EraText(
                          text: user != null
                              ? '${DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'} ${user!.firstname!.capitalize}'
                              : DateTime.now().hour < 12
                                  ? 'Good Morning,'
                                  : DateTime.now().hour < 18
                                      ? 'Good Afternoon, Hannah'
                                      : 'Good Evening, Hannah',
                          fontSize: EraTheme.headerWeb + 4.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                        ),
                        EraText(
                          text: 'Welcome to your Dashboard!',
                          fontSize: EraTheme.subHeaderWeb,
                          color: AppColors.kRedColor.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: 20.h),
                        Divider(color: AppColors.grey, thickness: 0.5),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: AgentInfoWidget.agentInformationWeb(
                            imageProvider: user!.image != null
                                ? user!.image!
                                : AppStrings.noUserImageWhite,
                            firstName: '${user!.firstname}',
                            lastName: '${user!.lastname}',
                            whatsApp: '${user!.whatsApp}',
                            email: '${user!.email}',
                            role: '${user!.role}',
                          ),
                        ),
                        SizedBox(height: 25.h),
                        SizedBox(height: 25.h),
                        myListings(),
                        SizedBox(height: 25.h),
                        favorites(),
                        SizedBox(height: 25.h),
                        archivedListing(),
                        SizedBox(height: 25.h),
                        soldProperties(),
                        SizedBox(height: 25.h),
                        myTrainings(),
                        SizedBox(height: 25.h),
                        findAgentsandOffices(),
                        SizedBox(height: 25.h),
                        sb25(),
                      ],
                    ),
                  ),
                  latestNews(),
                  SizedBox(height: 25.h),
                ],
              );
            }
          }),
        ));
  }

  _loading() {
    return Screens.loading();
  }

  Widget soldProperties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'SOLD PROPERTIES',
          color: AppColors.kRedColor,
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            // SizedBox(
            //   height: 220.h,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount:
            //         controller.soldp.length > 5 ? 5 : controller.soldp.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           // Get.toNamed('/propertyInfo',
            //           //     arguments: controller.favorites[index]);
            //           listingArgument = controller.soldp[index];

            //           selectedIndex.value = 10;
            //           Get.find<HomsController>().onNavbarItemSelected(10);
            //         },
            //         child: Container(
            //             width: 200.w,
            //             height: 220.h,
            //             decoration: BoxDecoration(boxShadow: const [
            //               BoxShadow(
            //                   offset: Offset(0, 0),
            //                   blurRadius: 1,
            //                   spreadRadius: 0.5,
            //                   color: Colors.black38)
            //             ], borderRadius: BorderRadius.circular(10.r)),
            //             margin: EdgeInsets.symmetric(horizontal: 5.w),
            //             child: Stack(
            //               children: [
            //                 Positioned.fill(
            //                   child: CloudStorage().imageLoaderProvider(
            //                       reference:
            //                           controller.soldp[index].photos.first,
            //                       height: 100.w,
            //                       width: 100.w,
            //                       borderRadius: BorderRadius.circular(10.r)),
            //                 ),
            //                 Positioned(
            //                   bottom: 0,
            //                   child: Container(
            //                     alignment: Alignment.center,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.only(
            //                             bottomLeft: Radius.circular(10.r),
            //                             bottomRight: Radius.circular(10.r))),
            //                     width: 200.w,
            //                     height: 40.h,
            //                     child: EraText(
            //                       textAlign: TextAlign.center,
            //                       text: controller.soldp[index].name,
            //                       color: Colors.black,
            //                       fontSize: 20.sp,
            //                       textOverflow: TextOverflow.ellipsis,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             )),
            //       );
            //     },
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                // Get.toNamed(
                //   '/soldP',
                //   arguments: user!.id,
                // );

                // selectedIndex.value = 18;
                // Get.find<HomsController>().onNavbarItemSelected(18);
                Get.toNamed('/sold-properties');
              },
              child: Image.asset(
                AppEraAssets.sold,
                width: 200.w,
                height: 220.h,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget archivedListing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ARCHIVED LISTINGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            //      SizedBox(
            //   height: 220.h,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: controller.favorites.length > 5
            //         ? 5
            //         : controller.favorites.length,
            //     shrinkWrap: true,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //         onTap: () {
            //           // Get.toNamed('/propertyInfo',
            //           //     arguments: controller.favorites[index]);
            //           listingArgument = controller.favorites[index];

            //           selectedIndex.value = 10;
            //           Get.find<HomsController>().onNavbarItemSelected(10);
            //         },
            //         child: Container(
            //             width: 200.w,
            //             height: 220.h,
            //             decoration: BoxDecoration(boxShadow: const [
            //               BoxShadow(
            //                   offset: Offset(0, 0),
            //                   blurRadius: 1,
            //                   spreadRadius: 0.5,
            //                   color: Colors.black38)
            //             ], borderRadius: BorderRadius.circular(10.r)),
            //             margin: EdgeInsets.symmetric(horizontal: 5.w),
            //             child: Stack(
            //               children: [
            //                 Positioned.fill(
            //                   child: CloudStorage().imageLoaderProvider(
            //                       reference: controller
            //                           .favorites[index].photos.first,
            //                       height: 100.w,
            //                       width: 100.w,
            //                       borderRadius: BorderRadius.circular(10.r)),
            //                 ),
            //                 Positioned(
            //                   bottom: 0,
            //                   child: Container(
            //                     alignment: Alignment.center,
            //                     decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.only(
            //                             bottomLeft: Radius.circular(10.r),
            //                             bottomRight: Radius.circular(10.r))),
            //                     width: 200.w,
            //                     height: 40.h,
            //                     child: EraText(
            //                       textAlign: TextAlign.center,
            //                       text: controller.favorites[index].name,
            //                       color: Colors.black,
            //                       fontSize: 20.sp,
            //                       textOverflow: TextOverflow.ellipsis,
            //                       fontWeight: FontWeight.w400,
            //                     ),
            //                   ),
            //                 )
            //               ],
            //             )),
            //       );
            //     },
            //   ),
            // ),

            GestureDetector(
              onTap: () {
                // listingArgument = controller.listings;
                // selectedIndex.value = 17;
                // Get.find<HomsController>().onNavbarItemSelected(17);
                //        Get.toNamed("/archivedWeb", arguments: controller.listings);
                Get.toNamed('/archives');
              },
              child: Image.asset(
                AppEraAssets.archived,
                width: 200.w,
                height: 220.h,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget favorites() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'FAVORITES',
          color: AppColors.kRedColor,
          fontSize: EraTheme.h2,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.favorites.length > 5
                      ? 5
                      : controller.favorites.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Get.toNamed('/propertyInfo',
                        //     arguments: controller.favorites[index]);
                        Get.delete<ListingsWebController>();
                        Get.toNamed(
                            '/view-listing/${controller.favorites[index].id}');
                      },
                      child: Container(
                          width: 200.w,
                          height: 220.h,
                          decoration: BoxDecoration(boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 0.5,
                                color: Colors.black38)
                          ], borderRadius: BorderRadius.circular(10.r)),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CloudStorage().imageLoaderProvider(
                                    reference: controller
                                        .favorites[index].photos.first,
                                    height: 100.w,
                                    width: 100.w,
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r))),
                                  width: 200.w,
                                  height: 40.h,
                                  child: EraText(
                                    textAlign: TextAlign.center,
                                    text: controller.favorites[index].name,
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  //     Get.toNamed("/favWeb");
                  // selectedIndex.value = 14;
                  // Get.find<HomsController>().onNavbarItemSelected(14);
                  Get.toNamed('/my-favorites');
                },
                child: Image.asset(
                  AppEraAssets.fav,
                  width: 200.w,
                  height: 220.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget eraMerch() {
    return Container(
      color: AppColors.hint,
      height: 500.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'ERA MERCH',
            color: AppColors.kRedColor,
            fontSize: EraTheme.subHeaderWeb,
            fontWeight: FontWeight.w600,
          ),
          sb10(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                latestNewIcon(AppEraAssets.clickFM, () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget latestNews() {
    return Container(
      color: AppColors.hint.withOpacity(0.1),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EraText(
                    text: 'COMPANY NEWS',
                    fontSize: EraTheme.h1,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kRedColor),
                GestureDetector(
                  onTap: () {
                    // selectedIndex.value = 8;
                    // Get.find<HomsController>().onNavbarItemSelected(8);
                    Get.toNamed('/news');
                  },
                  child: EraText(
                      text: 'See all',
                      fontSize: EraTheme.h6,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue),
                ),
              ],
            ),
            EraText(
              text:
                  'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
              fontSize: EraTheme.paragraphWeb,
              fontWeight: FontWeight.w500,
              color: AppColors.hint,
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              height: 550.h,
              width: Get.width,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: controller.news.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () {
                    // HomsController homsController = Get.find<HomsController>();
                    // selectedIndex.value = 9;
                    // homsController.onNavbarItemSelected(9);
                    // newsArgument = {
                    //   "title": controller.news[i].title,
                    //   "image": controller.news[i].image,
                    //   "description": controller.news[i].description
                    // };
                    Get.toNamed('/view-news/${controller.news[i].id}');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CloudStorage().imageLoader(
                            reference: controller.news[i].image,
                            height: 350.h,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                        sb40(),
                        EraText(
                          text: controller.news[i].title.toUpperCase(),
                          fontSize: EraTheme.h3,
                          color: AppColors.kRedColor,
                          fontWeight: FontWeight.bold,
                          textOverflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(height: 8.h),
                        EraText(
                          text: controller.news[i].description,
                          fontSize: EraTheme.h6,
                          color: AppColors.hint,
                          fontWeight: FontWeight.w500,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            HomsController homsController =
                                Get.find<HomsController>();
                            selectedIndex.value = 11;
                            homsController.onNavbarItemSelected(11);
                            newsArgument = {
                              "title": controller.news[i].title,
                              "image": controller.news[i].image,
                              "description": controller.news[i].description,
                            };
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              EraText(
                                text: 'READ MORE',
                                fontSize: EraTheme.h5,
                                color: AppColors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              sbw10(),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.blue,
                                size: EraTheme.h6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget findAgentsandOffices() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'FIND AGENTS AND OFFICES',
          color: AppColors.kRedColor,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('status', isEqualTo: 'approved')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              List<Widget> children = [];
              List randomIndex = [];
              for (int i = 0; i < min(5, snapshot.data!.docs.length); i++) {
                var random = Random().nextInt(snapshot.data!.docs.length);
                while (randomIndex.contains(random)) {
                  random = Random().nextInt(snapshot.data!.docs.length);
                }
                randomIndex.add(random);
                var user = EraUser.fromJSON(snapshot.data!.docs[random].data());
                children.add(
                  Row(
                    children: [
                      iconAgents(user.image ?? AppStrings.noUserImageWhite, () {
                        // listingArgument = user.id!;
                        // selectedIndex.value = 19;
                        // HomsController homsController =
                        //     Get.find<HomsController>();
                        // homsController.onNavbarItemSelected(
                        //   19,
                        // );
                        // Get.toNamed('/')
                        // Get.to(AgentListingsWeb(),
                        //     arguments: [user.id],
                        //     binding: AgentDashboardWebBinding());
                        //error
                        // Get.toNamed('/agent-listings${user.id!}');
                        Get.delete<AgentListingsWebController>();
                        Get.toNamed("/view-agent/${user.id!}");
                      }, "${user.firstname} ${user.lastname}"),
                      sbw10(),
                    ],
                  ),
                );
              }
              return Row(
                children: children,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget myTrainings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'MY TRAININGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              trainingIcon(AppEraAssets.videoT, () {}),
              trainingIcon(AppEraAssets.learningM, () {}),
              trainingIcon(AppEraAssets.upcoming, () {}),
              trainingIcon(AppEraAssets.clickFM, () {})
            ],
          ),
        ),
      ],
    );
  }

  Widget myListings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'MY LISTINGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.subHeaderWeb,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // selectedIndex.value = 13;
                  // Get.find<HomsController>().onNavbarItemSelected(13);
                  // Get.toNamed(
                  //   '/addListings',
                  // );
                  Get.toNamed('/add-listing');
                },
                child: Image.asset(
                  AppEraAssets.addIcon,
                  width: 200.w,
                  height: 220.h,
                ),
              ),
              //todo insert random
              SizedBox(
                height: 220.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listings.length >= 5
                      ? 5
                      : controller.listings.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Get.toNamed('/propertyInfo',
                        //     arguments: controller.listings[index]);
                        // HomsController homsController =
                        //     Get.find<HomsController>();
                        // homsController.onNavbarItemSelected(
                        //   15,
                        // );
                        print("aa");
                        // listingArgument = controller.listings[index];
                        Get.delete<ListingsWebController>();
                        Get.toNamed(
                            '/view-listing/${controller.listings[index].id}');
                      },
                      child: Container(
                          width: 200.w,
                          height: 220.h,
                          decoration: BoxDecoration(boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 1,
                                spreadRadius: 0.5,
                                color: Colors.black38)
                          ], borderRadius: BorderRadius.circular(10.r)),
                          margin: EdgeInsets.symmetric(horizontal: 5.w),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: CloudStorage().imageLoaderProvider(
                                    reference: controller
                                            .listings[index].photos.isNotEmpty
                                        ? controller
                                            .listings[index].photos.first
                                        : AppStrings.noUserImageWhite,
                                    height: 100.w,
                                    width: 100.w,
                                    borderRadius: BorderRadius.circular(10.r)),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.r),
                                          bottomRight: Radius.circular(10.r))),
                                  width: 200.w,
                                  height: 40.h,
                                  child: EraText(
                                    textAlign: TextAlign.center,
                                    text: controller.listings[index].name,
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    textOverflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          )),
                    );
                  },
                ),
              ),
              // HomsController homsController = Get.find<HomsController>();
              // selectedIndex.value = 17;
              // homsController.onNavbarItemSelected(17);
              // // print('agentArgument: $agentArgument');
              // Get.toNamed('/agentMyListingWeb', arguments: [user!.id]);
              GestureDetector(
                onTap: () {
                  Get.toNamed('/my-listings');
                },
                child: Image.asset(
                  AppEraAssets.manageListings,
                  width: 200.w,
                  height: 220.h,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget trainingIcon(String assetPath, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        width: 200.w,
        height: 220.h,
      ),
    );
  }
}

Widget iconAgents(String assetPath, Function()? onTap, String name) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        CloudStorage().imageLoaderProvider(
            width: 200.w,
            height: 220.h,
            reference: assetPath,
            borderRadius: BorderRadius.circular(10.r)),
        EraText(
          text: name,
          textAlign: TextAlign.center,
          color: AppColors.blue,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          textOverflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget latestNewIcon(String assetPath, Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
      height: 120.h,
      width: 120.w,
    ),
  );
}

Widget settingIcon(Function()? onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Center(
      child: Icon(
        CupertinoIcons.settings,
        color: AppColors.blue,
        size: 35.sp,
      ),
    ),
  );
}
