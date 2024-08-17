import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/archived/archived_listings.dart';

import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/presentation/agent/archivedlisting/controllers/archived_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Archived extends GetView<ArchivedController> {
  const Archived({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
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
            ArchivedListings(listingModels: RealEstateListing.listingsModels,
            ),
          ],
        ),
      ),
    );
  }
}
