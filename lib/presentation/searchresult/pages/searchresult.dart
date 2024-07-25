import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchResult extends GetView<HomeController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoxWidget(
                child: Column(
                  children: [
                    AppTextField(
                      hint: 'AI Search',
                      svgIcon: 'assets/icons/send.png',
                      bgColor: AppColors.white,
                    ),
                    SearchWidget(),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: EraText(
                  text: 'SEARCH RESULTS FOR',
                  fontSize: 23.sp,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: EraText(
                  text: '“Lorem ipsum dolor sit amet”',
                  fontSize: 22.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
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
