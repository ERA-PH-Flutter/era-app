import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/services/ai_search.dart';
import '../controllers/searchresult_controller.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoxWidget.build(
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  AppTextField(
                    controller: controller.aiSearchController,
                    hint: 'AI Search',
                    svgIcon: AppEraAssets.send,
                    bgColor: AppColors.white,
                  ),
                  SearchWidget.build(() async {
                    controller.searchResultState.value =
                        SearchResultState.loading;
                    controller.loadData(
                        await AI(query: controller.aiSearchController.text)
                            .search());
                  }),
                ],
              ),
            ),
            Obx(() => switch (controller.searchResultState.value) {
                  SearchResultState.loading => Center(
                      child: CircularProgressIndicator(),
                    ),
                  SearchResultState.loaded => _loaded(),
                  SearchResultState.empty => _empty(),
                  SearchResultState.searching => _searching(),
                  SearchResultState.error => _error(),
                }),
          ],
        ),
      ),
    );
  }

  _searching() {
    return Container();
  }

  _loaded() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            text: '“${controller.searchQuery}”',
            fontSize: 22.sp,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: (Get.height - 62.w ) / 2,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              RealEstateListing listing =
                  RealEstateListing.fromJSON(controller.data[index]);
              return listing.createMiniListing();
              //todo missy
            },
          ),
        )
      ],
    );
  }

  _error() {
    return EraText(
      text: "ERROR",
      color: Colors.black,
    );
  }

  _empty() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: (Get.height) / 2,
          child: Center(
            child: EraText(
              text: "No results found!",
              color: Colors.black,
              fontSize: 15.sp,
            ),
          ),
        )
      ],
    );
  }
}
