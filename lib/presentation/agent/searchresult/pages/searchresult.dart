import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/app/widgets/sold_properties/custom_sort.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
import '../controllers/searchresult_controller.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final FilterController controllers = Get.put(FilterController());

    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SizedBox(width: 10.w),
                  // CustomSortPopup(
                  //   title: 'Sort by',
                  //   onSelected: (String result) {
                  //     print(result);
                  //   },
                  //   menuItems: const [
                  //     PopupMenuItem<String>(
                  //       value: 'Category',
                  //       child: Text('Category',
                  //           style: TextStyle(color: Colors.black)),
                  //     ),
                  //     PopupMenuItem<String>(
                  //       value: 'date_modified',
                  //       child:
                  //           Text('Date', style: TextStyle(color: Colors.black)),
                  //     ),
                  //     PopupMenuItem<String>(
                  //       value: 'Location',
                  //       child: Text('Location',
                  //           style: TextStyle(color: Colors.black)),
                  //     ),
                  //     PopupMenuItem<String>(
                  //       value: 'Amount',
                  //       child: Text('Amount',
                  //           style: TextStyle(color: Colors.black)),
                  //     ),
                  //     PopupMenuDivider(),
                  //     PopupMenuItem<String>(
                  //       value: 'ascending',
                  //       child: Text('Ascending'),
                  //     ),
                  //     PopupMenuItem<String>(
                  //       value: 'descending',
                  //       child: Text('Descending'),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
              SizedBox(height: 10.h),
              BoxWidget.build(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    //Location
                    AppTextField(
                      controller: controller.locationController,
                      hint: 'Location',
                      svgIcon: AppEraAssets.marker,
                      bgColor: AppColors.white,
                    ),
                    //property type
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: controller.propertyController,
                      hint: 'Property Type',
                      svgIcon: AppEraAssets.house,
                      bgColor: AppColors.white,
                    ),
                    //price range
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: controller.priceController,
                      hint: 'Price Range',
                      svgIcon: AppEraAssets.money,
                      bgColor: AppColors.white,
                    ),
                    //ai search
                    SizedBox(height: 20.h),
                    AppTextField(
                      controller: controller.aiSearchController,
                      hint: 'AI Search',
                      svgIcon: AppEraAssets.send,
                      bgColor: AppColors.white,
                    ),
                    SizedBox(height: 20.h),
                    Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.9,
                                child: Radio(
                                    fillColor: WidgetStateProperty.all(
                                        AppColors.white.withOpacity(0.6)),
                                    value: 1,
                                    groupValue: controller.isForSale.value,
                                    onChanged: (value) {
                                      controller.isForSale.value = value ?? 0;
                                    }),
                              ),
                              EraText(
                                  text: 'SELL',
                                  color: AppColors.white.withOpacity(0.6),
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.9,
                                child: Radio(
                                    fillColor: WidgetStateProperty.all(
                                        AppColors.white.withOpacity(0.6)),
                                    value: 2,
                                    groupValue: controller.isForSale.value,
                                    onChanged: (value) {
                                      controller.isForSale.value = value ?? 0;
                                    }),
                              ),
                              EraText(
                                  text: 'RENT',
                                  color: AppColors.white.withOpacity(0.6),
                                  fontSize: 15.0.sp,
                                  fontWeight: FontWeight.w500),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),

                    Container(
                      width: Get.width,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(AppColors.white),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          openFilterDialog();
                        },
                        label: EraText(
                          text: 'Filters',
                          color: AppColors.black,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        icon: Icon(
                          Icons.filter_alt,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SearchWidget.build(() async {
                      controller.searchResultState.value =
                          SearchResultState.loading;
                      var data;
                      if (controller.aiSearchController.text == "") {
                        data = await Database().searchListing(
                            location: controller.locationController.text,
                            price: controller.priceController,
                            type: controller.isForSale.value == 1
                                ? "selling"
                                : "rent",
                            property: controller.propertyController.text);
                      } else {
                        data =
                            await AI(query: controller.aiSearchController.text)
                                .search();
                      }
                      controller.data.value = data ?? [];
                      controller.searchResultState.value =
                          SearchResultState.loaded;
                    }),

                    SizedBox(height: 10.h),
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
        EraText(
          text: 'SEARCH RESULTS FOR',
          fontSize: 23.sp,
          color: AppColors.blue,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: 10.h),
        EraText(
          text: '“${controller.searchQuery}”',
          fontSize: 22.sp,
          color: AppColors.black,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: 10.h),
        Container(
          height: (Get.height - 62.w) / 2,
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
