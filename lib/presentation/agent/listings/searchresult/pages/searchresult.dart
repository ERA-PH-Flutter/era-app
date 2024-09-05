import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/assets.dart';
import 'package:eraphilippines/app/constants/colors.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/constants/theme.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/app_text_listing.dart';
import 'package:eraphilippines/app/widgets/app_textfield.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/agent/projects/controllers/projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../app/services/ai_search.dart';
import '../../../../../app/services/firebase_database.dart';
import '../../../../../app/widgets/listings/listedBy_widget.dart';
import '../../../../../app/widgets/quick_links.dart';
import '../../../../../repository/listing.dart';
import '../../../../../repository/user.dart';
import '../../../home/controllers/home_controller.dart';
import '../../listingproperties/pages/findproperties.dart';
import '../controllers/searchresult_controller.dart';

class SearchResult extends GetView<SearchResultController> {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectsController projectsController = Get.put(ProjectsController());
    return BaseScaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: EraTheme.paddingWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h,),
              EraText(
                text: "Property searches made simple.",
                fontSize: 26.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kRedColor,
              ),
              SizedBox(height: 10.h,),
              BoxWidget.build(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    Obx((){
                      if (!controller.showFullSearch.value) {
                        return Column(
                          children: [
                            AppTextField(
                                onPressed: () {},
                                controller: controller.aiSearchController,
                                hint: 'Use AI Search',
                                svgIcon: AppEraAssets.ai3,
                                bgColor: AppColors.white,
                                isSuffix: true,
                                obscureText: false,
                                suffixIcons: AppEraAssets.send,
                                onSuffixTap: () async {
                                  var data;
                                  var searchQuery = "";
                                  data = await AI(query: controller.aiSearchController.text).search();
                                  searchQuery = controller.aiSearchController.text;
                                  selectedIndex.value = 2;
                                  print(data);
                                  Get.offAllNamed("/searchresult",
                                      arguments: [data, searchQuery]);
                                }),
                            SizedBox(height: 5.h),

                          ],
                        );
                      }else{
                        return Container();
                      }

                    }),
                    GestureDetector(
                      onTap: () {
                        controller.expanded.value =
                        !controller.expanded.value;
                        controller.showFullSearch.value =
                        !controller.showFullSearch.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.all(10.0.h),
                        child: Obx(() => EraText(
                          text: controller.expanded.value
                              ? "Back to AI Search"
                              : "Filtered Search",
                          fontSize: 15.sp,
                          textDecoration: TextDecoration.underline,
                        )),
                      ),
                    ),
                    Obx(() {
                      if (controller.showFullSearch.value) {
                        return Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.w),
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  //notesfornikkoo
                                  //Location new changes the location has the same properties with the searchresult,projectmain, home, and find agents
                                  //proterty type, price range, >> home, projectmain, searchresult
                                  AddListings.dropDownAddlistings1(
                                      color: AppColors.white,
                                      selectedItem:
                                      projectsController.selectedLocation,
                                      Types: projectsController.location,
                                      onChanged: (value) => projectsController
                                          .selectedLocation.value = value!,
                                      name: 'Location',
                                      hintText: 'Select Location'),
                                  AddListings.dropDownAddlistings1(
                                      color: AppColors.white,
                                      selectedItem: controller
                                          .selectedPropertyTypeSearch,
                                      Types: controller.propertyTypeSearch,
                                      onChanged: (value) => controller
                                          .selectedPropertyTypeSearch
                                          .value = value!,
                                      name: 'Property Type',
                                      hintText: 'Select Property Type'),
                                  AddListings.dropDownAddlistings1(
                                      color: AppColors.white,
                                      selectedItem:
                                      controller.selectedPriceSearch,
                                      Types: controller.priceSearch,
                                      onChanged: (value) => controller
                                          .selectedPriceSearch.value = value!,
                                      name: 'Price Range',
                                      hintText: 'Select Price Range'),
                                  Obx(
                                        () => Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.9,
                                              child: Radio(
                                                  toggleable: true,
                                                  fillColor:
                                                  WidgetStateProperty.all(
                                                      AppColors.white
                                                          .withOpacity(0.6)),
                                                  value: 1,
                                                  groupValue:
                                                  controller.isForSale.value,
                                                  onChanged: (value) {
                                                    controller.isForSale.value =
                                                        value ?? 0;
                                                  }),
                                            ),
                                            EraText(
                                                text: 'BUY',
                                                color: AppColors.white
                                                    .withOpacity(0.6),
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
                                                  fillColor:
                                                  WidgetStateProperty.all(
                                                      AppColors.white
                                                          .withOpacity(0.6)),
                                                  value: 2,
                                                  groupValue:
                                                  controller.isForSale.value,
                                                  onChanged: (value) {
                                                    controller.isForSale.value =
                                                        value ?? 0;
                                                  }),
                                            ),
                                            EraText(
                                                text: 'RENT',
                                                color: AppColors.white
                                                    .withOpacity(0.6),
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
                                        backgroundColor: WidgetStateProperty.all(
                                            AppColors.white),
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20),
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
                                    if (controller.isForSale.value == 1) {
                                      data = await Database().getForSaleListing();
                                      searchQuery = "All For Sale Listings";
                                    }
                                    else if (controller.isForSale.value == 2) {
                                      data = await Database().getForRentListing();
                                      searchQuery = "All For Rent Listings";
                                    }
                                    else{
                                      data = await Database().searchListing(
                                          location: Get.find<HomeController>().selectedLocation.value,
                                          price: Get.find<HomeController>().selectedPriceRange.value,
                                          property: Get.find<HomeController>().selectedPropertyType.value);
                                      if (controller.locationController.text !=
                                          "") {
                                        searchQuery +=
                                        "Location: ${Get.find<HomeController>().selectedLocation.value}";
                                      } else if (controller
                                          .propertyController.text !=
                                          "") {
                                        searchQuery +=
                                        "Property Type: ${Get.find<HomeController>().selectedPropertyType.value}";
                                      } else if (controller
                                          .priceController.text !=
                                          "") {
                                        searchQuery +=
                                        "With price less than: ${Get.find<HomeController>().selectedPriceRange.value}";
                                      }
                                    }
                                    selectedIndex.value = 2;
                                    Get.offAllNamed("/searchresult",
                                        arguments: [data, searchQuery]);
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
              ),
              SizedBox(height: 10.h),
              Obx(() {
                if (controller.showFullSearch.value == false) {
                  return QuickLinks(origin:'search');
                }
                return Container();
              }),
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          Obx((){
            if(controller.searchQuery.value == ""){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Showcased Listing',
                    fontSize: 23.sp,
                    color: AppColors.kRedColor,
                    fontWeight: FontWeight.w800,
                  ),
                  EraText(
                    text: 'Explore Our Top Picks',
                    fontSize: 17.sp,
                    color: AppColors.black,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(height: 10.h,)
                ],
              );
            }else{
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  EraText(
                    text: 'Here\'s what I found for you!',
                    fontSize: 23.sp,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 10.h),
                ],
              );
            }
          }),
          SizedBox(height: 10.h),
          ListView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.data.length,
            itemBuilder: (context, index) {
              //print(controller.data[index]);
              if (controller.data[index] != null) {
                Listing listing = Listing.fromJSON(controller.data[index]);
                return GestureDetector(
                  onTap: () async {
                    await Database().addViews(listing.id);
                    Get.toNamed('/propertyInfo', arguments: listing);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16.h),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 0),
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.black12)
                        ]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: CloudStorage().imageLoader(
                              height: 300.h,
                              width: Get.width,
                              ref: listing.photos != null
                                  ? (listing.photos!.isNotEmpty
                                      ? listing.photos!.first
                                      : AppStrings.noUserImageWhite)
                                  : AppStrings.noUserImageWhite,
                            )),
                        SizedBox(
                          height: 17.h,
                        ),
                        Container(
                          width: Get.width,
                          height: 30.h,
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            textOverflow: TextOverflow.ellipsis,
                            text:
                                listing.name! == "" ? "No Name" : listing.name!,
                            fontSize: EraTheme.header - 5.sp,
                            color: AppColors.kRedColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text: listing.type!,
                            fontSize: EraTheme.header - 12.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                            lineHeight: 1,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppEraAssets.area,
                                  width: 55.w,
                                  height: 55.w,
                                ),
                                SizedBox(width: 2.w),
                                EraText(
                                  text: '${listing.area} sqm',
                                  fontSize: EraTheme.paragraph - 1.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.black,
                                ),
                              ],
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(
                              AppEraAssets.bed,
                              width: 55.w,
                              height: 55.w,
                            ),
                            EraText(
                              text: '${listing.beds}',
                              fontSize: EraTheme.paragraph - 1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(
                              AppEraAssets.tub,
                              width: 55.w,
                              height: 55.w,
                            ),
                            EraText(
                              text: '${listing.baths}',
                              fontSize: EraTheme.paragraph - 1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            SizedBox(width: 10.w),
                            Image.asset(
                              AppEraAssets.car,
                              width: 55.w,
                              height: 55.w,
                            ),
                            EraText(
                              text: '${listing.cars}',
                              fontSize: EraTheme.paragraph - 1.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text: 'Description:',
                            fontSize: EraTheme.header - 8.sp,
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1,
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: Text(
                            listing.description == ""
                                ? "No description."
                                : listing.description!,
                            style: TextStyle(
                              fontSize: EraTheme.paragraph - 4.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.w),
                          child: EraText(
                            text: NumberFormat.currency(
                                    locale: 'en_PH', symbol: 'PHP ')
                                .format(
                              listing.price.toString() == ""
                                  ? 0
                                  : listing.price,
                            ),
                            color: AppColors.blue,
                            fontSize: EraTheme.header,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FutureBuilder(
                            future: EraUser().getById(listing.by),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var user1 = snapshot.data;
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 14.w),
                                  child: ListedBy(
                                      image: user1!.image ??
                                          AppStrings.noUserImageWhite,
                                      agentFirstName:
                                          user1.firstname ?? "No Name",
                                      agentType: user1.role ?? "Agent",
                                      agentLastName: user1.lastname ?? ""),
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            }),
                        SizedBox(
                          height: 15.h,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ],
      ),
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
          height: 200.h,
          child: Center(
            child: EraText(
              text: "No results found! for ${Get.arguments[1]}",
              color: Colors.black,
              fontSize: 20.sp,
            ),
          ),
        )
      ],
    );
  }
}
