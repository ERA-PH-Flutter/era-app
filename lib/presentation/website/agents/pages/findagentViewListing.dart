import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/constants/assets.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/listings/agentInfo-widget.dart';
import '../../home/pages/home_web.dart';
import '../../listings/controllers/listings_web_controller.dart';
import '../controllers/agent_myListingWeb_controller.dart';

class FindAgentViewListing extends GetView<AgentListingsWebController> {
  const FindAgentViewListing({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() => switch (controller.agentListingsState.value) {
            AgentListingsState.loading => _loading(),
            AgentListingsState.loaded => _loaded(),
            AgentListingsState.empty => _empty(),
            AgentListingsState.error => _error(),
          }),
    );
  }

  _loaded() {
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
                        // Get.toNamed('/agent-dashboard');
                        Get.toNamed('/find-agents');
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  sbw10(),
                  EraText(
                    text: "LISTINGS",
                    fontSize: EraTheme.headerWeb,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              //TO DO: nikko not final this is for sorting
              CustomSortPopup(
                title: 'Sort by',
                onSelected: (String result) {
                  print(result);
                },
                menuItems: const [
                  PopupMenuItem<String>(
                    value: 'Category',
                    child:
                        Text('Category', style: TextStyle(color: Colors.black)),
                  ),
                  PopupMenuItem<String>(
                    value: 'date_modified',
                    child: Text('Date', style: TextStyle(color: Colors.black)),
                  ),
                  PopupMenuItem<String>(
                    value: 'Location',
                    child:
                        Text('Location', style: TextStyle(color: Colors.black)),
                  ),
                  PopupMenuItem<String>(
                    value: 'Amount',
                    child:
                        Text('Amount', style: TextStyle(color: Colors.black)),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<String>(
                    value: 'ascending',
                    child: Text('Ascending'),
                  ),
                  PopupMenuItem<String>(
                    value: 'descending',
                    child: Text('Descending'),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.w, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AgentInfoWidget.agentInformation(
                      imageProvider:
                          '${controller.user!.image == null || controller.user!.image == "" ? AppStrings.noUserImageWhite : controller.user.image}',
                      firstName: '${controller.user!.firstname}',
                      lastName: '${controller.user!.lastname}',
                      whatsApp: '${controller.user!.whatsApp}',
                      email: '${controller.user!.email}',
                      role: '${controller.user!.role}',
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20.h,
          ),
          // GridviewAlllistings(listingModels: controller.listings),
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
              return GestureDetector(
                onTap: () async {
                  Get.delete<ListingsWebController>();
                  Get.toNamed('/view-listing/${listing.id}');
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
                          reference: listing.photos != null
                              ? (listing.photos!.isNotEmpty
                                  ? listing.photos!.first
                                  : AppStrings.noUserImageWhite)
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
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
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
                          text: listing.type!,
                          fontSize: EraTheme.h5,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Image.asset(
                          //       AppEraAssets.area,
                          //       width: 55.w,
                          //       height: 55.w,
                          //     ),
                          //     SizedBox(width: 2.w),
                          //     EraText(
                          //       text: '${listing.floorArea} sqm',
                          //       fontSize: EraTheme.paragraph - 1.sp,
                          //       fontWeight: FontWeight.w500,
                          //       color: AppColors.black,
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(width: 10.w),
                          // Image.asset(
                          //   AppEraAssets.bed,
                          //   width: 55.w,
                          //   height: 55.w,
                          // ),
                          // EraText(
                          //   text: '${listing.beds}',
                          //   fontSize: EraTheme.paragraph - 1.sp,
                          //   fontWeight: FontWeight.w500,
                          //   color: AppColors.black,
                          // ),
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
                      SizedBox(
                        height: 2.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: EraText(
                          text: listing.description == ""
                              ? "No description."
                              : listing.description!,
                          fontSize: EraTheme.caption,
                          color: AppColors.black,
                          maxLines: 3,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: EraText(
                          text: NumberFormat.currency(
                                  locale: 'en_PH', symbol: 'PHP ')
                              .format(
                            listing.price.toString() == "" ? 0 : listing.price,
                          ),
                          color: AppColors.blue,
                          fontSize: EraTheme.header,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      sb20(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
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

  _empty() {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/find-agents');
                },
                icon: Icon(Icons.arrow_back_ios)),
            SizedBox(
              height: Get.height - 225.h,
              child: Center(
                child: EraText(
                  text: "This User don't have any listings!",
                  color: Colors.black,
                  fontSize: 23.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
