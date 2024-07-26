import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/custom_appbar.dart';
import 'package:eraphilippines/app/widgets/findingproperties.dart';
import 'package:eraphilippines/app/widgets/listedBy_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Agentinfo extends StatelessWidget {
  final RealEstateListing listing;

  const Agentinfo({super.key, required this.listing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: EraText(
                  text: 'AGENT PROFILE',
                  color: AppColors.blue,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15.h),
              ListedBy.agentListing(
                listing.agentImage,
                listing.agentFirstName,
                listing.agentLastName,
                listing.agents,
                listing.whatsapp,
                listing.whatsappIcon,
                listing.email,
                listing.emailIcon,
              ),
              SizedBox(height: 15.h),
              Center(
                child: EraText(
                  text: 'LISTED PROPERTIES',
                  color: AppColors.kRedColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
