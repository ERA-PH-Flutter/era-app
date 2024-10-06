import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_controller.dart';
import 'package:eraphilippines/presentation/admin/properties/controllers/listingsAdmin_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../app/constants/colors.dart';
import '../../../../app/constants/sized_box.dart';
import '../../../../app/constants/theme.dart';
import '../../../../app/widgets/button.dart';
import '../../../agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import '../controllers/listing_admin_controller.dart';

class PropertyInformationAdmin extends GetView<ListingsAdminController> {
  const PropertyInformationAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    ListingsAdminController controller = Get.put(ListingsAdminController());
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: EraTheme.paddingWidthAdmin - 5.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sb20(),
            EraText(
              text: 'PROPERTY INFORMATION',
              color: AppColors.black,
              fontSize: EraTheme.header,
              fontWeight: FontWeight.w400,
            ),
            sb25(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                    text: controller.listing?.name?.toUpperCase() ??
                        "No property information",
                    color: AppColors.kRedColor,
                    fontSize: EraTheme.header + 2.sp,
                    fontWeight: FontWeight.w600),
                sb20(),
                Obx(() {
                  return EraText(
                    text: controller.price.value == ""
                        ? NumberFormat.currency(locale: 'en_PH', symbol: 'PHP ')
                            .format(controller.listing?.price)
                        : controller.price.value,
                    color: AppColors.black,
                    fontSize: EraTheme.header + 5.sp,
                    fontWeight: FontWeight.bold,
                  );
                }),
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
                      Container(
                        width: Get.width,
                        height: Get.height,
                        child: CloudStorage().imageLoader(
                            ref: controller.listing!.photos!.isNotEmpty
                                ? controller.listing!.photos!.first
                                : AppStrings.noUserImageWhite),
                      ),
                      Positioned(
                        bottom: -10.h,
                        child: Container(
                          height: 250.h,
                          color: AppColors.kRedColor,
                          width: Get.width,
                          padding: EdgeInsets.all(EraTheme.paddingWidthSmall),
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Container(
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
                                      ref: controller
                                              .listing!.photos!.isNotEmpty
                                          ? controller.listing!.photos![index]
                                          : AppStrings.noUserImageWhite),
                                );
                              },
                              itemCount: controller.listing!.photos!.length),
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
                            text: controller.listing?.description ?? '',
                            color: AppColors.black,
                            fontSize: EraTheme.paragraph,
                            fontWeight: FontWeight.w400,
                            maxLines: 19,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: EraTheme.paddingWidth),
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: EraTheme.paddingWidth),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5.h),
                                        shorterSummary(
                                          text: 'Property ID:',
                                          text2:
                                              '${controller.listing?.propertyId}',
                                        ),
                                        shorterSummary(
                                          text: 'Price',
                                          text2: NumberFormat.currency(
                                                  locale: 'en_PH',
                                                  symbol: 'PHP ')
                                              .format(
                                                  controller.listing?.price),
                                        ),
                                        shorterSummary(
                                          text: 'Price per sqm',
                                          text2: NumberFormat.currency(
                                                  locale: 'en_PH',
                                                  symbol: 'PHP ')
                                              .format(
                                                  controller.listing?.ppsqm),
                                        ),
                                        shorterSummary(
                                          text: 'Beds',
                                          text2: controller.listing?.beds
                                                  .toString() ??
                                              "",
                                        ),
                                        shorterSummary(
                                          text: 'Baths',
                                          text2: controller.listing?.baths
                                                  .toString() ??
                                              "",
                                        ),
                                        shorterSummary(
                                          text: 'Garage',
                                          text2: controller.listing?.cars
                                                  .toString() ??
                                              "",
                                        ),
                                        shorterSummary(
                                          text: 'Area',
                                          text2: controller.listing?.area
                                                  .toString() ??
                                              "",
                                        ),
                                        shorterSummary(
                                          text: 'View',
                                          text2: controller.listing?.view ??
                                              "No view",
                                        ),
                                        shorterSummary(
                                          text: 'Location',
                                          text2: controller.listing?.location
                                                  ?.capitalize ??
                                              '',
                                        ),
                                        shorterSummary(
                                          text: 'Type',
                                          text2: controller.listing?.type ?? "",
                                        ),
                                        shorterSummary(
                                          text: 'Sub Category',
                                          text2:
                                              controller.listing?.subCategory ??
                                                  "",
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
                                    padding: EdgeInsets.symmetric(
                                        horizontal: EraTheme.paddingWidth),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 5.h),
                                        shorterSummary(
                                          text: 'Views',
                                          text2: controller.listing?.views
                                                  .toString() ??
                                              "",
                                        ),
                                        shorterSummary(
                                          text: 'Leads',
                                          text2: controller.listing?.leads
                                                  .toString() ??
                                              "",
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
                              width: 600.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  shorterSummary(
                                      color: AppColors.blue,
                                      text: 'Last Updated: ',
                                      text2:
                                          '${controller.listing?.dateUpdated}'),
                                  shorterSummary(
                                      color: AppColors.blue,
                                      text: 'Added: ',
                                      text2:
                                          '${DateTime.now().difference(controller.listing!.dateCreated ?? DateTime.now()).inDays} days ago'),
                                ],
                              ),
                            ),
                            sb30(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                //button

                Padding(
                  padding: EdgeInsets.all(8.sp),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Button(
                      onTap: () async {
                        Get.put(ListingsController());
                        var c = Get.find<AddListingsController>();
                        await c.assignData(controller.listing!.id, isWeb: true);
                        // c.propertyNameController.text =  controller.listing!.name!;
                        // c.propertyCostController.text =  controller.listing!.price!.toString();
                        // c.pricePerSqmController.text =  controller.listing!.ppsqm!.toString();
                        // c.areaController.text =  controller.listing!.area!.toString();
                        // c.bedsController.text =  controller.listing!.beds!.toString();
                        // c.bathsController.text =  controller.listing!.baths!.toString();
                        // c.selectedPropertyT.value =  controller.listing!.type!;
                        // c.selectedOfferT.value =  controller.listing!.status!;
                        // c.selectedView.value =  controller.listing!.view!;
                        // c.selectedPropertySubCategory.value =  controller.listing!.subCategory!;
                        // c.carsController.text = controller.listing!.cars.toString();
                        // //c.propertyNameController.text = listing!.name!;
                        // c.descController.text = controller.listing!.description!;
                        Get.find<LandingPageController>().onSectionSelected(8);
                      },
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 150.w,
                      text: 'EDIT',
                      bgColor: AppColors.blue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    Button(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: 150.w,
                      text: 'DELETE',
                      bgColor: AppColors.hint,
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        BaseController().showSuccessDialog(
                            title: "Confirm",
                            description: "Do you want to delete this listing?",
                            hitApi: () async {
                              BaseController().showLoading();
                              await Listing()
                                  .deleteListingsById(controller.listing!.id);
                              BaseController().hideLoading();
                              // controller.agentListingsState.value =
                              //     AgentListingsState.loading;
                              Get.back();
                              //        await controller.loadListing();
                            },
                            cancelable: true);
                      },
                    ),
                  ]),
                ),
              ],
            ),
            //  propertyInfo(listingModels: RealEstateListing.listingsModels),
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
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              lineHeight: 0.9,
            ),
          ),
          Expanded(
            child: EraText(
              text: text2,
              color: AppColors.black,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              lineHeight: 0.9,
            ),
          ),
        ],
      ),
    );
  }
}
