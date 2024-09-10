import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/company/companynews_page.dart';
import 'package:eraphilippines/app/widgets/listings/agentInfo-widget.dart';
import 'package:eraphilippines/presentation/agent/agents/bindings/agent_listings_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/agent_listings.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/settingAgent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/models/navbaritems.dart';
import '../../../../app/widgets/custom_appbar.dart';
import '../../../../app/widgets/navigation/app_nav_items.dart';
import '../../../../repository/user.dart';
import '../../../global.dart';

import '../controllers/agent_dashboard_controller.dart';

class AgentDashBoard extends GetView<AgentDashboardController> {
  AgentDashBoard({
    super.key,
  });
  final AgentsController agentController = Get.put(AgentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(),
        body: SingleChildScrollView(
          controller: controller.scrollController,
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Obx(() {
              if (controller.agentDashboardState.value ==
                  AgentDashboardState.loading) {
                return _loading();
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: EraTheme.paddingWidth, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EraText(
                            text:
                                '${user != null ? '${DateTime.now().hour < 12 ? 'Good Morning,' : DateTime.now().hour < 18 ? 'Good Afternoon,' : 'Good Evening,'} ${user!.firstname}'.capitalize : ''}',
                            fontSize: 20.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 10.h),
                          EraText(
                            text: 'Welcome to your Dashboard!',
                            fontSize: 25.sp,
                            color: AppColors.kRedColor,
                            fontWeight: FontWeight.w600,
                          ),
                          sb10(),

                          SizedBox(height: 10.h),
                          AgentInfoWidget.agentInformation(
                            issettings: true,
                            imageProvider: user!.image != null
                                ? user!.image!
                                : AppStrings.noUserImageWhite,
                            firstName: '${user!.firstname}',
                            lastName: '${user!.lastname}',
                            whatsApp: '${user!.whatsApp}',
                            email: '${user!.email}',
                            role: '${user!.role}',
                          ),
                          SizedBox(height: 25.h),

                          Button(
                            fontSize: EraTheme.paragraph - 2.sp,
                            width: Get.width,
                            text: 'MORTGAGE CALCULATOR',
                            borderRadius: BorderRadius.circular(20),
                            bgColor: AppColors.kRedColor,
                            onTap: () {
                              Get.toNamed("/mortageCalculator");
                            },
                          ),
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

                          // eraMerch(),
                        ],
                      ),
                    ),
                    latestNews(),
                    SizedBox(height: 25.h),
                  ],
                );
              }
            }),
          ),
        ),
        bottomNavigationBar: Obx(() {
          controller.scrolling.value;
          var index = 0;
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            //transform: !controller.scrolling.value ? Matrix4.translationValues(0,  (70.h < 75 ? 70.h : 75), 0) : Matrix4.translationValues(0, 0, 0),
            alignment: Alignment.center,
            height: controller.scrolling.value ? (70.h < 75 ? 70.h : 75) : 0,
            color: AppColors.blue,
            width: Get.width,
            child: controller.scrolling.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: navBarItems.map((item) {
                      String iconPath = item.defaultIcon;
                      index++;
                      return AppNavItems(
                          index: index,
                          iconPath: iconPath,
                          label: item.label,
                          isActive: false);
                    }).toList(),
                  )
                : Row(),
          );
        }));
  }

  _loading() {
    return Container(
      height: 250.h,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget soldProperties() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'SOLD PROPERTIES',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/soldP',
                    arguments: user!.id,
                  );
                },
                child: Image.asset(
                  AppEraAssets.sold,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
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
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed("/archived", arguments: controller.listings);
                },
                child: Image.asset(
                  AppEraAssets.archived,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
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
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                height: 100.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.favorites.length > 4
                      ? 4
                      : controller.favorites.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/propertyInfo',
                            arguments: controller.favorites[index]);
                      },
                      child: Container(
                          height: 100.w,
                          width: 100.w,
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
                                    ref: controller
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
                                  width: 100.w,
                                  height: 20.h,
                                  child: EraText(
                                    textAlign: TextAlign.center,
                                    text: controller.favorites[index].name,
                                    color: Colors.black,
                                    fontSize: 12.sp,
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
                  Get.toNamed("/fav");
                },
                child: Image.asset(
                  AppEraAssets.fav,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget eraMerch() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'ERA MERCH',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              latestNewIcon('assets/icons/eramerch1.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch2.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch3.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon('assets/icons/eramerch4.png', () {}),
              SizedBox(width: 10.w),
              latestNewIcon(AppEraAssets.clickFM, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget latestNews() {
    return Container(
      color: AppColors.hint.withOpacity(0.1),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        child: Column(
          children: [
            SizedBox(
              height: 50.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EraText(
                    text: 'Company News',
                    fontSize: EraTheme.header + 5.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kRedColor),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/companynews");
                  },
                  child: EraText(
                      text: 'See all',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue),
                ),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            EraText(
              text:
                  'Stay updated with ERA Philippines\' latest services and innovations in real estate excellence',
              fontSize: EraTheme.subHeader - 2.sp,
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
                physics: ScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 390.w, //410
                ),
                itemCount: controller.news.length,
                itemBuilder: (context, i) => GestureDetector(
                  onTap: () {
                    Get.to(() => CompanyNewsPage(
                        title: controller.news[i].title,
                        image: controller.news[i].image,
                        description: controller.news[i].description));
                  },
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.only(bottom: 15.h, right: 12.w),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CloudStorage().imageLoader(
                              ref: controller.news[i].image,
                              height: 250.h,
                            ),
                            Spacer(),
                          ],
                        ),
                        Positioned(
                          bottom: 15.h,
                          left: -4.w,
                          right: -4.w,
                          top: 200.h,
                          child: Card(
                            color: AppColors.white,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: EraTheme.paddingWidthSmall + 15.w,
                                  vertical: 15.h),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  EraText(
                                    text: controller.news[i].title,
                                    fontSize: EraTheme.paragraph + 5.sp,
                                    color: AppColors.kRedColor,
                                    fontWeight: FontWeight.bold,
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                  EraText(
                                    text: controller.news[i].description,
                                    fontSize: EraTheme.paragraph - 2.sp,
                                    color: AppColors.hint,
                                    fontWeight: FontWeight.w500,
                                    maxLines: 5,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                ],
                              ),
                            ),
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
    return SizedBox(
      width: Get.width,
      height: 200.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'FIND AGENTS AND OFFICES',
            color: AppColors.kRedColor,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 10.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
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
                  var user =
                      EraUser.fromJSON(snapshot.data!.docs[random].data());
                  children.add(
                    SizedBox(
                      //   cSizedBoxColors.kRedColor,
                      height: 160.h,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Column(
                          children: [
                            iconAgents(
                                user.image ?? AppStrings.noUserImageWhite, () {
                              Get.to(AgentListings(),
                                  arguments: [user.id],
                                  binding: AgentListingsBinding());
                            }, "${user.firstname} ${user.lastname}"),
                          ],
                        ),
                      ),
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
      ),
    );
  }

  Widget myTrainings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'MY TRAININGS',
          color: AppColors.kRedColor,
          fontSize: EraTheme.header - 5.sp,
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
          fontSize: EraTheme.header - 5.sp,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/addListings',
                  );
                },
                child: Image.asset(
                  AppEraAssets.addIcon,
                  height: 110.h,
                  width: 110.w,
                ),
              ),
              //todo insert random
              SizedBox(
                height: 100.w,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.listings.length > 5
                      ? 5
                      : controller.listings.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/propertyInfo',
                            arguments: controller.listings[index]);
                      },
                      child: Container(
                          height: 100.w,
                          width: 100.w,
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
                                    ref:
                                        controller.listings[index].photos.first,
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
                                  width: 100.w,
                                  height: 20.h,
                                  child: EraText(
                                    textAlign: TextAlign.center,
                                    text: controller.listings[index].name,
                                    color: Colors.black,
                                    fontSize: 12.sp,
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
                  Get.toNamed('/agentMyListing', arguments: [user!.id]);
                },
                child: Image.asset(
                  AppEraAssets.manageListings,
                  height: 110.h,
                  width: 110.w,
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
        height: 110.h,
        width: 110.w,
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
            height: 110.h,
            width: 110.w,
            ref: assetPath,
            borderRadius: BorderRadius.circular(10.r)),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 120.w,
          ),
          child: EraText(
            text: name,
            textAlign: TextAlign.center,
            color: AppColors.blue,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            textOverflow: TextOverflow.ellipsis,
          ),
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
      height: 90.h,
      width: 90.w,
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
        size: 25.sp,
      ),
    ),
  );
}
