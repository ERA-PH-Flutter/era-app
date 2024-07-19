import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/listing.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/listing_properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FindProperties extends StatelessWidget {
  const FindProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BoxWidget.boxListing(),
                SizedBox(height: 20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: EraText(
                    text: 'QUICK RESEARCH',
                    fontSize: 25.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.kRedColor,
                  ),
                ),
                // ListingProperties(
                //   scrollDirection: Axis.vertical,
                //   listingModels: Listing.listingsModels,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
