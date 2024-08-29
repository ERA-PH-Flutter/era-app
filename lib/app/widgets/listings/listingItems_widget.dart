import 'package:cached_network_image/cached_network_image.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../constants/assets.dart';
import '../../widgets/app_text.dart';
import '../../widgets/custom_corner_image.dart';
import '../../widgets/listings/listedBy_widget.dart';

class ListingItemss extends StatelessWidget {
  final String? image;
  final String type;
  final int areas;
  final int beds;
  final int baths;
  final int cars;
  final String? by;
  final String description;
  final double price;
  final String? listedBy;
  final String? agentImage;
  final String? agentFirstName;
  final String? agentLastName;
  final String? role;
  final String? agent;
  final Widget? buttonEdit;
  final Widget? buttonDelete;
  final String? id;
  final Function()? onTap;
  final bool showListedby;
  final bool isSold; // New parameter to indicate if the listing is sold
  bool fromSold = false;
  final Widget? buttonSold;

  ListingItemss({
    super.key,
    this.onTap,
    this.image,
    required this.type,
    required this.areas,
    required this.beds,
    required this.baths,
    required this.cars,
    required this.description,
    required this.price,
    this.by,
    this.listedBy,
    this.agentImage,
    this.agentFirstName,
    this.agentLastName,
    this.role,
    this.buttonEdit,
    this.buttonDelete,
    required this.showListedby,
    this.id,
    required this.isSold,
    this.agent,
    required this.fromSold,
    this.buttonSold,
  });

  var selected = false.obs;

  void toggleSelected() {
    selected.value = !selected.value;
  }

  @override
  Widget build(BuildContext context) {
    return fromSold
        ? Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 7,
            child: GestureDetector(
              onTap: onTap,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        //  onTap: toggleSelected,
                        child: Container(
                          width: Get.width,
                          height: 195.h,
                          // duration: Duration(milliseconds: 300),
                          // curve: Curves.easeIn,
                          // height: selected.value ? 170.h : 200.h,
                          // width: Get.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  image ?? AppStrings.noUserImageWhite),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: EraTheme.paddingWidth, vertical: 5.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 15.h),
                            EraText(
                              text: type,
                              fontSize: 20.sp,
                              color: AppColors.kRedColor,
                              fontWeight: FontWeight.bold,
                              lineHeight: 0.4,
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      AppEraAssets.area,
                                      width: 50.w,
                                      height: 50.w,
                                    ),
                                    SizedBox(width: 2.w),
                                    EraText(
                                      text: '$areas sqm',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.black,
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  AppEraAssets.bed,
                                  width: 50.w,
                                  height: 50.w,
                                ),
                                EraText(
                                  text: '$beds',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                Image.asset(
                                  AppEraAssets.tub,
                                  width: 50.w,
                                  height: 50.w,
                                ),
                                EraText(
                                  text: '$baths',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                                Image.asset(
                                  AppEraAssets.car,
                                  width: 50.w,
                                  height: 50.w,
                                ),
                                EraText(
                                  text: '$cars',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              constraints: BoxConstraints(maxHeight: 100.h),
                              child: EraText(
                                text: 'Description:',
                                fontSize: 18.sp,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600,
                                lineHeight: 1,
                              ),
                            ),
                            EraText(
                              text: description == ""
                                  ? "No Description Added"
                                  : description,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                              maxLines: 3,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h),
                            EraText(
                              text: NumberFormat.currency(
                                locale: 'en_PH',
                                symbol: 'PHP ',
                              ).format(price),
                              color: AppColors.blue,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5.h),
                            if (showListedby)
                              FutureBuilder(
                                  future: EraUser().getById(agent),
                                  builder: (context,
                                      AsyncSnapshot<EraUser> snapshot) {
                                    if (snapshot.hasData) {
                                      print(snapshot.data!.firstname);
                                      return ListedBy(
                                        text: listedBy ?? '',
                                        image: snapshot.data!.image ??
                                            AppStrings.noUserImageWhite,
                                        agentFirstName:
                                            snapshot.data?.firstname ?? '',
                                        agentLastName:
                                            snapshot.data?.lastname ?? '',
                                        agentType: role ?? 'Agent',
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  }),
                            SizedBox(height: 20.h),
                            Builder(builder: (context) {
                              if (id == user!.id) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (buttonEdit != null) buttonEdit!,
                                    if (buttonDelete != null) buttonDelete!,
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                  if (isSold)
                    Positioned(
                      top: 10.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        color: AppColors.kRedColor,
                        child: EraText(
                          text: 'SOLD',
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 0),
                      spreadRadius: 1,
                      blurRadius: 5,
                      color: Colors.black26)
                ]),
            child: GestureDetector(
              onTap: onTap,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        // onTap: toggleSelected,
                        child: Container(
                          width: Get.width,
                          height: 195.h,
                          // duration: Duration(milliseconds: 300),
                          // curve: Curves.easeIn,
                          // height: selected.value ? 165.h : 195.h,
                          // width:
                          //     selected.value ? Get.width - 40.w : Get.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child:
                            EraText(text: 'Tap to view', color: Colors.black),
                      ),
                      SizedBox(height: 15.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: EraText(
                          text: type,
                          fontSize: EraTheme.header - 5.sp,
                          color: AppColors.kRedColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Row(
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
                                text: '$areas sqm',
                                fontSize: EraTheme.paragraph,
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
                            text: '$beds',
                            fontSize: EraTheme.paragraph,
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
                            text: '$baths',
                            fontSize: EraTheme.paragraph,
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
                            text: '$cars',
                            fontSize: EraTheme.paragraph,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: EraText(
                          text: 'Description:',
                          fontSize: EraTheme.paragraph + 2.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          lineHeight: 1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Text(
                          description == ""
                              ? "No Description Added"
                              : description,
                          style: TextStyle(
                            fontSize: EraTheme.paragraph,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: EraText(
                          text: NumberFormat.currency(
                            locale: 'en_PH',
                            symbol: 'PHP ',
                          ).format(price),
                          color: AppColors.blue,
                          fontSize: EraTheme.header,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      if (showListedby)
                        ListedBy(
                          text: listedBy,
                          image: agentImage ?? "",
                          agentFirstName: agentFirstName ?? '',
                          agentLastName: agentLastName ?? '',
                          agentType: role ?? '',
                        ),
                      SizedBox(height: 20.h),
                      Builder(builder: (context) {
                        if (user?.id == by) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (buttonEdit != null) buttonEdit!,
                              if (buttonDelete != null) buttonDelete!,
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ],
                  ),
                  if (isSold)
                    Positioned(
                      top: 10.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        color: AppColors.kRedColor,
                        child: EraText(
                          text: 'SOLD',
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  //todo: nikko im not sure how to put condition that this button will only show in my listing and will only visible to user only.
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: Builder(builder: (context) {
                      if (user?.id == by) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (buttonSold != null) buttonSold!,
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ],
              ),
            ),
          );
  }
}
