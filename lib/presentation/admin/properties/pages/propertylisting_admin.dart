import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/box_widget.dart';
import '../../../../repository/logs.dart';
import '../../../global.dart';
import '../controllers/listing_admin_controller.dart';

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
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
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
                        hint: 'Property name',
                        svgIcon: AppEraAssets.send,
                        bgColor: AppColors.white,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 250.w,
                      child: SearchWidget.build(() async {
                        controller.addEditListingsStateAd.value =
                            AddEditListingsStateAd.loading;
                        controller.streamSearch = controller.searchStream();
                        controller.addEditListingsStateAd.value =
                            AddEditListingsStateAd.loaded;
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
          sb40(),
          Obx(() {
            if (controller.addEditListingsStateAd.value ==
                AddEditListingsStateAd.loaded) {
              return StreamBuilder(
                stream: controller.streamSearch,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    return GridView.builder(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 20.w,
                        mainAxisExtent: 887.5.h,
                      ),
                      itemBuilder: (context, index) {
                        Listing listing = Listing.fromJSON(data[index].data());
                        var more = false.obs;
                        return GestureDetector(
                          onTap: () async {
                            controller.listing = listing;
                            controllers.onSectionSelected(6);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            padding: EdgeInsets.zero,
                            child: Container(
                              padding: settings!.featuredListings!
                                      .contains(listing.id)
                                  ? EdgeInsets.all(5)
                                  : EdgeInsets.zero,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: settings!.featuredListings!
                                          .contains(listing.id)
                                      ? Border.all(
                                          color: AppColors.kRedColor,
                                          width: 3.w,
                                        )
                                      : Border.all(
                                          width: 0,
                                          color: AppColors.kRedColor
                                              .withOpacity(0)),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        color: Colors.black12)
                                  ]),
                              child: Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CloudStorage().imageLoaderProvider(
                                        height: 400.h,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10.r),
                                            topRight: Radius.circular(10.r)),
                                        width: Get.width - 400.w,
                                        ref: listing.photos != null
                                            ? (listing.photos!.isNotEmpty
                                                ? listing.photos!.first
                                                : AppStrings.noUserImageWhite)
                                            : AppStrings.noUserImageWhite,
                                      ),
                                      SizedBox(
                                        height: 17.h,
                                      ),
                                      Container(
                                        width: Get.width,
                                        height: 30.h,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w),
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
                                                text:
                                                    '${listing.area!.toStringAsFixed(listing.area!.truncateToDouble() == listing.area ? 0 : 1)} sqm',
                                                fontSize:
                                                    EraTheme.paragraph - 1.sp,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w),
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14.w),
                                        child: EraText(
                                          text: NumberFormat.currency(
                                                  locale: 'en_PH',
                                                  symbol: 'PHP ')
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
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 14.w),
                                                child: ListedBy(
                                                    image: user1!.image ??
                                                        AppStrings
                                                            .noUserImageWhite,
                                                    agentFirstName:
                                                        user1.firstname ??
                                                            "No Name",
                                                    agentType:
                                                        user1.role ?? "Agent",
                                                    agentLastName:
                                                        user1.lastname ?? ""),
                                              );
                                            } else {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          }),
                                    ],
                                  ),
                                  Positioned(
                                      top: 10.h,
                                      right: 15.h,
                                      child: IconButton(
                                        onPressed: () {
                                          more.value = true;
                                        },
                                        icon: Icon(
                                          Icons.more_horiz_rounded,
                                          color: Colors.white,
                                          shadows: const [
                                            BoxShadow(
                                                offset: Offset(0, 0),
                                                color: Colors.white,
                                                blurRadius: 5,
                                                spreadRadius: 1)
                                          ],
                                        ),
                                      )),
                                  Obx(() {
                                    if (more.value == true) {
                                      return Wrap(
                                        children: [
                                          Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 15.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  color: Colors.white,
                                                  boxShadow: const [
                                                    BoxShadow(
                                                        offset: Offset(0, 0),
                                                        blurRadius: 5,
                                                        spreadRadius: 1,
                                                        color: Colors.black38)
                                                  ]),
                                              width: Get.width,
                                              child: Column(children: [
                                                Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: IconButton(
                                                      onPressed: () {
                                                        more.value = false;
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        size: 25.sp,
                                                        color: Colors.black,
                                                        shadows: const [
                                                          BoxShadow(
                                                              offset:
                                                                  Offset(0, 0),
                                                              color:
                                                                  Colors.white,
                                                              blurRadius: 5,
                                                              spreadRadius: 1)
                                                        ],
                                                      ),
                                                    )),
                                                _menuOptions("Edit", () async {
                                                  Get.put(ListingsController());
                                                  var c = Get.find<
                                                      AddListingsController>();
                                                  await c.assignData(listing.id,
                                                      isWeb: true);
                                                  Get.find<
                                                          LandingPageController>()
                                                      .onSectionSelected(8);
                                                }, Icons.edit),
                                                _menuOptions(
                                                    settings!.featuredListings!
                                                            .contains(
                                                                listing.id)
                                                        ? "Remove from Featured"
                                                        : "Add to Featured",
                                                    () async {
                                                  controller
                                                          .addEditListingsStateAd
                                                          .value =
                                                      AddEditListingsStateAd
                                                          .loading;
                                                  await settings!
                                                      .addToFeaturedListings(
                                                          listing.id);
                                                  await Logs(
                                                          title:
                                                              "${user!.firstname} ${user!.lastname} ${settings!.featuredListings!.contains(listing.id) ? "removed" : "added"} a listing to featured, with ID ${listing.propertyId}",
                                                          type: "listing")
                                                      .add();
                                                  controller
                                                          .addEditListingsStateAd
                                                          .value =
                                                      AddEditListingsStateAd
                                                          .loaded;
                                                }, Icons.add_circle),
                                                _menuOptions("Delete",
                                                    () async {
                                                  listing.photos!.isNotEmpty
                                                      ? await CloudStorage()
                                                          .deleteAll(
                                                              fileList: listing
                                                                  .photos!)
                                                      : null;
                                                  await listing
                                                      .deleteListings();
                                                  await Logs(
                                                          title:
                                                              "${user!.firstname} ${user!.lastname} added a listing with ID ${listing.propertyId}",
                                                          type: "listing")
                                                      .add();
                                                }, Icons.delete_rounded),
                                                SizedBox(
                                                  height: 20.h,
                                                )
                                              ])),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    print(controller.searchStream());
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          })
        ],
      ),
    );
  }

  _empty() {
    return Center(
      child: Text('Error'),
    );
  }

  _error() {
    return Center(
      child: Text('Error'),
    );
  }

  _menuOptions(text, callback, icon) {
    var isHover = false.obs;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        isHover.value = true;
      },
      onExit: (event) {
        isHover.value = false;
      },
      child: GestureDetector(
        onTap: callback,
        child: Obx(() => Container(
              alignment: Alignment.center,
              width: Get.width,
              color: isHover.value ? AppColors.kRedColor : Colors.white,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 25.sp,
                    color: isHover.value ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: 15.w,
                  ),
                  EraText(
                    text: text,
                    fontSize: 18.sp,
                    color: isHover.value ? Colors.white : Colors.black,
                  ),
                ],
              ),
            )),
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
