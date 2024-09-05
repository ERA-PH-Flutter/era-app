import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/ai_search.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/filteredsearch_box.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/widgets/quick_links.dart';
import '../../searchresult/controllers/searchresult_controller.dart';
import '../controllers/listing_controller.dart';
import 'findproperties.dart';

class Commercial extends GetView<ListingController> {
  const Commercial({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchResultController searchController =
        Get.put(SearchResultController());

    return BaseScaffold(
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
                        children: [QuickLinks()]);
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
                  text: '“COMMERCIAL”',
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
