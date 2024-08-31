import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/fav/fav_listing.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../app/constants/theme.dart';
import '../controllers/fav_controller.dart';
//todo add text

class Fav extends GetView<FavController> {
  const Fav({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.favState.value) {
                FavState.loading => _loading(),
                FavState.loaded => _loaded(),
                FavState.error => _error(),
                FavState.empty => _empty()
              }),
        ),
      ),
    );
  }

  _loading() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary,
      ),
    );
  }

  _loaded() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Obx(() {
            if (controller.favoritesList.isEmpty &&
                controller.listing == null) {
              return Center(child: Text('No favorites yet.'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EraText(
                  text: 'MY FAVORITES',
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.blue,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: EraTheme.paddingWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _sortByButton(),
                      SizedBox(
                        width: 10.w,
                      ),
                      _pdfButton()
                    ],
                  ),
                ),
                //  DropdownButton<String>(items: controller.sorting.map((listing)), onChanged: onChanged),

                FavListing(
                  listingModels: controller.favoritesList,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  _error() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "Something went Wrong!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  _empty() {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          EraText(
            fontSize: EraTheme.paragraph,
            text: "No Listings Found!",
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _sortByButton() {
    return PopupMenuButton<String>(
      color: AppColors.white,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.blue),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      icon: EraText(
        text: 'Sort by',
        color: AppColors.white,
        fontSize: 15.sp,
      ),
      onSelected: (String result) {
        print(result);
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Category',
          child: EraText(text: 'Category', color: AppColors.black),
        ),
        PopupMenuItem<String>(
          value: 'date_modified',
          child: EraText(text: 'Date', color: AppColors.black),
        ),
        PopupMenuItem<String>(
          value: 'Location',
          child: EraText(text: 'Location', color: AppColors.black),
        ),
        PopupMenuItem<String>(
          value: 'Amount',
          child: EraText(text: 'Amount', color: AppColors.black),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<String>(
          value: 'ascending',
          child: Text('Ascending'),
        ),
        const PopupMenuItem<String>(
          value: 'descending',
          child: Text('Descending'),
        ),
      ],
    );
  }

  Widget _pdfButton() {
    return GestureDetector(
      onTap: () {
        controller.onGeneratePdfButtonPressed();
      },
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.kRedColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w, left: 8.w),
            child: EraText(
              text: 'Generate PDF',
              color: AppColors.white,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
