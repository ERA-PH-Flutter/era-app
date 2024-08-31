import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/gridView_AllListings.dart';
import 'package:eraphilippines/app/widgets/agent_All_Listings/listview_agent_allListings.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/button.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:eraphilippines/presentation/agent/agents/controllers/agents_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../app/constants/assets.dart';
import '../../../../app/services/firebase_database.dart';
import '../controllers/agent_listings_controller.dart';
import 'agentsDashBoard.dart';

class AgentsMyListing extends GetView<AgentListingsController> {
  final String? by;

  const AgentsMyListing({super.key, this.by});

  @override
  Widget build(BuildContext context) {
    print(controller.user);
    return BaseScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Filter and sort row for the specific listing
            Obx(() => switch (controller.agentListingsState.value) {
                  AgentListingsState.loading => _loading(),
                  AgentListingsState.loaded => _loaded(),
                  AgentListingsState.empty => _empty(),
                  AgentListingsState.error => _error(),
                })
          ],
        ),
      ),
    );
  }

  _loaded() {
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
          SizedBox(
            height: 10.h,
          ),
          //   GridviewAlllistings(listingModels:controller.listings),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.listings.length,
            itemBuilder: (context, index) {
              Listing listing = controller.listings[index];
              return Stack(
                children: [

                  GestureDetector(
                    onTap: ()async{
                      await Database().addViews(listing.id);
                      Get.toNamed('/propertyInfo', arguments: listing);
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
                              ref: listing.photos != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos!.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                              width: Get.width,
                              height: 300.h,
                            ),
                          ),
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
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Button.button3((Get.width - 90.w) / 2, 40.h, () {
                                  Get.toNamed('/editListings',
                                      arguments: [listing.id]);
                                }, 'Edit', AppColors.blue,fontSize: 18.sp),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Button.button3((Get.width - 90.w) / 2, 43.h, () {
                                  print(controller.listings[index].id);
                                  BaseController().showSuccessDialog(
                                      title: "Confirm",
                                      description:
                                          "Do you want to delete this listing?",
                                      hitApi: () async {
                                        BaseController().showLoading();
                                        await Listing()
                                            .deleteListingsById(listing.id);
                                        BaseController().hideLoading();
                                        controller.agentListingsState.value = AgentListingsState.loading;
                                        Get.back();
                                        await controller.loadListing();

                                      },
                                      cancelable: true);
                                }, 'Delete', AppColors.kRedColor,fontSize: 18.sp),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
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
                    top: 10.h,
                    right: 10.w,
                    child: Visibility(
                      visible: !(listing.isSold ?? false),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(99.r),
                          color:Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white38,
                              offset: Offset(1,1),
                              spreadRadius: 1,
                              blurRadius: 5
                            )
                          ]
                        ),
                        child: Button.button3(
                          140.w,
                          35.h,
                          ()async{
                            await Database().listingMarkAsSold(listing.id);
                            controller.agentListingsState.value = AgentListingsState.loading;
                            await controller.loadListing();
                            Get.showSnackbar(GetSnackBar(
                              title: "Success",
                              message: "Listing has been mark as sold!",
                              backgroundColor: AppColors.kRedColor,
                              duration: Duration(seconds: 1,milliseconds: 500),
                            ));
                          },
                          'Mark as Sold',
                          AppColors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp
                        ),
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
    return Container(
      height: Get.height - 225.h,
      width:Get.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EraText(
              text: "You dont have any listings!",
              color: Colors.black,
              fontSize: 16.sp,
            ),
            SizedBox(height: 10.h,),
            GestureDetector(
              onTap: (){
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
    return SizedBox(
      height: Get.height -200.h,
      child: Center(
        child: CircularProgressIndicator(),
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
}
