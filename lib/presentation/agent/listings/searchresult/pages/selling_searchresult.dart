import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/listings/gridViewV_Listing.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../controllers/searchresult_controller.dart';

class SellingSearchresult extends GetView<SearchResultController> {
  const SellingSearchresult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxWidget.build(
                  child: Column(
                children: [
                  SizedBox(height: 10.h),
                  AppTextField(
                    hint: 'AI Search',
                    svgIcon: AppEraAssets.send,
                    bgColor: AppColors.white,
                  ),
                  SizedBox(height: 10.h),
                  SearchWidget.build(() {}),
                ],
              )),
              SizedBox(height: 30.h),
              EraText(
                text: 'PRE-SELLING SEARCH RESULTS',
                fontSize: 23.sp,
                color: AppColors.blue,
                fontWeight: FontWeight.w600,
              ),
              EraText(
                text: '“Lorem ipsum dolor sit amet”',
                fontSize: 22.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 10.h),
              FindingProperties(
                listingModels: RealEstateListing.listingsModels,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
