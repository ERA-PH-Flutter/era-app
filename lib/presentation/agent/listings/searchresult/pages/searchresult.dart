import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../../../../app/constants/screens.dart';
import '../../../../../app/widgets/filteredsearch_box.dart';
import '../../../../../app/widgets/listings/listedBy_widget.dart';
import '../../../../../repository/listing.dart';
import '../../../../../repository/user.dart';

import '../controllers/searchresult_controller.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              EraText(
                text: "Property searches made simple.",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10.h,
              ),
              FilteredSearchBox(),
              SizedBox(height: 10.h),
              Obx(() {
                return controller.quickLinks.value;
              }),
              Obx((){
                return switch (controller.searchResultState.value) {
                  SearchResultState.loading => Screens.loading(height: 500.h),
                  SearchResultState.loaded => _loaded(),
                  SearchResultState.empty => _empty(),
                  SearchResultState.searching => _searching(),
                  SearchResultState.error => _error(),
                };
              }),
            ],
          ),
        ),
      ),
    );
  }

  _searching() {
    return Container();
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Obx(() {
            if (controller.searchQuery.value == "") {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Showcased Listings',
                    fontSize: 23.sp,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.w800,
                  ),
                  EraText(
                    text: 'Explore Our Top Picks',
                    fontSize: 17.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Here\'s what I found for you!',
                    fontSize: 23.sp,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            }
          }),
          SizedBox(height: 10.h),
          Obx((){
            controller.count.value;
            return LoadMore(
              length: (controller.data.length / controller.pageSize).floor(),
              child:  ListView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.data.length,
                itemBuilder: (context, index) {
                  if (controller.data[index] != null) {
                    if(index >= controller.count.value - controller.pageSize && index < controller.count.value){
                      Listing listing = Listing.fromJSON(controller.data[index]);
                      return GestureDetector(
                        onTap: () async {
                          // await Database().addViews(listing.id);
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
                                    height: 300.h,
                                    width: Get.width,
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
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: EraText(
                                  textOverflow: TextOverflow.ellipsis,
                                  text:
                                  listing.name! == "" ? "No Name" : listing.name!,
                                  fontSize: EraTheme.header - 5.sp,
                                  color: AppColors.kRedColor,
                                  fontWeight: FontWeight.bold,
                                  lineHeight: 2,
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
                                        text:
                                        '${listing.area!.toStringAsFixed(listing.area!.truncateToDouble() == listing.area ? 0 : 1)} sqm',
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
                                  listing.description ?? "No description.",
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
                  }
                  return Container();
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  _error() {
    return EraText(
      text: "ERROR",
      color: Colors.black,
    );
  }

  _empty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EraText(
          text: 'No results found!',
          fontSize: 23.sp,
          color: AppColors.blue,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  LoadMore({
    child,
    length,
  }){
    return Column(
      children: [
        child,
        NumberPagination(
          fontSize: 18.sp,
          buttonRadius:10.r,
          controlButtonSize: Size(30 ,30),
          numberButtonSize: Size(35, 35),
          sectionSpacing:1.w,
          betweenNumberButtonSpacing: 1,
          totalPages: length,
          currentPage: (controller.count.value / controller.pageSize).floor(),
          visiblePagesCount: length < 3 ? length : 3,
          onPageChanged: (page){
            controller.count.value = controller.pageSize * page;
          },
        ),
        SizedBox(height: 100.h),
      ],
    );
  }
}
