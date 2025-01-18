import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/archived/archived_listings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/constants/screens.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../controllers/archived_controller.dart';

class Archived extends GetView<ArchivedController> {
  const Archived({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Obx(()=>switch(controller.archiveState.value){
          ArchiveState.loading => _loading(),
          ArchiveState.loaded => _loaded(),
          ArchiveState.empty => _empty(),
          ArchiveState.error => _error()
        })
      ),
    );
  }
  _loaded(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: EraText(
              text: 'ARCHIVED LISTINGS',
              fontSize: 25.sp,
              color: AppColors.blue,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 10.h,
        ),
        ArchivedListings(listingModels: controller.archiveListings,
        ),
      ],
    );
  }
  _loading() {
    return Screens.loading();
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
        text: "No Archived Listing Found!",
        color: Colors.black,
      ),
    );
  }
}
