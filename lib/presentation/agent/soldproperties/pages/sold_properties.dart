import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/listings/gridViewV_Listing.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/sold_properties/sold_properties_listings.dart';
import 'package:eraphilippines/presentation/agent/soldproperties/controllers/sold_properties_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SoldProperties extends GetView<SoldPropertiesController> {
  const SoldProperties({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: WillPopScope(
        onWillPop: () {
          Get.back();
          return Future.value(false);
        },
        child: SafeArea(
          child: Obx(() => switch (controller.soldState.value) {
                SoldState.loading => _loading(),
                SoldState.loaded => _loaded(),
                SoldState.error => _error(),
                SoldState.empty => _empty()
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: EraText(
              text: 'SOLD PROPERTIES',
              fontSize: 30.sp,
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
          SoldPropertiesListings(
            listingModels: RealEstateListing.listingsModels,
          ),
        ],
      ),
    );
  }

  _error() {
    //todo add error screen
  }
  _empty() {
    //todo add empty screen
  }
}
