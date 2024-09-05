import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/quick_links.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:eraphilippines/repository/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../app/services/ai_search.dart';
import '../../../../../app/services/firebase_database.dart';
import '../../../../../app/widgets/filteredsearch_box.dart';
import '../controllers/listing_controller.dart';

class FindProperties extends GetView<ListingController> {
  const FindProperties({super.key});

  @override
  Widget build(BuildContext context) {
    ProjectsController projectsController = Get.put(ProjectsController());
    SearchResultController searchController = Get.put(SearchResultController());
    return BaseScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(EraTheme.paddingWidth),
            child: Column(
              children: [
                FilteredSearchBox(),
                SizedBox(height: 10.h),
                Obx(() {
                  if (searchController.showFullSearch.value == false) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                QuickLinks(),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.h),
                        ]);
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget quickSearchIcon(String icon, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            height: 80.h,
            width: 80.w,
          ),
        ],
      ),
    );
  }
}
