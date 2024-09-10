import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/ai_search.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/project_management/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/box_widget.dart';

class PropertylistAdmin extends GetView<ListingsAdminController> {
  const PropertylistAdmin({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
  //     child:
  // }
//  var listingState = ListingsAState.loading.obs;
  @override
  Widget build(BuildContext context) {
    ListingsAdminController controller = Get.put(ListingsAdminController());

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: 'PROPERTY LIST',
              fontSize: EraTheme.header,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 20),
            EraText(
              text: ' SEARCH',
              fontSize: EraTheme.header,
              color: AppColors.black,
              fontWeight: FontWeight.w600,
            ),
            Obx(() => switch (controller.listingState.value) {
                  ListingsAState.loading => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ListingsAState.loaded => _loaded(),
                  ListingsAState.empty => _empty(),
                  ListingsAState.error => _error(),
                }),
          ],
        ),
      ),
    );
  }

  _loaded() {
    LandingPageController controllers = Get.put(LandingPageController());
    AddListingsController addlistingcontroller =
        Get.put(AddListingsController());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxWidget.build(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        //borderRadius: BorderRadius.circular(10),
                        controller: controller.locationController,
                        hint: 'Location',
                        svgIcon: AppEraAssets.marker,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: AppTextField(
                        controller: controller.priceController,
                        hint: 'Price Range',
                        svgIcon: AppEraAssets.money,
                        bgColor: AppColors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: controller.propertyController,
                        hint: 'Property Type',
                        svgIcon: AppEraAssets.house,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                      fillColor: WidgetStateProperty.all(
                                          AppColors.white.withOpacity(0.6)),
                                      value: 1,
                                      groupValue: controller.isForSale.value,
                                      onChanged: (value) {
                                        controller.isForSale.value = value ?? 0;
                                      }),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                EraText(
                                    text: 'BUY',
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 1.9,
                                  child: Radio(
                                      fillColor: WidgetStateProperty.all(
                                          AppColors.white.withOpacity(0.6)),
                                      value: 2,
                                      groupValue: controller.isForSale.value,
                                      onChanged: (value) {
                                        controller.isForSale.value = value ?? 0;
                                      }),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                EraText(
                                    text: 'RENT',
                                    color: AppColors.white.withOpacity(0.6),
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        controller: controller.aiSearchController,
                        hint: 'AI Search',
                        svgIcon: AppEraAssets.send,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 250.w,
                      child: SearchWidget.build(() async {
                        var data;
                        if (controller.aiSearchController.text == "") {
                          data = await Database().searchListing(
                              location: controller.locationController.text,
                              price: controller.priceController,
                              property: controller.propertyController.text);
                        } else {
                          data = await AI(
                                  query: controller.aiSearchController.text)
                              .search();
                        }
                        Get.toNamed("/searchresult", arguments: [
                          data,
                          controller.aiSearchController.text
                        ]);
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          sb40(),
          Container(
            child: GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20.w,
                mainAxisExtent: 700.h,
              ),
              itemBuilder: (context, index) {
                //print(controller.data[index]);
                if (controller.data[index] != null) {
                  Listing listing = Listing.fromJSON(controller.data[index]);
                  return GestureDetector(
                    onTap: () async {
                      // await Database().addViews(listing.id);
                      controller.listing = listing;
                      controllers.onSectionSelected(6);
                      //Get.offAllNamed('/propertyInfo', arguments: listing);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                spreadRadius: 1,
                                blurRadius: 10,
                                color: Colors.black12)
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10.r),
                              child: CloudStorage().imageLoader(
                                height: 200.h,
                                width: Get.width - 400.w,
                                ref: listing.photos != null
                                    ? (listing.photos!.isNotEmpty
                                        ? listing.photos!.first
                                        : AppStrings.noUserImageWhite)
                                    : AppStrings.noUserImageWhite,
                              )),
                          SizedBox(
                            height: 17.h,
                          ),
                          Container(
                            width: Get.width,
                            height: 30.h,
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: EraText(
                              textOverflow: TextOverflow.ellipsis,
                              text: listing.name! == ""
                                  ? "No Name"
                                  : listing.name!,
                              fontSize: EraTheme.header - 5.sp,
                              color: AppColors.kRedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: EraText(
                              text: listing.type!,
                              fontSize: EraTheme.header - 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1,
                            ),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Row(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    AppEraAssets.area,
                                    width: 55.w,
                                    height: 55.w,
                                  ),
                                  SizedBox(width: 2.w),
                                  EraText(
                                    text: '${listing.area} sqm',
                                    fontSize: EraTheme.paragraph - 1.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ],
                              ),
                              SizedBox(width: 10.w),
                              Image.asset(
                                AppEraAssets.bed,
                                width: 55.w,
                                height: 55.w,
                              ),
                              EraText(
                                text: '${listing.beds}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              SizedBox(width: 10.w),
                              Image.asset(
                                AppEraAssets.tub,
                                width: 55.w,
                                height: 55.w,
                              ),
                              EraText(
                                text: '${listing.baths}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              SizedBox(width: 10.w),
                              Image.asset(
                                AppEraAssets.car,
                                width: 55.w,
                                height: 55.w,
                              ),
                              EraText(
                                text: '${listing.cars}',
                                fontSize: EraTheme.paragraph - 1.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
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
                              fontSize: EraTheme.header - 8.sp,
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
                            child: Text(
                              listing.description == ""
                                  ? "No description."
                                  : listing.description!,
                              style: TextStyle(
                                fontSize: EraTheme.paragraph - 4.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
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
                                listing.price.toString() == ""
                                    ? 0
                                    : listing.price,
                              ),
                              color: AppColors.blue,
                              fontSize: EraTheme.header,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FutureBuilder(
                              future: EraUser().getById(listing.by),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var user1 = snapshot.data;
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
                                    child: ListedBy(
                                        image: user1!.image ??
                                            AppStrings.noUserImageWhite,
                                        agentFirstName:
                                            user1.firstname ?? "No Name",
                                        agentType: user1.role ?? "Agent",
                                        agentLastName: user1.lastname ?? ""),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }

  _empty() {
    return Container(
      child: Center(
        child: Text('Error'),
      ),
    );
  }

  _error() {
    return Container(
      child: Center(
        child: Text('Error'),
      ),
    );
  }

  Widget quickSearchAdmin(String icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 120.h,
            width: 120.w,
          ),
        ],
      ),
    );
  }
}
