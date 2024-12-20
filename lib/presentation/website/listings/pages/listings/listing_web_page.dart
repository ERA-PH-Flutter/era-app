import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/screens.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../app/constants/assets.dart';
import '../../../../../app/constants/colors.dart';
import '../../../../../app/constants/strings.dart';
import '../../../../../app/services/firebase_storage.dart';
import '../../../../../app/widgets/app_text.dart';
import '../../../../../app/widgets/image/image_widget.dart';
import '../../../../../app/widgets/interactive_property_image.dart';
import '../../../../../app/widgets/listings/listedBy_widget.dart';
import '../../../../../repository/listing.dart';
import '../../../../../repository/user.dart';
import '../../../home/pages/home_web.dart';
import '../../controllers/listings_web_controller.dart';

class BuyWebListingPage extends GetView<ListingsWebController> {
  BuyWebListingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => switch (controller.listingsWebState.value) {
          ListingsWebState.loading => Screens.loading(),
          ListingsWebState.loaded => _loaded(),
          ListingsWebState.error => Screens.error(),
          ListingsWebState.searching => Screens.loading(),
          ListingsWebState.empty => Screens.empty(),
        });
  }

  _loaded() {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: AppColors.primary, size: 24.sp),
                    SizedBox(width: 8.sp),
                    EraText(
                      text: 'Property Information',
                      fontSize: EraTheme.h1,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ],
                ),
                EraText(
                  text: listingArgument.name?.toUpperCase() ??
                      "No property information",
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.h1,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.left,
                ),
                sb20(),
                EraText(
                  text: (listingArgument?.price == null ||
                          listingArgument?.price == 0)
                      ? "PHP 0"
                      : NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                          .format(listingArgument?.price),
                  color: AppColors.black,
                  fontSize: EraTheme.h2,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                ),
                sb10(),
                SizedBox(
                  height: Get.height,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Positioned(
                          child: GestureDetector(
                        onTap: () {
                          showDialog(
                              context: Get.context!,
                              builder: (BuildContext context) {
                                final PageController pageController =
                                    PageController(
                                  initialPage: listingArgument.photos!
                                      .indexOf(controller.currentImage.value),
                                );
                                return Dialog(
                                  child: Container(
                                      width: Get.width,
                                      height: Get.height,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: 30,
                                            right: 0,
                                            left: 0,
                                            bottom: 30.h,
                                            child: PageView.builder(
                                              controller: pageController,
                                              itemCount: listingArgument
                                                  .photos!.length,
                                              onPageChanged: (index) {
                                                controller.currentImage.value =
                                                    listingArgument
                                                        .photos![index];
                                              },
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  width: Get.width,
                                                  height: Get.height,
                                                  child: CloudStorage().imageLoader(
                                                      fit: BoxFit.contain,
                                                      reference: listingArgument
                                                              .photos!
                                                              .isNotEmpty
                                                          ? listingArgument
                                                              .photos![index]
                                                          : AppStrings
                                                              .noUserImageWhite),
                                                );
                                              },
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                color: AppColors.white,
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                          ),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              right: 0,
                                              child: Obx(() => Center(
                                                    child: EraText(
                                                      text:
                                                          "${listingArgument.photos!.indexOf(controller.currentImage.value) + 1}/${listingArgument.photos!.length}",
                                                      color: AppColors.white,
                                                      fontSize: 20.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ))),
                                          Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Obx(() {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: List.generate(
                                                      listingArgument.photos!
                                                          .length, (index) {
                                                    bool isActive =
                                                        listingArgument.photos![
                                                                index] ==
                                                            controller
                                                                .currentImage
                                                                .value;

                                                    return Container(
                                                      width: 10,
                                                      height: 10,
                                                      margin:
                                                          EdgeInsets.all(5.sp),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: isActive
                                                            ? Colors.white
                                                            : Colors.white
                                                                .withOpacity(
                                                                    0.5),
                                                      ),
                                                    );
                                                  }),
                                                );
                                              })),

                                          // Positioned(
                                        ],
                                      )),
                                );
                              });
                        },
                        child: SizedBox(
                            width: Get.width,
                            height: Get.height,
                            child: Obx(() {
                              final displayImage =
                                  controller.currentImage.value.isNotEmpty
                                      ? controller.currentImage.value
                                      : listingArgument.photos!.isNotEmpty
                                          ? listingArgument.photos!.first
                                          : AppStrings.noUserImageWhite;

                              return ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CloudStorage().imageLoader(
                                  reference: displayImage,
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  height: Get.height,
                                ),
                              );
                            })),
                      )),
                      Obx(() {
                        return Positioned(
                          bottom: 20.h,
                          left: 0,
                          right: 0,
                          child: Container(
                            width: Get.width,
                            height: 260.h,
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                                color: AppColors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  listingArgument.photos!.length,
                                  (index) {
                                    final image =
                                        listingArgument.photos![index];
                                    final isSelected =
                                        controller.currentImage.value == image;
                                    return GestureDetector(
                                      onTap: () {
                                        controller.currentImage.value = image;
                                      },
                                      child: AnimatedContainer(
                                        width: Get.width / 7,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            border: Border.all(
                                              color: AppColors.hint
                                                  .withOpacity(0.9),
                                              width: isSelected ? 5.w : 1.w,
                                            )),
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeInOut,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: CloudStorage().imageLoader(
                                            width: Get.width / 7,
                                            height: Get.height,
                                            reference: image,
                                          ),
                                        ),
                                      ),

                                      //    Container(
                                      //     margin: EdgeInsets.symmetric(
                                      //         horizontal: 5.w),
                                      //     decoration: BoxDecoration(
                                      //       border: Border.all(
                                      //         color: AppColors.hint
                                      //             .withOpacity(0.9),
                                      //         width: isSelected ? 5.w : 1.w,
                                      //       ),
                                      //     ),
                                      //     child: CloudStorage().imageLoader(
                                      //       width: Get.width / 7,
                                      //       height: Get.height,
                                      //       reference: image,
                                      //     ),
                                      //   ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Obx(() {
                        controller.isFav.value;
                        if (user != null) {
                          return Positioned(
                            right: 15.w,
                            top: 10.h,
                            child: Container(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                  onTap: () {
                                    controller.isFav.value =
                                        !controller.isFav.value;
                                    user!.addFavorites(listingArgument.id);
                                    Get.showSnackbar(GetSnackBar(
                                      title: "Success",
                                      message:
                                          "${controller.isFav.value ? "Added" : "Removed"} to favorites",
                                      backgroundColor: AppColors.kRedColor,
                                      duration: Duration(
                                          milliseconds: 500, seconds: 1),
                                    ));
                                  },
                                  child: Icon(
                                    shadows: const [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(0, 0),
                                          blurRadius: 20)
                                    ],
                                    user!.favorites!
                                            .contains(listingArgument.id)
                                        ? CupertinoIcons.heart_fill
                                        : CupertinoIcons.heart_fill,
                                    color: user!.favorites!
                                            .contains(listingArgument.id)
                                        ? AppColors.kRedColor
                                        : AppColors.white,
                                    size: 45.sp,
                                  )),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                ),
                sb40(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EraText(
                            text: 'About This Property',
                            color: AppColors.black,
                            fontSize: EraTheme.h1,
                            fontWeight: FontWeight.bold,
                          ),
                          sb20(),
                          EraText(
                            text: 'Description',
                            color: AppColors.black,
                            fontSize: EraTheme.h4,
                            fontWeight: FontWeight.w600,
                          ),
                          sb10(),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.grey.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.all(EraTheme.paddingWidth15),
                            child: EraText(
                              text: listingArgument.description ?? '',
                              color: AppColors.black,
                              fontSize: EraTheme.bodyText,
                              fontWeight: FontWeight.w400,
                              maxLines: 6,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: EraTheme.paddingWidth30),
                    summary(),
                  ],
                ),
              ],
            ),
          ),
        ),
        location(),
        sb20(),
        listedByAgent(listing: listingArgument),
        similarListings(),
      ],
    );
  }

  Widget summary() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            sb20(),
            Container(
              width: 600.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.hint,
                  width: 2.w,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sb10(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: EraTheme.paddingWidthSmall),
                    child: EraText(
                      text: 'OVERVIEW SUMMARY',
                      fontSize: EraTheme.h2,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kRedColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        shorterSummary(
                          text: 'Property ID:',
                          text2: '${listingArgument.propertyId}',
                        ),
                        shorterSummary(
                          text: 'Price',
                          text2: NumberFormat.currency(
                                  locale: 'en_PH', symbol: 'PHP ')
                              .format(listingArgument.price),
                        ),
                        shorterSummary(
                          text: 'Price per sqm',
                          text2: NumberFormat.currency(
                                  locale: 'en_PH', symbol: 'PHP ')
                              .format(listingArgument?.ppsqm),
                        ),
                        shorterSummary(
                          text: 'Beds',
                          text2: listingArgument?.beds.toString() ?? "",
                        ),
                        shorterSummary(
                          text: 'Baths',
                          text2: listingArgument?.baths.toString() ?? "",
                        ),
                        shorterSummary(
                          text: 'Garage',
                          text2: listingArgument?.cars.toString() ?? "",
                        ),
                        shorterSummary(
                          text: 'Area',
                          text2: listingArgument?.floorArea.toString() ?? "",
                        ),
                        shorterSummary(
                          text: 'View',
                          text2: listingArgument?.view ?? "No view",
                        ),
                        shorterSummary(
                          text: 'Location',
                          text2: listingArgument?.location ?? '',
                        ),
                        shorterSummary(
                          text: 'Type',
                          text2: listingArgument?.type ?? "",
                        ),
                        shorterSummary(
                          text: 'Sub Category',
                          text2: listingArgument?.subCategory ?? "",
                        ),
                        sb20(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sb20(),
            Container(
              width: 600.w,
              decoration: BoxDecoration(
                color: AppColors.hint.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: AppColors.hint,
                  width: 2.w,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sb10(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: EraTheme.paddingWidthSmall),
                    child: EraText(
                      text: 'PROPERTY PERFORMANCE',
                      fontSize: EraTheme.h2,
                      fontWeight: FontWeight.bold,
                      color: AppColors.kRedColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
                    child: Column(
                      children: [
                        SizedBox(height: 5.h),
                        shorterSummary(
                          text: 'Views',
                          text2: listingArgument?.views.toString() ?? "",
                        ),
                        shorterSummary(
                          text: 'Leads',
                          text2: listingArgument?.leads.toString() ?? "",
                        ),
                        sb20(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            sb30(),
            Container(
              //color: AppColors.black,
              padding: EdgeInsets.only(left: 90.w),
              width: Get.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  shorterSummary(
                      color: AppColors.blue,
                      text: 'Last Updated: ',
                      text2: '${listingArgument?.dateUpdated}'),
                  shorterSummary(
                      color: AppColors.blue,
                      text: 'Added: ',
                      text2:
                          '${DateTime.now().difference(listingArgument!.dateCreated ?? DateTime.now()).inDays} days ago'),
                ],
              ),
            ),
            sb30(),
          ],
        ),
      ),
    );
  }

  Widget shorterSummary({required String text, required String text2, color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        children: [
          Expanded(
            child: EraText(
              text: text,
              color: color ?? AppColors.black,
              fontSize: EraTheme.h4,
              fontWeight: FontWeight.w500,
              lineHeight: 0.9,
            ),
          ),
          Expanded(
            child: EraText(
              text: text2,
              color: AppColors.black,
              fontSize: EraTheme.h4,
              fontWeight: FontWeight.w500,
              lineHeight: 0.9,
            ),
          ),
        ],
      ),
    );
  }

  Widget location() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: EraTheme.paddingWidthAdmin * 3,
      ),
      width: Get.width,
      height: Get.height / 2,
      color: AppColors.hint.withOpacity(0.3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sb20(),
                EraText(
                  text: 'Location',
                  color: AppColors.kRedColor,
                  fontSize: EraTheme.h2,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 15.h),
                EraText(
                  text: 'Address',
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: EraTheme.h3,
                ),
                EraText(
                  text: listingArgument.address ?? "No Address Added",
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: EraTheme.bodyText,
                ),
              ],
            ),
          ),
          sb20(),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(
                bottom: EraTheme.paddingWidthAdmin,
                top: EraTheme.paddingWidthAdmin,
              ),
              width: Get.width,
              height: Get.height,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        listingArgument.latLng != null
                            ? listingArgument.latLng![0].toString().toDouble()
                            : 0,
                        listingArgument.latLng != null
                            ? listingArgument.latLng![1].toString().toDouble()
                            : 0),
                    zoom: 13.0),
                markers: {
                  Marker(
                      position: LatLng(
                          listingArgument.latLng != null
                              ? listingArgument.latLng![0].toString().toDouble()
                              : 0,
                          listingArgument.latLng != null
                              ? listingArgument.latLng![1].toString().toDouble()
                              : 0),
                      markerId: MarkerId('mainPin'),
                      icon: BitmapDescriptor.defaultMarker)
                },
                zoomControlsEnabled: false,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget listedByAgent({required Listing listing}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: FutureBuilder(
                future: EraUser().getById(listing.by),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var user1 = snapshot.data;
                    return ListedBy(
                      listingId: listing.id,
                      image: user1!.image ?? AppStrings.noUserImageWhite,
                      agentFirstName: user1.firstname ?? "",
                      agentType: user1.role ?? "Agent",
                      agentLastName: user1.lastname ?? "",
                      whatsapp: user1.whatsApp,
                      whatsappIcon: AppEraAssets.whatsappIcon,
                      email: user1.email,
                      emailIcon: AppEraAssets.emailIcon,
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
          Expanded(flex: 1, child: SizedBox.shrink()),
        ],
      ),
    );
  }

  Widget similarListings() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sb20(),
          EraText(
            text: 'Similar Listings',
            color: AppColors.kRedColor,
            fontSize: EraTheme.h1,
            fontWeight: FontWeight.bold,
          ),
          sb20(),
          SizedBox(
            height: Get.height / 1.4,
            width: Get.width,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('listings')
                  .where('location', isEqualTo: listingArgument.location)
                  .where('type', isEqualTo: listingArgument.type)
                  .get(),
              builder: (context, snapshot) {
                var docs = snapshot.data!.docs;
                var newDocs = [];
                for (int i = 0; i < (docs.length < 4 ? docs.length : 4); i++) {
                  newDocs.add(Listing.fromJSON(docs[i].data()));
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: newDocs.length,
                    itemBuilder: (context, index) {
                      var listing = newDocs[index];
                      return GestureDetector(
                        onTap: () async {
                          controller.listingsWebState.value =
                              ListingsWebState.loading;
                          listingArgument = listing;
                          controller.listingsWebState.value =
                              ListingsWebState.loaded;
                          controller.scrollController.animateTo(
                            0.0,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        child: Container(
                          width: 378.w,
                          margin: EdgeInsets.only(bottom: 16.h, right: 10.w),
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
                                child: ImageWidget(
                                  thumbnailUrl: listing.photos != null
                                      ? (listing.photos!.isNotEmpty
                                          ? listing.photos!.first
                                          : AppStrings.noUserImageWhite)
                                      : AppStrings.noUserImageWhite,
                                  fit: BoxFit.cover,
                                  height: 340.h,
                                  width: Get.width,
                                ),

                                // CloudStorage().imageLoader(
                                //   reference: listing.photos != null
                                //       ? (listing.photos!.isNotEmpty
                                //           ? listing.photos!.first
                                //           : AppStrings.noUserImageWhite)
                                //       : AppStrings.noUserImageWhite,
                                //   width: Get.width,
                                //   height: 300.h,
                                // ),
                              ),
                              sb17(),
                              Container(
                                width: Get.width,
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: EraText(
                                  textOverflow: TextOverflow.ellipsis,
                                  text: listing.name! == ""
                                      ? "No Name"
                                      : listing.name!,
                                  fontSize: EraTheme.h3,
                                  color: AppColors.kRedColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: EraText(
                                  text: listing.type!,
                                  fontSize: EraTheme.h5,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                  lineHeight: 1,
                                ),
                              ),
                              sb5(),
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
                              sb5(),
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
                                child: Text(
                                  listing.description == ""
                                      ? "No description."
                                      : listing.description!,
                                  style: TextStyle(
                                    fontSize: EraTheme.caption,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                  maxLines: 3,
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
                                  fontSize: EraTheme.h4,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
            ),
          ),
        ],
      ),
    );
  }
}
