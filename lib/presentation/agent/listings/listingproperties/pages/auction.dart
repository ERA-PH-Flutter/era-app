import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/widgets/custom_appbar.dart';
import '../../../../../app/widgets/filteredsearch_box.dart';
import '../../../../../app/widgets/quick_links.dart';
import '../../searchresult/controllers/searchresult_controller.dart';
import '../controllers/listing_controller.dart';

class Auction extends GetView<ListingController> {
  const Auction({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchResultController searchController =
        Get.put(SearchResultController());

    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilteredSearchBox(),
                SizedBox(height: 10.h),
                Obx(() {
                  if (searchController.showFullSearch.value) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          QuickLinks(),
                          SizedBox(height: 10.h),
                        ]);
                  }
                  return Container();
                }),
                SizedBox(height: 10.h),
                EraText(
                  text: 'Heres What I Found For You',
                  fontSize: 23.sp,
                  color: AppColors.blue,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: 10.h),
                EraText(
                  text: '“AUCTION”',
                  fontSize: 22.sp,
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
