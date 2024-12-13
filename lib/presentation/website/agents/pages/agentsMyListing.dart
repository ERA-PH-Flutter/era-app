import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/constants/assets.dart';
import '../../../../app/constants/screens.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../../app/widgets/custom_appbar.dart';
import '../controllers/agent_myListingWeb_controller.dart';

class AgentsMyListingWeb extends GetView<AgentListingsWebController> {
  final String? by;

  const AgentsMyListingWeb({super.key, this.by});

  @override
  Widget build(BuildContext context) {
    Get.put(AgentListingsWebController());
    print(controller.user);
    return SingleChildScrollView(
      child: Padding(
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
                EraText(
                  text: "MY LISTINGS",
                  fontSize: EraTheme.header,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                ),
                //TO DO: nikko not final this is for sorting
                CustomSortPopup(
                  title: 'Sort by',
                  onSelected: (String result) {
                    print(result);
                  },
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
                          controller.listings.sort((a, b) =>
                              a.dateCreated!.compareTo(b.dateCreated!));
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
                          controller.listings.sort(
                              (a, b) => a.location!.compareTo(b.location!));
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
            /*
                Row(
       children: [
         Image.network(
           '${controller.user.image == null || controller.user.image == "" ? AppStrings.noUserImageWhite : controller.user.image}',
           width: 100.w,
           height: 110.h,
         ),
         Padding(
           padding: EdgeInsets.only(top: 10.w, left: 10.w),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               AgentDashBoard.agentText(
                   '${controller.user.firstname} ${controller.user.lastname}',
                   AppColors.blue,
                   18.sp,
                   FontWeight.bold,
                   1.2),
               AgentDashBoard.agentText('${controller.user.role ?? 'Agent'}',
                   AppColors.black, 12.sp, FontWeight.w400, 0.9),
               AgentDashBoard.agentContact(
                   AppEraAssets.whatsappIcon, '${controller.user.whatsApp}'),
               AgentDashBoard.agentContact(
                   AppEraAssets.emailIcon, '${controller.user.email}'),
             ],
           ),
         ),
       ],
                ),
                */
            //sb10(),
            //    GridView.builder(
            //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 3,
            //     mainAxisExtent: Get.height - 180.h,
            //   ),
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: controller.data.length,
            //   itemBuilder: (context, index) {
            //     if (controller.data[index] != null) {
            //       Listing listing = Listing.fromJSON(controller.data[index]);
            //       return GestureDetector(
            //         onTap: () async {
            //           // await Database().addViews(listing.id);
            //           // Get.toNamed('/propertyInfo', arguments: listing);
            //           listingArgument = listing;
            //           selectedIndex.value = 12;
            //           Get.find<HomsController>().onNavbarItemSelected(12);
            //         },
            //         child: Container(
            //           margin: EdgeInsets.only(
            //             bottom: 16.h,
            //             right: 20.w,
            //           ),
            //           padding: EdgeInsets.zero,
            //           decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(10.r),
            //               boxShadow: const [
            //                 BoxShadow(
            //                     offset: Offset(0, 0),
            //                     spreadRadius: 1,
            //                     blurRadius: 10,
            //                     color: Colors.black12)
            //               ]),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               ClipRRect(
            //                   borderRadius: BorderRadius.circular(10.r),
            //                   child: CloudStorage().imageLoader(
            //                     height: 350.h,
            //                     width: Get.width,
            //                     fit: BoxFit.cover,
            //                     reference: listing.photos != null
            //                         ? (listing.photos!.isNotEmpty
            //                             ? listing.photos!.first
            //                             : AppStrings.noUserImageWhite)
            //                         : AppStrings.noUserImageWhite,
            //                   )),
            //               SizedBox(
            //                 height: 17.h,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
            //                 child: EraText(
            //                   text:
            //                       listing.name! == "" ? "No Name" : listing.name!,
            //                   fontSize: EraTheme.subHeader,
            //                   color: AppColors.kRedColor,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
            //                 child: EraText(
            //                   text: listing.type!,
            //                   fontSize: EraTheme.paragraph,
            //                   color: AppColors.black,
            //                   fontWeight: FontWeight.bold,
            //                   lineHeight: 1,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 5.h,
            //               ),
            //               Row(
            //                 //crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Row(
            //                     children: [
            //                       Image.asset(
            //                         AppEraAssets.area,
            //                         width: 55.w,
            //                         height: 55.w,
            //                       ),
            //                       SizedBox(width: 2.w),
            //                       EraText(
            //                         text: '${listing.floorArea} sqm',
            //                         fontSize: EraTheme.paragraph - 1.sp,
            //                         fontWeight: FontWeight.w500,
            //                         color: AppColors.black,
            //                       ),
            //                     ],
            //                   ),
            //                   SizedBox(width: 10.w),
            //                   Image.asset(
            //                     AppEraAssets.bed,
            //                     width: 55.w,
            //                     height: 55.w,
            //                   ),
            //                   EraText(
            //                     text: '${listing.beds}',
            //                     fontSize: EraTheme.paragraph - 1.sp,
            //                     fontWeight: FontWeight.w500,
            //                     color: AppColors.black,
            //                   ),
            //                   SizedBox(width: 10.w),
            //                   Image.asset(
            //                     AppEraAssets.tub,
            //                     width: 55.w,
            //                     height: 55.w,
            //                   ),
            //                   EraText(
            //                     text: '${listing.baths}',
            //                     fontSize: EraTheme.paragraph - 1.sp,
            //                     fontWeight: FontWeight.w500,
            //                     color: AppColors.black,
            //                   ),
            //                   SizedBox(width: 10.w),
            //                   Image.asset(
            //                     AppEraAssets.car,
            //                     width: 55.w,
            //                     height: 55.w,
            //                   ),
            //                   EraText(
            //                     text: '${listing.cars}',
            //                     fontSize: EraTheme.paragraph - 1.sp,
            //                     fontWeight: FontWeight.w500,
            //                     color: AppColors.black,
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 5.h,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
            //                 child: EraText(
            //                   text: 'Description:',
            //                   fontSize: EraTheme.header - 8.sp,
            //                   color: AppColors.black,
            //                   fontWeight: FontWeight.w600,
            //                   lineHeight: 1,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 2.h,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
            //                 child: Text(
            //                   listing.description ?? "No description.",
            //                   style: TextStyle(
            //                     fontSize: EraTheme.paragraph - 4.sp,
            //                     fontWeight: FontWeight.w500,
            //                     color: AppColors.black,
            //                   ),
            //                   maxLines: 5,
            //                   overflow: TextOverflow.ellipsis,
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 5.h,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
            //                 child: EraText(
            //                   text: NumberFormat.currency(
            //                           locale: 'en_PH', symbol: 'PHP ')
            //                       .format(
            //                     listing.price.toString() == ""
            //                         ? 0
            //                         : listing.price,
            //                   ),
            //                   color: AppColors.blue,
            //                   fontSize: EraTheme.header,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //               FutureBuilder(
            //                   future: EraUser().getById(listing.by),
            //                   builder: (context, snapshot) {
            //                     if (snapshot.hasData) {
            //                       var user1 = snapshot.data;
            //                       return Padding(
            //                         padding:
            //                             EdgeInsets.symmetric(horizontal: 14.w),
            //                         child: ListedBy(
            //                             image: user1!.image ??
            //                                 AppStrings.noUserImageWhite,
            //                             agentFirstName:
            //                                 user1.firstname ?? "No Name",
            //                             agentType: user1.role ?? "Agent",
            //                             agentLastName: user1.lastname ?? ""),
            //                       );
            //                     } else {
            //                       return Center(
            //                         child: CircularProgressIndicator(),
            //                       );
            //                     }
            //                   }),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                   children: [
            //                     Expanded(
            //                       flex: 1,
            //                       child: Button.button3(
            //                           height: EraTheme.buttonH60,
            //                           onTap: () {
            //                             Get.toNamed('/editListings',
            //                                 arguments: [listing.id]);
            //                           },
            //                           text: 'Edit',
            //                           color: AppColors.blue,
            //                           fontSize: 18.sp),
            //                     ),
            //                     SizedBox(
            //                       width: 5.w,
            //                     ),
            //                     Expanded(
            //                       flex: 1,
            //                       child: Button.button3(
            //                           height: EraTheme.buttonH60,
            //                           onTap: () {
            //                             BaseController().showSuccessDialog(
            //                                 title: "Confirm",
            //                                 description:
            //                                     "Do you want to delete this listing?",
            //                                 hitApi: () async {
            //                                   BaseController().showLoading();
            //                                   await CloudStorage().deleteAll(
            //                                       fileList: listing.photos!);
            //                                   await Listing()
            //                                       .deleteListingsById(listing.id);
            //                                   BaseController().hideLoading();
            //                                   // controller.agentListingsState.value =
            //                                   //     AgentListingsState.loading;
            //                                   Get.back();
            //                                   //     await controller.loadListing();
            //                                 },
            //                                 cancelable: true);
            //                           },
            //                           text: 'Delete',
            //                           color: AppColors.kRedColor,
            //                           fontSize: 18.sp),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 20.h,
            //               ),
            //               sb50(),
            //             ],
            //           ),
            //         ),
            //       );
            //     }
            //     return Container();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  _loaded() {
    //controller.user = agentArgument ?? controller.user;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EraText(
                text: "MY LISTINGS",
                fontSize: EraTheme.header,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
              ),
              //TO DO: nikko not final this is for sorting
              CustomSortPopup(
                title: 'Sort by',
                onSelected: (String result) {
                  print(result);
                },
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
          /*
          Row(
            children: [
              Image.network(
                '${controller.user.image == null || controller.user.image == "" ? AppStrings.noUserImageWhite : controller.user.image}',
                width: 100.w,
                height: 110.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.w, left: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AgentDashBoard.agentText(
                        '${controller.user.firstname} ${controller.user.lastname}',
                        AppColors.blue,
                        18.sp,
                        FontWeight.bold,
                        1.2),
                    AgentDashBoard.agentText('${controller.user.role ?? 'Agent'}',
                        AppColors.black, 12.sp, FontWeight.w400, 0.9),
                    AgentDashBoard.agentContact(
                        AppEraAssets.whatsappIcon, '${controller.user.whatsApp}'),
                    AgentDashBoard.agentContact(
                        AppEraAssets.emailIcon, '${controller.user.email}'),
                  ],
                ),
              ),
            ],
          ),
          */
          //sb10(),
          //    GridView.builder(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 3,
          //     mainAxisExtent: Get.height - 180.h,
          //   ),
          //   physics: const NeverScrollableScrollPhysics(),
          //   shrinkWrap: true,
          //   itemCount: controller.data.length,
          //   itemBuilder: (context, index) {
          //     if (controller.data[index] != null) {
          //       Listing listing = Listing.fromJSON(controller.data[index]);
          //       return GestureDetector(
          //         onTap: () async {
          //           // await Database().addViews(listing.id);
          //           // Get.toNamed('/propertyInfo', arguments: listing);
          //           listingArgument = listing;
          //           selectedIndex.value = 12;
          //           Get.find<HomsController>().onNavbarItemSelected(12);
          //         },
          //         child: Container(
          //           margin: EdgeInsets.only(
          //             bottom: 16.h,
          //             right: 20.w,
          //           ),
          //           padding: EdgeInsets.zero,
          //           decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(10.r),
          //               boxShadow: const [
          //                 BoxShadow(
          //                     offset: Offset(0, 0),
          //                     spreadRadius: 1,
          //                     blurRadius: 10,
          //                     color: Colors.black12)
          //               ]),
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               ClipRRect(
          //                   borderRadius: BorderRadius.circular(10.r),
          //                   child: CloudStorage().imageLoader(
          //                     height: 350.h,
          //                     width: Get.width,
          //                     fit: BoxFit.cover,
          //                     reference: listing.photos != null
          //                         ? (listing.photos!.isNotEmpty
          //                             ? listing.photos!.first
          //                             : AppStrings.noUserImageWhite)
          //                         : AppStrings.noUserImageWhite,
          //                   )),
          //               SizedBox(
          //                 height: 17.h,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
          //                 child: EraText(
          //                   text:
          //                       listing.name! == "" ? "No Name" : listing.name!,
          //                   fontSize: EraTheme.subHeader,
          //                   color: AppColors.kRedColor,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
          //                 child: EraText(
          //                   text: listing.type!,
          //                   fontSize: EraTheme.paragraph,
          //                   color: AppColors.black,
          //                   fontWeight: FontWeight.bold,
          //                   lineHeight: 1,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 5.h,
          //               ),
          //               Row(
          //                 //crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Row(
          //                     children: [
          //                       Image.asset(
          //                         AppEraAssets.area,
          //                         width: 55.w,
          //                         height: 55.w,
          //                       ),
          //                       SizedBox(width: 2.w),
          //                       EraText(
          //                         text: '${listing.floorArea} sqm',
          //                         fontSize: EraTheme.paragraph - 1.sp,
          //                         fontWeight: FontWeight.w500,
          //                         color: AppColors.black,
          //                       ),
          //                     ],
          //                   ),
          //                   SizedBox(width: 10.w),
          //                   Image.asset(
          //                     AppEraAssets.bed,
          //                     width: 55.w,
          //                     height: 55.w,
          //                   ),
          //                   EraText(
          //                     text: '${listing.beds}',
          //                     fontSize: EraTheme.paragraph - 1.sp,
          //                     fontWeight: FontWeight.w500,
          //                     color: AppColors.black,
          //                   ),
          //                   SizedBox(width: 10.w),
          //                   Image.asset(
          //                     AppEraAssets.tub,
          //                     width: 55.w,
          //                     height: 55.w,
          //                   ),
          //                   EraText(
          //                     text: '${listing.baths}',
          //                     fontSize: EraTheme.paragraph - 1.sp,
          //                     fontWeight: FontWeight.w500,
          //                     color: AppColors.black,
          //                   ),
          //                   SizedBox(width: 10.w),
          //                   Image.asset(
          //                     AppEraAssets.car,
          //                     width: 55.w,
          //                     height: 55.w,
          //                   ),
          //                   EraText(
          //                     text: '${listing.cars}',
          //                     fontSize: EraTheme.paragraph - 1.sp,
          //                     fontWeight: FontWeight.w500,
          //                     color: AppColors.black,
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 5.h,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
          //                 child: EraText(
          //                   text: 'Description:',
          //                   fontSize: EraTheme.header - 8.sp,
          //                   color: AppColors.black,
          //                   fontWeight: FontWeight.w600,
          //                   lineHeight: 1,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 2.h,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
          //                 child: Text(
          //                   listing.description ?? "No description.",
          //                   style: TextStyle(
          //                     fontSize: EraTheme.paragraph - 4.sp,
          //                     fontWeight: FontWeight.w500,
          //                     color: AppColors.black,
          //                   ),
          //                   maxLines: 5,
          //                   overflow: TextOverflow.ellipsis,
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 5.h,
          //               ),
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
          //                 child: EraText(
          //                   text: NumberFormat.currency(
          //                           locale: 'en_PH', symbol: 'PHP ')
          //                       .format(
          //                     listing.price.toString() == ""
          //                         ? 0
          //                         : listing.price,
          //                   ),
          //                   color: AppColors.blue,
          //                   fontSize: EraTheme.header,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               FutureBuilder(
          //                   future: EraUser().getById(listing.by),
          //                   builder: (context, snapshot) {
          //                     if (snapshot.hasData) {
          //                       var user1 = snapshot.data;
          //                       return Padding(
          //                         padding:
          //                             EdgeInsets.symmetric(horizontal: 14.w),
          //                         child: ListedBy(
          //                             image: user1!.image ??
          //                                 AppStrings.noUserImageWhite,
          //                             agentFirstName:
          //                                 user1.firstname ?? "No Name",
          //                             agentType: user1.role ?? "Agent",
          //                             agentLastName: user1.lastname ?? ""),
          //                       );
          //                     } else {
          //                       return Center(
          //                         child: CircularProgressIndicator(),
          //                       );
          //                     }
          //                   }),
          //               Padding(
          //                 padding: EdgeInsets.symmetric(horizontal: 14.w),
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Expanded(
          //                       flex: 1,
          //                       child: Button.button3(
          //                           height: EraTheme.buttonH60,
          //                           onTap: () {
          //                             Get.toNamed('/editListings',
          //                                 arguments: [listing.id]);
          //                           },
          //                           text: 'Edit',
          //                           color: AppColors.blue,
          //                           fontSize: 18.sp),
          //                     ),
          //                     SizedBox(
          //                       width: 5.w,
          //                     ),
          //                     Expanded(
          //                       flex: 1,
          //                       child: Button.button3(
          //                           height: EraTheme.buttonH60,
          //                           onTap: () {
          //                             BaseController().showSuccessDialog(
          //                                 title: "Confirm",
          //                                 description:
          //                                     "Do you want to delete this listing?",
          //                                 hitApi: () async {
          //                                   BaseController().showLoading();
          //                                   await CloudStorage().deleteAll(
          //                                       fileList: listing.photos!);
          //                                   await Listing()
          //                                       .deleteListingsById(listing.id);
          //                                   BaseController().hideLoading();
          //                                   // controller.agentListingsState.value =
          //                                   //     AgentListingsState.loading;
          //                                   Get.back();
          //                                   //     await controller.loadListing();
          //                                 },
          //                                 cancelable: true);
          //                           },
          //                           text: 'Delete',
          //                           color: AppColors.kRedColor,
          //                           fontSize: 18.sp),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               SizedBox(
          //                 height: 20.h,
          //               ),
          //               sb50(),
          //             ],
          //           ),
          //         ),
          //       );
          //     }
          //     return Container();
          //   },
          // ),
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
    return Center(
      child: EraText(
        text: "Something went Wrong!sss",
        color: Colors.black,
      ),
    );
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
