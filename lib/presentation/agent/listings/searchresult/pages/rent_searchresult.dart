import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
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
 
class RentSearchresult extends  GetView<SearchResultController>  {
  const RentSearchresult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20.w),
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
                  SearchWidget.build(() {}),
                ],
              )),
              SizedBox(height: 30.h),
              EraText(
                text: 'RENT SEARCH RESULTS',
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
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: FindingProperties(
                  listingModels: RealEstateListing.listingsModels,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
