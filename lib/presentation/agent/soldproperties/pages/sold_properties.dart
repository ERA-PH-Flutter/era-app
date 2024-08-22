import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 11.h,),
            EraText(
              text: 'SOLD PROPERTIES',
              fontSize: 30.sp,
              color: AppColors.blue,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 5.h,),
            SoldPropertiesListings(
              listingModels: controller.soldListings.value,
            ),
          ],
        ),
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
  _empty() {
    return Center(
      child: EraText(
        text: "Nothing is sold in your List!",
        color: Colors.black,
        fontSize: EraTheme.paragraph,
      ),
    );
  }
}
