import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/constants/sized_box.dart';
import '../../../../app/widgets/box_widget.dart';
import '../../../../repository/logs.dart';
import '../../../global.dart';
import '../controllers/listing_admin_controller.dart';
import '../controllers/listing_approval_controller.dart';

class ListingApproval extends GetView<ListingApprovalController> {
  const ListingApproval({super.key});

  @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
  //     child:
  // }
//  var listingState = ListingsAState.loading.obs;
  @override
  Widget build(BuildContext context) {
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              EraText(
                text: 'APPROVAL OF LISTINGS',
                fontSize: EraTheme.header,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ]),
            SizedBox(height: 20),
            Obx(() => switch (controller.listingApprovalState.value) {
                  ListingApprovalState.loading => Center(
                      child: CircularProgressIndicator(),
                    ),
                  ListingApprovalState.loaded => _loaded(),
                  ListingApprovalState.error => _error(),
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
          sb40(),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('listings')
                .where('is_approve', isEqualTo: false)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs;
                if (data.isEmpty) {
                  return SizedBox(
                    height: Get.height - 300.h,
                    child: Center(
                      child: EraText(
                        text: 'No listings found for approval',
                        fontSize: 23.sp,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.w,
                    mainAxisExtent: 900.h,
                  ),
                  itemBuilder: (context, index) {
                    Listing listing = Listing.fromJSON(data[index].data());
                    var more = false.obs;
                    return GestureDetector(
                      onTap: () async {
                        var c = Get.find<ListingsAdminController>();
                        c.listing = listing;
                        controllers.onSectionSelected(25);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 0,
                                  color: AppColors.kRedColor.withOpacity(0)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                    future: CloudStorage().getFileBytes(
                                      docRef: listing.photos != null
                                          ? (listing.photos!.isNotEmpty
                                              ? listing.photos!.first
                                              : AppStrings.noUserImageWhite)
                                          : AppStrings.noUserImageWhite,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return Container(
                                          width: Get.width,
                                          height: 400.h,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.r),
                                                topRight:
                                                    Radius.circular(10.r)),
                                          ),
                                          child: Image.memory(
                                            snapshot.data!,
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 17.h,
                                  ),
                                  Container(
                                    width: Get.width,
                                    height: 30.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
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
                                                '${listing.floorArea!.toStringAsFixed(listing.floorArea!.truncateToDouble() == listing.floorArea ? 0 : 1)} sqm',
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 14.w),
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
                                          var user = snapshot.data!;
                                          final Uri whatsAppUrl2 = user.whatsApp !=
                                                  null
                                              ? Uri.parse(
                                                  'https://wa.me/${user.whatsApp}')
                                              : Uri.parse('https://wa.me/null');
                                          final Uri emailUrl = user.email !=
                                                  null
                                              ? Uri.parse(
                                                  'mailto:${user.email}?subject=Your%20Subject&body=Your%20Message')
                                              : Uri.parse(
                                                  'https://mail.google.com/');
                                          return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 14.w),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  EraText(
                                                    text: 'Listed By:',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        EraTheme.paragraph,
                                                    color: AppColors.black,
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.w),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color:
                                                                      AppColors
                                                                          .hint),
                                                          child: FutureBuilder(
                                                            future: CloudStorage()
                                                                .getFileBytes(
                                                              docRef: user
                                                                      .image ??
                                                                  AppStrings
                                                                      .noUserImageWhite,
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                return Container(
                                                                  width: 55.w,
                                                                  height: 55.w,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(10
                                                                                .r),
                                                                        topRight:
                                                                            Radius.circular(10.r)),
                                                                  ),
                                                                  child: Image
                                                                      .memory(
                                                                    snapshot
                                                                        .data!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                );
                                                              }
                                                              return Center(
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 200.w,
                                                              child: EraText(
                                                                text:
                                                                    '${user.firstname} ${user.lastname}',
                                                                fontSize: EraTheme
                                                                    .paragraph,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .black,
                                                                textOverflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            EraText(
                                                              text: user.role !=
                                                                      null
                                                                  ? (user.role!
                                                                          .contains(
                                                                              "admin")
                                                                      ? "ERA Admin"
                                                                      : user
                                                                          .role!)
                                                                  : "No role",
                                                              fontSize: EraTheme
                                                                      .paragraph -
                                                                  4.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .black,
                                                            ),
                                                            // SizedBox(height: 5.h),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(height: 10.h),
                                                ],
                                              ));
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
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
                                              horizontal: 10.w, vertical: 15.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
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
                                                          offset: Offset(0, 0),
                                                          color: Colors.white,
                                                          blurRadius: 5,
                                                          spreadRadius: 1)
                                                    ],
                                                  ),
                                                )),
                                            _menuOptions("Approved", () async {
                                              controller.listingApprovalState
                                                      .value =
                                                  ListingApprovalState.loading;
                                              listing.isApprove = true;
                                              await listing.updateListing();
                                              await Logs(
                                                      title:
                                                          "${user!.firstname} ${user!.lastname} approve a listing with ID ${listing.propertyId}",
                                                      type: "listing")
                                                  .add();
                                              controller.listingApprovalState
                                                      .value =
                                                  ListingApprovalState.loaded;
                                            }, Icons.check),
                                            _menuOptions("Decline", () async {
                                              controller.listingApprovalState
                                                      .value =
                                                  ListingApprovalState.loading;
                                              listing.photos!.isNotEmpty
                                                  ? await CloudStorage()
                                                      .deleteAll(
                                                          fileList:
                                                              listing.photos!)
                                                  : null;
                                              await listing.deleteListings();
                                              await Logs(
                                                      title:
                                                          "${user!.firstname} ${user!.lastname} added a listing with ID ${listing.propertyId}",
                                                      type: "listing")
                                                  .add();
                                              controller.listingApprovalState
                                                      .value =
                                                  ListingApprovalState.loaded;
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
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
