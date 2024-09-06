import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/listings/listedBy_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../../../../../repository/listing.dart';
import '../../../../global.dart';
import '../../favorites/controllers/fav_controller.dart';
import '../controllers/listing_controller.dart';

class PropertyInformation extends GetView<ListingController> {
  final Listing listing;
  var init = true;
  PropertyInformation({
    super.key,
    required this.listing,
  });
  final FavController favoritesController = Get.put(FavController());
  @override
  Widget build(BuildContext context) {
    controller.images.clear();
    listing.photos?.forEach((photo) {
      if (photo != "") {
        controller.images.add(photo);
      }
    });
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: EraTheme.paddingWidth, vertical: 11.h),
              child: EraText(
                text: 'Property Information'.toUpperCase(),
                color: AppColors.blue,
                fontSize: EraTheme.header - 2.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
              child: EraText(
                text: listing.name!,
                color: AppColors.kRedColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return EraText(
                      text: controller.price.value == ""
                          ? NumberFormat.currency(
                                  locale: 'en_PH', symbol: 'PHP ')
                              .format(listing.price)
                          : controller.price.value,
                      color: AppColors.black,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.bold,
                    );
                  }),
                  GestureDetector(
                    onTap: () {
                      if (controller.symbol == "PHP ") {
                        controller.symbol = "USD ";
                        controller.price.value = NumberFormat.currency(
                                locale: 'en_US', symbol: controller.symbol)
                            .format(listing.price! / settings!.exchangeRate!);
                      } else {
                        controller.symbol = "PHP ";
                        controller.price.value = NumberFormat.currency(
                                locale: 'en_PH', symbol: controller.symbol)
                            .format(listing.price!);
                      }
                    },
                    child: Image.asset(AppEraAssets.convertusd,
                        height: 50.h, width: 50.w),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            Obx(() {
              bool isFav = false;
              return SizedBox(
                height: 350.h,
                child: Stack(
                  children: [
                    Positioned(
                        child: SizedBox(
                      width: Get.width,
                      height: 320.h,
                      child: CloudStorage().imageLoader(
                        ref: controller.currentImage.value == ''
                            ? (controller.images.isNotEmpty
                                ? controller.images.first
                                : AppStrings.noUserImageWhite)
                            : controller.currentImage.value,
                      ),
                    )),
                    Positioned(
                      bottom: 0.h,
                      child: SizedBox(
                        width: Get.width,
                        height: 70.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.images.length,
                          itemBuilder: (context, index) {
                            final image = controller.images[index];
                            final isSelected =
                                controller.currentImage.value == image;

                            return GestureDetector(
                              onTap: () {
                                controller.onSelectedImage(image);
                                //   Get.to(() => FullScreenImageViewer(
                                //       imageUrl: image, initialIndex: index));
                              },
                              child: Container(
                                decoration: isSelected
                                    ? BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.hint,
                                          width: 5,
                                        ),
                                      )
                                    : null,
                                margin: EdgeInsets.symmetric(horizontal: 7.w),
                                child: CloudStorage().imageLoader(
                                  ref: controller.images[index],
                                  width: Get.width / 6,
                                  height: Get.height,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
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
                                  user!.addFavorites(listing.id);
                                  Get.showSnackbar(GetSnackBar(
                                    title: "Success",
                                    message:
                                        "${controller.isFav.value ? "Added" : "Removed"} to favorites",
                                    backgroundColor: AppColors.kRedColor,
                                    duration:
                                        Duration(milliseconds: 500, seconds: 1),
                                  ));
                                },
                                child: Icon(
                                  shadows: const [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, 0),
                                        blurRadius: 20)
                                  ],
                                  user!.favorites!.contains(listing.id)
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart_fill,
                                  color: user!.favorites!.contains(listing.id)
                                      ? AppColors.kRedColor
                                      : AppColors.white,
                                  size: 45.sp,
                                )),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              );
            }),

            //SizedBox(height: 0.h),
            //widget
            iconsText(),
            SizedBox(height: 20.h),
            allDescriptions(),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget allDescriptions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EraText(
            text: 'Description',
            color: AppColors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          EraText(
            text: listing.description ?? "",
            color: AppColors.black,
            fontSize: 14.sp,
            maxLines: 50,
          ),
          SizedBox(height: 20.h),
          eratexts('Listing ID# ', '${listing.id}'),
          eratexts(
              'Last Updated: ',
              DateFormat('MMMM dd, yyyy hh:mm aaa')
                  .format(listing.dateUpdated!)),
          eratexts('Added: ',
              "Added ${DateTime.now().difference(listing.dateCreated!).inDays.toString()} days ago"),
          //SizedBox(height: 20.h),

          SizedBox(height: 20.h),
          //widget location
          location(),
          SizedBox(height: 30.h),

          overviewSum(),
          SizedBox(height: 30.h),

//widget
          BoxWidget.BoxWidget2(
              AppColors.hint.withOpacity(0.3),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EraText(
                      text: 'PROPERTY PERFOMANCE',
                      fontSize: 20.sp,
                      color: AppColors.kRedColor,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        EraText(
                          text: 'Views: ',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 100.w),
                        EraText(
                          text: '${listing.views}',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        EraText(
                          text: 'Leads: ',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                        SizedBox(width: 100.w),
                        EraText(
                          text: '${listing.leads ?? 0}',
                          fontSize: 18.sp,
                          color: AppColors.black,
                        ),
                      ],
                    )
                  ],
                ),
              )),
          SizedBox(height: 20.h),
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
          SizedBox(height: 20.h),
          FutureBuilder(
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
          SizedBox(height: 10.h),
          /*
          ListedBy(
            text: 'Listed By',
            image: listing.user.image!,
            agentFirstName: listing.user.firstname!,
            agentLastName: listing.user.lastname!,
            agentType: listing.user.role!,
            whatsapp: listing.user.whatsApp,
            whatsappIcon: AppEraAssets.whatsappIcon,
            email: listing.user.email,
            emailIcon: AppEraAssets.emailIcon,
          ),
          */

          SizedBox(height: 20.h),
          // EraText(
          //   text: 'SIMILAR LISTINGS',
          //   color: AppColors.kRedColor,
          //   fontSize: 20.sp,
          //   fontWeight: FontWeight.bold,
          // ),
          // SizedBox(height: 10.h),

          //ListingProperties(listingModels: RealEstateListing.listingsModels),
          Button(
            text: 'MORE LISTINGS',
            onTap: () {
              Get.toNamed('/findproperties');
            },
            bgColor: AppColors.blue,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            width: Get.width,
            borderRadius: BorderRadius.circular(20),
          ),
        ],
      ),
    );
  }

  Widget location() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'Location',
          color: AppColors.kRedColor,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 15.h),
        EraText(
          text: 'Address',
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
        EraText(
          text: listing.address ?? "No Address Added",
          color: AppColors.black,
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        //temporary i dont know how to implemnt the location
        SizedBox(height: 10.h),
        SizedBox(
          width: Get.width,
          height: 250.h,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: LatLng(
                    listing.latLng != null
                        ? listing.latLng![0].toString().toDouble()
                        : 0,
                    listing.latLng != null
                        ? listing.latLng![1].toString().toDouble()
                        : 0),
                zoom: 13.0),
            markers: {
              Marker(
                  position: LatLng(
                      listing.latLng != null
                          ? listing.latLng![0].toString().toDouble()
                          : 0,
                      listing.latLng != null
                          ? listing.latLng![1].toString().toDouble()
                          : 0),
                  markerId: MarkerId('mainPin'),
                  icon: BitmapDescriptor.defaultMarker)
            },
          ),
        )
      ],
    );
  }

  Widget iconsText() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconsWidgets(
                AppEraAssets.money2,
                listing.ppsqm! >= 1000000
                    ? '${listing.ppsqm! / 1000000}M'
                    : listing.ppsqm! >= 1000
                        ? '${listing.ppsqm! / 1000}K'
                        : '${listing.ppsqm}'),
            iconsWidgets(AppEraAssets.area, '${listing.area} sqm'),
            iconsWidgets(AppEraAssets.bed, '${listing.beds}'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            iconsWidgets(AppEraAssets.tub, '${listing.baths}'),
            iconsWidgets(AppEraAssets.car, '${listing.cars}'),
            listing.view == "SUNRISE"
                ? iconsWidgets(AppEraAssets.sunrise, '${listing.view}')
                : Opacity(
                    opacity: 0,
                    child:
                        iconsWidgets(AppEraAssets.sunrise, '${listing.view}'),
                  ),
          ],
        ),
      ],
    );
  }

  Widget overviewSum() {
    return BoxWidget.BoxWidget2(
      AppColors.white,
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EraText(
              text: 'OVERVIEW SUMMARY',
              color: AppColors.kRedColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 5.h),
            shorterSummary('Property ID', '${listing.id}'),
            shorterSummary(
                'Price',
                NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                    .format(listing.price)),
            shorterSummary(
                'Price per sqm',
                listing.ppsqm! >= 1000000
                    ? '${listing.ppsqm! / 1000000}M'
                    : listing.ppsqm! >= 1000
                        ? '${listing.ppsqm! / 1000}K'
                        : '${listing.ppsqm}'),
            shorterSummary('Beds', '${listing.beds}'),
            shorterSummary('Baths', '${listing.baths}'),
            shorterSummary('Garage', '${listing.cars}'),
            shorterSummary('Area', '${listing.area} sqm'),
            //shorterSummary('Offer Type', listing.type),
            shorterSummary('View', listing.view ?? "None"),
            shorterSummary(
                'Location', (listing.location ?? "").toString().capitalize),
            shorterSummary('Type', listing.type),
            shorterSummary('Sub Category', listing.subCategory),
          ],
        ),
      ),
    );
  }

  Widget featuresWidgets(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: title,
          color: AppColors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: EraText(
            text: text,
            color: AppColors.black,
            fontSize: 15.sp,
            maxLines: 50,
          ),
        ),
      ],
    );
  }

  Widget iconsWidgets(String image, String text) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 80.h,
          width: 80.w,
        ),
        EraText(
          text: text,
          color: AppColors.black,
          fontWeight: FontWeight.w700,
          fontSize: 15.sp,
        ),
      ],
    );
  }

  Widget shorterSummary(String text, text2) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      child: Row(
        children: [
          Expanded(
            child: EraText(
              text: text,
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ),
          Expanded(
            child: EraText(
              textOverflow: TextOverflow.ellipsis,
              text: text2.toString(),
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget eratexts(String text, text2) {
    return Row(
      children: [
        EraText(
          text: text,
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
        EraText(
          text: text2,
          color: AppColors.black,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
