import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/controllers/home_analytics_controller.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../presentation/agent/home/controllers/home_controller.dart';
import '../../presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import '../../presentation/global.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../services/ai_search.dart';

class FilteredSearchBox extends StatelessWidget {
  FilteredSearchBox({super.key});
  var showFullSearch = false.obs;
  var expanded = false.obs;
  var aiSearchController = TextEditingController();
  var locationController = TextEditingController();
  var priceController = TextEditingController();
  var propertyController = TextEditingController();
  var projectsController = TextEditingController();
  var isForSale = 0.obs;
  var selectedPriRceange = "".obs;
  var selectedLocation = RxnString();
  var selectedPriceRange = "".obs;
  var selectedPriceSearch = RxnString();
  var selectedPropertyTypeSearch = RxnString();
  var selectedPropertyType = "".obs;
  var propertyTypeSearch = [
    "Pre-selling",
    "Residential",
    "Commercial",
    "Rental",
    "Auction",
  ];
  var location = [
  "Manila",
  "Quezon City",
  "Caloocan",
  "Makati"
  "Valenzuela",
  "San Juan",
  "Parañaque",
  "Navotas",
  "Taguig",
  "Davao",
  "Las Piñas",
  "Pasig",
  "Mandaluyong",
  "Pateros",
  "Marikina",
  "Muntinlupa",
  "Malabon",
  "Fort Bonifacio",
  "Binondo",
  "Rizal",
  "Antipolo",
  "Santa Ana",
  ];
  var priceSearch = [
    " 1,000 -  100,000",
    " 100,000 - 500,000",
    " 100,000 - 1M",
    " 1M - 5M",
    " 10M - 50M",
    " 50M - 100M",
    " 100>",
  ];
  @override
  Widget build(BuildContext context) {

    return BoxWidget.build(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          if (!showFullSearch.value)
            AppTextField(
                onPressed: () {},
                controller: aiSearchController,
                hint: 'Use AI Search',
                svgIcon: AppEraAssets.ai3,
                bgColor: AppColors.white,
                isSuffix: true,
                obscureText: false,
                suffixIcons: AppEraAssets.send,
                onSuffixTap: () async {
                  var data;
                  var searchQuery = "";
                  data =
                      await AI(query: aiSearchController.text)
                          .search();
                  searchQuery = aiSearchController.text;
                  selectedIndex.value = 2;
                  pageViewController = PageController(initialPage: 2);
                  currentRoute = '/searchresult';
                  Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,searchQuery]);
                }),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              expanded.value =
                  !expanded.value;
              showFullSearch.value =
                  !showFullSearch.value;
            },
            child: Padding(
              padding: EdgeInsets.all(10.0.h),
              child: Obx(() => EraText(
                    text: expanded.value
                        ? "Back to AI Search"
                        : "Filtered Search",
                    fontSize: 15.sp,
                    textDecoration: TextDecoration.underline,
                  )),
            ),
          ),
          Obx(() {
            if (showFullSearch.value) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        //notesfornikkoo
                        //Location new changes the location has the same properties with the searchresult,projectmain, home, and find agents
                        //proterty type, price range, >> home, projectmain, searchresult
                        AddListings.dropDownAddlistings1(
                            color: AppColors.white,
                            selectedItem: selectedLocation,
                            Types: location,
                            onChanged: (value) => selectedLocation.value = value!,
                            name: 'Location',
                            hintText: 'Select Location'),
                        AddListings.dropDownAddlistings1(
                            color: AppColors.white,
                            selectedItem:
                                selectedPropertyTypeSearch,
                            Types: propertyTypeSearch,
                            onChanged: (value) =>
                                selectedPropertyTypeSearch.value = value!,
                            name: 'Property Type',
                            hintText: 'Select Property Type'),
                        AddListings.dropDownAddlistings1(
                            color: AppColors.white,
                            selectedItem: selectedPriceSearch,
                            Types: priceSearch,
                            onChanged: (value) =>
                                selectedPriceSearch.value = value!,
                            name: 'Price Range',
                            hintText: 'Select Price Range'),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.9,
                                    child: Radio(
                                        toggleable: true,
                                        fillColor: WidgetStateProperty.all(
                                            AppColors.white.withOpacity(0.6)),
                                        value: 1,
                                        groupValue: isForSale.value,
                                        onChanged: (value) {
                                          isForSale.value =
                                              value ?? 0;
                                        }),
                                  ),
                                  EraText(
                                      text: 'BUY',
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
                                        toggleable: true,
                                        fillColor: WidgetStateProperty.all(
                                            AppColors.white.withOpacity(0.6)),
                                        value: 2,
                                        groupValue: isForSale.value,
                                        onChanged: (value) {
                                          isForSale.value =
                                              value ?? 0;
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
                        SizedBox(
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
                              text: 'More Filters',
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
                          var data;
                          var searchQuery = "";
                          if (isForSale.value == 1) {
                            data = await Database().getForSaleListing();
                            searchQuery = "All For Sale Listings";
                          } else if (isForSale.value == 2) {
                            data = await Database().getForRentListing();
                            searchQuery = "All For Rent Listings";
                          } else {
                            data = await Database().searchListing(
                                location: selectedLocation.value,
                                price: selectedPriRceange.value,
                                property: selectedPropertyType.value);
                            if (locationController.text != "") {
                              searchQuery +=
                                  "Location: ${selectedLocation.value}";
                            } else if (propertyController.text !=
                                "") {
                              searchQuery +=
                                  "Property Type: ${selectedPropertyType.value}";
                            } else if (priceController.text != "") {
                              searchQuery +=
                                  "With price less than: ${selectedPriceRange.value}";
                            }
                          }
                          selectedIndex.value = 2;
                          pageViewController = PageController(initialPage: 2);
                          currentRoute = '/searchresult';
                          Get.offAll(BaseScaffold(),binding: SearchResultBinding(),arguments: [data,searchQuery]);
                        }),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          }),
        ],
      ),
    );
  }
}