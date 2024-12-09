import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/landingpage/controller/homs_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../app/constants/assets.dart';
import '../../../../app/constants/colors.dart';
import '../../../../app/constants/strings.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../../app/services/firebase_storage.dart';
import '../../../../app/widgets/app_text.dart';
import '../../../../app/widgets/image/image_widget.dart';
import '../../../../app/widgets/listings/listedBy_widget.dart';
import '../../../../repository/listing.dart';
import '../../../../repository/user.dart';
import '../controllers/listings_web_controller.dart';

class BuyWebListingPage extends GetView<ListingsWebController> {
  BuyWebListingPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin * 3),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'Property Information',
                  fontSize: EraTheme.headerWeb,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
                sb25(),
                EraText(
                    text: listingArgument.name?.toUpperCase() ??
                        "No property information",
                    color: AppColors.kRedColor,
                    fontSize: EraTheme.header + 2.sp,
                    fontWeight: FontWeight.w600),
                sb20(),
                EraText(
                  text: (listingArgument?.price == null ||
                          listingArgument?.price == 0)
                      ? "PHP 0"
                      : NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                          .format(listingArgument?.price),
                  color: AppColors.black,
                  fontSize: EraTheme.header + 5.sp,
                  fontWeight: FontWeight.bold,
                ),
                sb10(),
                Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.hint.withOpacity(0.3),
                    border: Border.all(
                      color: AppColors.hint.withOpacity(0.9),
                      width: 3.w,
                    ),
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: Get.height,
                        child: CloudStorage().imageLoader(
                            reference: listingArgument.photos!.isNotEmpty
                                ? listingArgument.photos!.first
                                : AppStrings.noUserImageWhite),
                      ),
                      Positioned(
                        bottom: 0.h,
                        child: Container(
                          width: Get.width,
                          height: 250.h,
                          padding: EdgeInsets.all(EraTheme.paddingWidthSmall),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                                  width: Get.width / 7,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.hint.withOpacity(0.9),
                                      width: 5.w,
                                    ),
                                  ),
                                  child: CloudStorage().imageLoader(
                                      width: Get.width / 7,
                                      height: Get.height,
                                      reference:
                                          listingArgument.photos!.isNotEmpty
                                              ? listingArgument.photos![index]
                                              : AppStrings.noUserImageWhite),
                                );
                              },
                              itemCount: listingArgument.photos!.length),
                        ),
                      ),
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
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EraText(
                            text: 'About This Property',
                            color: AppColors.black,
                            fontSize: EraTheme.header + 2.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          sb20(),
                          EraText(
                            text: 'Description',
                            color: AppColors.black,
                            fontSize: EraTheme.header,
                            fontWeight: FontWeight.bold,
                          ),
                          EraText(
                            text: listingArgument.description ?? '',
                            color: AppColors.black,
                            fontSize: EraTheme.paragraph,
                            fontWeight: FontWeight.w400,
                            maxLines: 19,
                          ),
                        ],
                      ),
                    ),
                    summary(),
                  ],
                ),

                // todo missy listing data ( use listingArgument )
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
                      fontSize: EraTheme.header + 3.sp,
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
                      fontSize: EraTheme.header + 3.sp,
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
            SizedBox(
              width: 600.w,
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
              fontSize: EraTheme.subHeader,
              fontWeight: FontWeight.w500,
              lineHeight: 0.9,
            ),
          ),
          Expanded(
            child: EraText(
              text: text2,
              color: AppColors.black,
              fontSize: EraTheme.paragraph - 5.sp,
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
                  fontSize: EraTheme.subHeaderWeb,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: 15.h),
                EraText(
                  text: 'Address',
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: EraTheme.paragraphWeb - 5.sp,
                ),
                EraText(
                  text: listingArgument.address ?? "No Address Added",
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: EraTheme.paragraphWeb - 10.sp,
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
            fontSize: EraTheme.headerWeb,
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
                          print('sss');
                          listingArgument = listing;
                          selectedIndex.value = 12;
                          Get.find<HomsController>().onNavbarItemSelected(12);
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
                                  height: 300.h,
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
                              sb5(),
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
                                        text: '${listing.floorArea} sqm',
                                        fontSize: EraTheme.paragraph - 1.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.black,
                                      ),
                                    ],
                                  ),
                                  sbw10(),
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
                                  sbw10(),
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
                                  sbw10(),
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
                              sb5(),
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
