import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/home/pages/home_web.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/constants/assets.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/services/firebase_database.dart';
import '../controllers/agent_myListingWeb_controller.dart';

class AgentsMyListingWeb extends GetView<AgentListingsWebController> {
  const AgentsMyListingWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() => switch (controller.agentListingsState.value) {
                AgentListingsState.loading => _loading(),
                AgentListingsState.loaded => _loaded(),
                AgentListingsState.empty => _empty(),
                AgentListingsState.error => _error(),
              })
        ],
      ),
    );
  }

  _loaded() {
    Get.find<AgentListingsWebController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/agent-dashboard');
                        // selectedIndex.value = 11;
                        // Get.find<HomsController>().onNavbarItemSelected(11);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  sbw10(),
                  EraText(
                    text: "MY LISTINGS",
                    fontSize: EraTheme.h2,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              //TO DO: nikko not final this is for sorting
              CustomSortPopup(
                title: 'Sort by',
                onSelected: (String result) {},
                menuItems: [
                  popMenu(
                      text: 'Category',
                      isActive: controller.sortBy.value == 'category',
                      onTap: () {
                        controller.sortBy.value = 'category';
                        controller.agentListingsState.value =
                            AgentListingsState.loading;
                        controller.listings
                            .sort((a, b) => a.type!.compareTo(b.type!));
                        controller.agentListingsState.value =
                            AgentListingsState.loaded;
                      }),
                  popMenu(
                      text: 'Date',
                      isActive: controller.sortBy.value == 'date',
                      onTap: () {
                        controller.sortBy.value = 'date';
                        controller.agentListingsState.value =
                            AgentListingsState.loading;
                        controller.listings.sort(
                            (a, b) => a.dateCreated!.compareTo(b.dateCreated!));
                        controller.agentListingsState.value =
                            AgentListingsState.loaded;
                      }),
                  popMenu(
                      text: 'Location',
                      isActive: controller.sortBy.value == 'location',
                      onTap: () {
                        controller.sortBy.value = 'location';
                        controller.agentListingsState.value =
                            AgentListingsState.loading;
                        controller.listings
                            .sort((a, b) => a.location!.compareTo(b.location!));
                        controller.agentListingsState.value =
                            AgentListingsState.loaded;
                      }),
                  popMenu(
                      text: 'Price',
                      isActive: controller.sortBy.value == 'price',
                      onTap: () {
                        controller.sortBy.value = 'price';
                        controller.agentListingsState.value =
                            AgentListingsState.loading;
                        controller.listings
                            .sort((a, b) => a.price!.compareTo(b.price!));
                        controller.agentListingsState.value =
                            AgentListingsState.loaded;
                      }),
                  PopupMenuDivider(),
                  popMenu(
                      text: 'Ascending',
                      isActive: controller.sortOrder.value == 'asc',
                      onTap: () {
                        controller.sortOrder.value = 'asc';
                        controller.agentListingsState.value =
                            AgentListingsState.loading;
                        controller.listings =
                            controller.listings.reversed.toList();
                        controller.agentListingsState.value =
                            AgentListingsState.loaded;
                      }),
                  popMenu(
                      text: 'Descending',
                      isActive: controller.sortOrder.value == 'desc',
                      onTap: () {
                        controller.sortOrder.value = 'desc';
                        controller.agentListingsState.value =
                            AgentListingsState.loading;
                        controller.listings =
                            controller.listings.reversed.toList();
                        controller.agentListingsState.value =
                            AgentListingsState.loaded;
                      }),
                ],
              ),
            ],
          ),

          SizedBox(
            height: 10.h,
          ),
          // GridviewAlllistings(listingModels:controller.listings),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: Get.height - 180.h,
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.listings.length,
            itemBuilder: (context, index) {
              Listing listing = controller.listings[index];
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // await Database().addViews(listing.id);
                      // Get.toNamed('/propertyInfo', arguments: listing);
                      listingArgument = listing;
                      selectedIndex.value = 10;
                      Get.find<HomsController>().onNavbarItemSelected(10);
                    },
                    child: Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: CloudStorage().imageLoader(
                                reference: listing.photos?.isNotEmpty == true
                                    ? listing.photos!.first
                                    : AppStrings.noUserImageWhite,
                                width: Get.width,
                                height: 340.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(
                              height: 17.h,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 14.w, right: 14.w, top: 10.h),
                              child: EraText(
                                text: listing.name?.isNotEmpty == true
                                    ? listing.name!
                                    : "No Name",
                                fontSize: EraTheme.h3,
                                color: AppColors.kRedColor,
                                fontWeight: FontWeight.bold,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: listing.type ?? "Unknown Type",
                                fontSize: EraTheme.h5,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                HomeWeb.buildFeatureIcon(
                                  icon: AppEraAssets.area,
                                  label: '${listing.floorArea} sqm',
                                ),
                                SizedBox(width: 2.w),
                                HomeWeb.buildFeatureIcon(
                                  icon: AppEraAssets.bed,
                                  label: '${listing.beds}',
                                ),
                                SizedBox(width: 2.w),
                                HomeWeb.buildFeatureIcon(
                                  icon: AppEraAssets.tub,
                                  label: '${listing.baths}',
                                ),
                                SizedBox(width: 2.w),
                                HomeWeb.buildFeatureIcon(
                                  icon: AppEraAssets.car,
                                  label: '${listing.cars}',
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: 'Description:',
                                fontSize: EraTheme.h6,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                lineHeight: 1,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: listing.description?.isNotEmpty == true
                                    ? listing.description!
                                    : "No description available.",
                                fontSize: EraTheme.caption,
                                color: AppColors.black,
                                maxLines: 3,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            sb20(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: EraText(
                                text: NumberFormat.currency(
                                        locale: 'en_PH', symbol: 'PHP ')
                                    .format(
                                  listing.price.toString() == ""
                                      ? 0
                                      : listing.price,
                                ),
                                color: AppColors.blue,
                                fontSize: EraTheme.header,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            sb20(),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Button.button3(
                                        height: EraTheme.buttonH60,
                                        onTap: () {
                                          editListingArgument = listing;
                                          // selectedIndex.value = 18;
                                          // Get.find<HomsController>()
                                          //     .onNavbarItemSelected(18);
                                          Get.toNamed('/edit-listing');
                                          print('click ka bi pota@');
                                        },
                                        text: 'Edit',
                                        color: AppColors.blue,
                                        fontSize: 18.sp),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Button.button3(
                                        height: EraTheme.buttonH60,
                                        onTap: () {
                                          BaseController().showSuccessDialog(
                                              title: "Confirm",
                                              description:
                                                  "Do you want to delete this listing?",
                                              hitApi: () async {
                                                controller.agentListingsState
                                                        .value =
                                                    AgentListingsState.loading;
                                                try {
                                                  BaseController()
                                                      .showLoading();
                                                  await CloudStorage()
                                                      .deleteAll(
                                                          fileList:
                                                              listing.photos!);
                                                  await Listing()
                                                      .deleteListingsById(
                                                          listing.id);
                                                  controller.listings
                                                      .removeAt(index);
                                                  BaseController()
                                                      .hideLoading();
                                                } catch (e, ex) {
                                                  print(ex);
                                                }
                                                controller.agentListingsState
                                                        .value =
                                                    AgentListingsState.loaded;
                                                // controller.agentListingsState.value =
                                                //     AgentListingsState.loading;
                                                Get.back();
                                                //     await controller.loadListing();
                                              },
                                              cancelable: true);
                                        },
                                        text: 'Delete',
                                        color: AppColors.kRedColor,
                                        fontSize: 18.sp),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: 20.h,
                    child: Visibility(
                      visible: listing.isSold ?? false,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 4.h),
                        color: AppColors.kRedColor,
                        child: EraText(
                          text: 'SOLD',
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20.h,
                    right: 20.w,
                    child: Visibility(
                      visible: !(listing.isSold ?? false),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(99.r),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.white38,
                                  offset: Offset(1, 1),
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ]),
                        child: Button.button3(
                            height: EraTheme.buttonH60,
                            width: 150.w,
                            onTap: () async {
                              await Database().listingMarkAsSold(listing.id);
                              controller.agentListingsState.value = AgentListingsState.loading;
                              await controller.loadListing();
                              controller.agentListingsState.value = AgentListingsState.loaded;
                              Get.showSnackbar(GetSnackBar(
                                title: "Success",
                                message: "Listing has been mark as sold!",
                                backgroundColor: AppColors.kRedColor,
                                duration:
                                    Duration(seconds: 1, milliseconds: 500),
                              ));
                            },
                            text: 'Mark as Sold',
                            color: AppColors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  _empty() {
    return SizedBox(
      height: Get.height - 225.h,
      width: Get.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EraText(
              text: "You dont have any listings!",
              color: Colors.black,
              fontSize: 16.sp,
            ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed('addListings');
              },
              child: EraText(
                textDecoration: TextDecoration.underline,
                text: "Add Listings?",
                fontSize: 20.sp,
                color: AppColors.kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  _loading() {
    return Screens.loading();
  }

  _error() {
    return Center(
      child: EraText(
        text: "Something went Wrong!",
        color: Colors.black,
      ),
    );
  }

  popMenu({required String text, isActive = false, required onTap, style}) {
    return PopupMenuItem<String>(
      onTap: onTap,
      value: text.toString().toLowerCase(),
      child: Obx(() {
        controller.sortBy.value;
        controller.sortOrder.value;
        return Row(
          children: [
            isActive
                ? Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: AppColors.blue,
                      ),
                      SizedBox(
                        width: 5.w,
                      )
                    ],
                  )
                : Container(),
            Text(
              text,
              style: style ?? TextStyle(),
            )
          ],
        );
      }),
    );
  }
}
