import 'dart:async';

import 'package:eraphilippines/app/constants/sized_box.dart';
import 'package:eraphilippines/app/models/ai_filters.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_controller.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import '../../presentation/global.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../constants/screens.dart';
import '../constants/theme.dart';
import '../services/ai_search.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

//ignore: must_be_immutable
class FilteredSearchBox extends StatefulWidget {
  const FilteredSearchBox({super.key, this.animateToPage2 = false});
  final bool animateToPage2;
  @override
  State<FilteredSearchBox> createState() => _FilteredSearchBoxState();
}

class _FilteredSearchBoxState extends State<FilteredSearchBox> {
  var formKey = GlobalKey<FormState>();

  var showFullSearch = false.obs;
  var expanded = false.obs;
  var aiSearchController = TextEditingController();
  var locationController = TextEditingController();
  var priceController = TextEditingController();
  var propertyController = TextEditingController();
  var projectsController = TextEditingController();
  var bedrooms = 0.obs;
  var bathrooms = 0.obs;
  var garage = 0.obs;
  var selectedSubProperty = RxnString();

  var ppsqmMinObs = "".obs;
  var ppsqmMaxObs = "".obs;
  var floorAreaMinObs = "".obs;
  var floorAreaMaxObs = "".obs;
  var lotAreaMinObs = "".obs;
  var lotAreaMaxObs = "".obs;
  var controllerPriceMin = TextEditingController();
  var controllerPriceMax = TextEditingController();
  var controllerPpsqmMin = TextEditingController();
  var controllerPpsqmMax = TextEditingController();
  var controllerFloorAreaMin = TextEditingController();
  var controllerFloorAreaMax = TextEditingController();
  var controllerLotAreaMin = TextEditingController();
  var controllerLotAreaMax = TextEditingController();

  var priceMin = "".obs;
  var priceMax = "".obs;
  var isForSale = 0.obs;
  var selectedLocation = RxnString();
  var selectedPriceRange = "".obs;
  var selectedPriceSearch = RxnString();
  var selectedPropertyTypeSearch = RxnString();

  var isActiveSearch = false.obs;
  // var propertyTypeSearch = [
  //   "Pre-selling",
  //   "Residential",
  //   "Commercial",
  //   "Rental",
  //   "Auction",
  // ];
  var location = [
    "Manila",
    "Quezon City",
    "Caloocan",
    "Makati",
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

  List<String> priceSearch = [
    "1,000 - 100,000",
    "100,000 - 500,000",
    "100,000 - 1M",
    "1M - 5M",
    "10M - 50M",
    "50M - 100M",
    "100M - 1B",
  ];

  List<String> priceSearchCopy = [
    "1,000 - 100,000",
    "100,000 - 500,000",
    "100,000 - 1M",
    "1M - 5M",
    "10M - 50M",
    "50M - 100M",
    "100M - 1B",
  ];
  stt.SpeechToText speech = stt.SpeechToText();
  bool speechEnabled = false;
  String lastWords = '';
  bool speechStarted = false;
  Timer? myStream;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initSpeech() async {
    speechEnabled = await speech.initialize();
  }

  void startListening() async {
    await speech.listen(onResult: (result) {
      aiSearchController.text = result.recognizedWords;
      setState(() {});
    });
    myStream = Timer.periodic(Duration(seconds: 1), (tick) {
      if (speech.isNotListening) {
        setState(() {
          speechStarted = false;
          myStream?.cancel();
          aiSearchController.text.isNotEmpty ? aiSearch() : null;
        });
      }
    });
  }

  aiSearch() async {
    try {
      var searchQuery = "";
      BaseController().showLoading();
      searchQuery = aiSearchController.text;
      var data = await AI(query: searchQuery).listingSearch();
      currentRoute = '/searchresult';
      Get.find<SearchResultController>().searchResultState.value =
          SearchResultState.loading;
      Get.find<SearchResultController>().data.value = data;
      BaseController().hideLoading();
      selectedIndex.value = 2;
      pageViewController.animateToPage(
        2,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      Get.find<SearchResultController>().searchResultState.value =
          data.isEmpty ? SearchResultState.empty : SearchResultState.loaded;
    } catch (e) {
      print('error AI search $e');
    } finally {
      BaseController().hideLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SearchResultController());
    return BoxWidget.build(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          if (!showFullSearch.value)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              height: 60.h,
              child: CupertinoTextField(
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 20.sp),
                controller: aiSearchController,
                placeholder: 'Use AI Search',
                prefix: Row(
                  children: [
                    SizedBox(
                      width: 10.w,
                    ),
                    Image.asset(
                      AppEraAssets.ai3,
                      height: 30.h,
                      color: AppColors.kRedColor,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: AppColors.white,
                ),
                suffix: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await Permission.audio.request().isGranted;
                        if (speechStarted) {
                          aiSearchController.text = "";
                          speechStarted = false;
                          speech.stop();
                          setState(() {});
                        } else {
                          speechStarted = true;
                          setState(() {});
                          if (speechEnabled) {
                            startListening();
                          } else {
                            await initSpeech();
                            startListening();
                          }
                        }
                      },
                      child: speechStarted
                          ? Icon(Icons.hearing)
                          : Icon(
                              Icons.mic,
                              size: 25.sp,
                            ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await aiSearch();
                      },
                      child: Image.asset(
                        AppEraAssets.send,
                        height: 27.5.h,
                        color: AppColors.kRedColor,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                  ],
                ),
              ),
            ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              expanded.value = !expanded.value;
              showFullSearch.value = !showFullSearch.value;
            },
            child: Padding(
              padding: EdgeInsets.all(10.h),
              child: Obx(() => EraText(
                    text: expanded.value
                        ? "Back to AI Search"
                        : "Filtered Search",
                    fontSize: EraTheme.bodyText,
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

                        //proterty type, price range, >> home, projectmain, searchresult
                        AddListings.dropDownAddlistings1(
                            color: AppColors.white,
                            selectedItem: selectedLocation,
                            Types: location,
                            onChanged: (value) =>
                                selectedLocation.value = value!,
                            name: 'Location',
                            hintText: 'Select Location'),
                        AddListings.dropDownAddlistings1(
                            color: AppColors.white,
                            selectedItem: selectedPropertyTypeSearch,
                            Types: propertyT,
                            onChanged: (value) =>
                                selectedPropertyTypeSearch.value = value!,
                            name: 'Property Type',
                            hintText: 'Select Property Type'),
                        // AddListings.dropDownAddlistings1(
                        //     color: AppColors.white,
                        //     selectedItem: selectedPriceSearch,
                        //     Types: priceSearch,
                        //     onChanged: (value) =>
                        //         selectedPriceSearch.value = value!,
                        //     name: 'Price Range',
                        //     hintText: 'Select Price Range'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EraText(
                              text: 'Select Price Range',
                              fontSize: EraTheme.h6,
                              color: AppColors.white,
                            ),
                            //   Row(
                            //     children: [
                            //       Expanded(
                            //         flex: 1,
                            //         child: TextFormField(
                            //           keyboardType: TextInputType.number,
                            //           inputFormatters: [
                            //             FilteringTextInputFormatter.digitsOnly,
                            //           ],
                            //           onChanged: (value) {
                            //             value = value.replaceAll(',', '');
                            //             if (value.isNotEmpty) {
                            //               final formattedValue =
                            //                   value.replaceAllMapped(
                            //                       RegExp(
                            //                           r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            //                       (Match m) => '${m[1]},');
                            //               controllerPriceMin.value =
                            //                   controllerPriceMin.value.copyWith(
                            //                 text: formattedValue,
                            //                 selection: TextSelection.collapsed(
                            //                     offset: formattedValue.length),
                            //               );
                            //             }
                            //             priceMin.value = value;
                            //             //  }
                            //           },
                            //           controller: controllerPriceMin,
                            //           decoration: InputDecoration(
                            //             //  isDense: true,
                            //             prefixIcon: Padding(
                            //               padding: EdgeInsets.only(top: 12.h),
                            //               child: EraText(
                            //                   textAlign: TextAlign.center,
                            //                   text: 'PHP:',
                            //                   fontSize: EraTheme.h6,
                            //                   color: AppColors.black),
                            //             ),
                            //             contentPadding: EdgeInsets.symmetric(
                            //                 vertical: 10.h, horizontal: 10.w),
                            //             hintText: 'Min Price',
                            //             fillColor: AppColors.white,
                            //             filled: true,

                            //             hintStyle: TextStyle(
                            //               fontSize: EraTheme.h6,
                            //             ),

                            //             border: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(20),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       SizedBox(width: 10),
                            //       Expanded(
                            //         flex: 1,
                            //         child: TextFormField(
                            //           keyboardType: TextInputType.number,
                            //           inputFormatters: [
                            //             FilteringTextInputFormatter.digitsOnly,
                            //           ],
                            //           controller: controllerPriceMax,
                            //           onChanged: (value) {
                            //             value = value.replaceAll(',', '');
                            //             if (value.isNotEmpty) {
                            //               final formattedValue =
                            //                   value.replaceAllMapped(
                            //                       RegExp(
                            //                           r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            //                       (Match m) => '${m[1]},');
                            //               controllerPriceMax.value =
                            //                   controllerPriceMax.value.copyWith(
                            //                 text: formattedValue,
                            //                 selection: TextSelection.collapsed(
                            //                     offset: formattedValue.length),
                            //               );
                            //             }
                            //             priceMax.value = value;
                            //           },
                            //           decoration: InputDecoration(
                            //             //     prefixIcon: Icon(Icons.attach_money),
                            //             prefixIcon: Padding(
                            //               padding: EdgeInsets.only(
                            //                 left: 5.w,
                            //                 top: 5.h,
                            //               ),
                            //               child: EraText(
                            //                   textAlign: TextAlign.center,
                            //                   text: 'PHP:',
                            //                   fontSize: EraTheme.h6,
                            //                   color: AppColors.black),
                            //             ),
                            //             contentPadding: EdgeInsets.zero,
                            //             hintText: 'Max Price',
                            //             fillColor: AppColors.white,
                            //             filled: true,
                            //             hintStyle: TextStyle(
                            //               fontSize: EraTheme.h6,
                            //             ),
                            //             enabledBorder: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(20),
                            //               borderSide: BorderSide(
                            //                 color: AppColors.black,
                            //                 width: 1.5,
                            //               ),
                            //             ),
                            //             border: OutlineInputBorder(
                            //               borderRadius: BorderRadius.circular(20),
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Expanded(
                                    flex: 1,
                                    child: Tooltip(
                                      message: "Enter the minimum price (PHP)",
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        onChanged: (value) {
                                          value = value.replaceAll(',', '');
                                          if (value.isNotEmpty) {
                                            final formattedValue =
                                                value.replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => '${m[1]},',
                                            );
                                            controllerPriceMin.value =
                                                controllerPriceMin.value
                                                    .copyWith(
                                              text: formattedValue,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: formattedValue
                                                          .length),
                                            );
                                          }
                                          priceMin.value = value;
                                        },
                                        controller: controllerPriceMin,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(12.sp),
                                            child: EraText(
                                              text: 'PHP:',
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20.sp,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          hintText: 'Min Price',
                                          hintStyle: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.montserrat(
                                                          fontWeight:
                                                              FontWeight.w400)
                                                      .fontFamily,
                                              fontSize: EraTheme.h6,
                                              color: AppColors.hint),
                                          fillColor: AppColors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(99),
                                            borderSide: BorderSide(
                                              color: AppColors.hint,
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(99),
                                            borderSide: BorderSide(
                                              color: AppColors.primary,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                SizedBox(
                                  child: Expanded(
                                    flex: 1,
                                    child: Tooltip(
                                      message: "Enter the maximum price (PHP)",
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                        onChanged: (value) {
                                          value = value.replaceAll(',', '');
                                          if (value.isNotEmpty) {
                                            final formattedValue =
                                                value.replaceAllMapped(
                                              RegExp(
                                                  r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                              (Match m) => '${m[1]},',
                                            );
                                            controllerPriceMax.value =
                                                controllerPriceMax.value
                                                    .copyWith(
                                              text: formattedValue,
                                              selection:
                                                  TextSelection.collapsed(
                                                      offset: formattedValue
                                                          .length),
                                            );
                                          }
                                          priceMax.value = value;
                                        },
                                        controller: controllerPriceMax,
                                        decoration: InputDecoration(
                                          prefixIcon: Padding(
                                            padding: EdgeInsets.all(12.sp),
                                            child: EraText(
                                              text: 'PHP:',
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20.sp,
                                                color: AppColors.black,
                                              ),
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 15),
                                          hintText: 'Max Price',
                                          hintStyle: TextStyle(
                                              fontFamily:
                                                  GoogleFonts.montserrat(
                                                          fontWeight:
                                                              FontWeight.w400)
                                                      .fontFamily,
                                              fontSize: EraTheme.h6,
                                              color: AppColors.hint),
                                          fillColor: AppColors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(99),
                                            borderSide: BorderSide(
                                              color: AppColors.hint,
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(99),
                                            borderSide: BorderSide(
                                              color: AppColors.primary,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        sb20(),
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
                                          isForSale.value = value ?? 0;
                                        }),
                                  ),
                                  sbw10(),
                                  EraText(
                                      text: 'BUY',
                                      color: AppColors.white.withOpacity(0.6),
                                      fontSize: EraTheme.h6,
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
                                          isForSale.value = value ?? 0;
                                        }),
                                  ),
                                  sbw10(),
                                  EraText(
                                      text: 'RENT',
                                      color: AppColors.white.withOpacity(0.6),
                                      fontSize: EraTheme.h6,
                                      fontWeight: FontWeight.w500),
                                ],
                              ),
                            ],
                          ),
                        ),
                        sb20(),
                        SizedBox(
                          width: Get.width,
                          height: 60.h,
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
                            onPressed: () async {
                              await openFilterDialog(
                                subcategory: selectedSubProperty,
                                bathrooms: bathrooms,
                                bedrooms: bedrooms,
                                garage: garage,
                                ppsqmMaxObservable: ppsqmMaxObs,
                                ppsqmMinObservable: ppsqmMinObs,
                                floorAreaMaxObservable: floorAreaMaxObs,
                                floorAreaMinObservable: floorAreaMinObs,
                                lotAreaMaxObservable: lotAreaMaxObs,
                                lotAreaMinObservable: lotAreaMinObs,
                                floorAreaMax: controllerFloorAreaMin,
                                floorAreaMin: controllerFloorAreaMax,
                                lotAreaMax: controllerLotAreaMin,
                                lotAreaMin: controllerLotAreaMax,
                                ppsqmMax: controllerPpsqmMax,
                                ppsqmMin: controllerPpsqmMin,
                              );
                              setState(() {
                                expanded.value = false;
                                showFullSearch.value = false;
                              });
                            },
                            label: EraText(
                              text: 'More Filters',
                              color: AppColors.black,
                              fontSize: EraTheme.h6,
                              fontWeight: FontWeight.w500,
                            ),
                            icon: Icon(
                              Icons.filter_alt,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        sb20(),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Obx(() {
                                if (Get.find<SearchResultController>()
                                        .searchResultState
                                        .value ==
                                    SearchResultState.loading) {
                                  return Screens.loadingTwo();
                                }

                                return SearchWidget(onTap: () async {
                                  if (priceMin.value.isNotEmpty &&
                                      priceMax.value.isNotEmpty) {
                                    if (int.parse(priceMin.value
                                            .replaceAll(',', '')) >
                                        int.parse(priceMax.value
                                            .replaceAll(',', ''))) {
                                      return showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: AppColors.white,
                                              title: EraText(
                                                  text:
                                                      'Invalid price range input',
                                                  color: AppColors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold),
                                              content: EraText(
                                                  text:
                                                      'Maximum price should be greater than minimum price.',
                                                  color: AppColors.black,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w500),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: EraText(
                                                        text: 'OK',
                                                        color: AppColors.black,
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            );
                                          });
                                    }
                                  }

                                  String searchQuery = '';

                                  // var data;
                                  // var searchQuery = "aaaa";
                                  if (isForSale.value == 1) {
                                    searchQuery = " Sale. ";
                                  } else if (isForSale.value == 2) {
                                    searchQuery = " Rent. ";
                                  }
                                  // Query query =
                                  //     FirebaseFirestore.instance.collection('listings');
                                  if (selectedLocation.value != null) {
                                    searchQuery +=
                                        ' ${selectedLocation.value}.';
                                  }
                                  if (selectedPropertyTypeSearch.value !=
                                      null) {
                                    searchQuery +=
                                        ' ${selectedPropertyTypeSearch.value}.';
                                  }

                                  if (selectedSubProperty.value != null) {
                                    searchQuery +=
                                        ' sub_category ${selectedSubProperty.value}.';
                                  }
                                  if (bedrooms.value != 0) {
                                    searchQuery +=
                                        ' beds equals ${bedrooms.value}.';
                                  }
                                  if (bathrooms.value != 0) {
                                    searchQuery +=
                                        ' baths equals ${bathrooms.value}.';
                                  }
                                  if (garage.value != 0) {
                                    searchQuery +=
                                        ' garage equals ${garage.value}.';
                                  }

                                  try {
                                    if (widget.animateToPage2) {
                                      pageViewController.animateToPage(
                                        2,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                      selectedIndex.value = 2;
                                      currentRoute = '/searchresult';
                                    }
                                    print(
                                        "gemini search overrideAiFilters ${priceMin.value != "" && priceMax.value != ""}");
                                    Get.find<SearchResultController>()
                                        .searchListingQuery(
                                            query: searchQuery,
                                            overrideAiFilters: [
                                          if (priceMin.value != "" &&
                                              priceMax.value != "") ...[
                                            AiFilters(
                                              field: 'price',
                                              value: double.tryParse(priceMin
                                                      .replaceAll(',', '')) ??
                                                  0,
                                              operator: ">",
                                            ),
                                            AiFilters(
                                              field: 'price',
                                              value: double.tryParse(priceMax
                                                      .value
                                                      .replaceAll(',', '')) ??
                                                  0,
                                              operator: "<",
                                            ),
                                          ],
                                          if (ppsqmMinObs.value != "" &&
                                              ppsqmMaxObs.value != "") ...[
                                            AiFilters(
                                              field: 'ppsqm',
                                              value: int.tryParse(ppsqmMinObs
                                                      .value
                                                      .replaceAll(',', '')) ??
                                                  0,
                                              operator: ">",
                                            ),
                                            AiFilters(
                                              field: 'ppsqm',
                                              value: int.tryParse(ppsqmMaxObs
                                                      .value
                                                      .replaceAll(',', '')) ??
                                                  0,
                                              operator: "<",
                                            ),
                                          ],
                                          if (floorAreaMinObs.value != "" &&
                                              floorAreaMaxObs.value != "") ...[
                                            AiFilters(
                                              field: 'floor_area',
                                              value: int.tryParse(
                                                      floorAreaMinObs.value
                                                          .replaceAll(
                                                              ',', '')) ??
                                                  0,
                                              operator: ">",
                                            ),
                                            AiFilters(
                                              field: 'floor_area',
                                              value: int.tryParse(
                                                      floorAreaMaxObs.value
                                                          .replaceAll(
                                                              ',', '')) ??
                                                  0,
                                              operator: "<",
                                            ),
                                          ],
                                          if (lotAreaMinObs.value != "" &&
                                              lotAreaMaxObs.value != "") ...[
                                            AiFilters(
                                              field: 'lot_area',
                                              value: int.tryParse(lotAreaMinObs
                                                      .value
                                                      .replaceAll(',', '')) ??
                                                  0,
                                              operator: ">",
                                            ),
                                            AiFilters(
                                              field: 'lot_area',
                                              value: int.tryParse(lotAreaMaxObs
                                                      .value
                                                      .replaceAll(',', '')) ??
                                                  0,
                                              operator: "<",
                                            ),
                                          ],
                                        ]);
                                  } catch (e) {
                                    Get.find<SearchResultController>()
                                        .searchResultState
                                        .value = SearchResultState.loaded;
                                  } finally {
                                    setState(() {
                                      expanded.value = false;
                                      showFullSearch.value = false;
                                    });
                                  }
                                });
                              }),
                            ),
                            Obx(() {
                              if (selectedLocation.value != null ||
                                  selectedPropertyTypeSearch.value != null ||
                                  selectedPriceRange.value != "" ||
                                  selectedSubProperty.value != null ||
                                  bedrooms.value != 0 ||
                                  bathrooms.value != 0 ||
                                  garage.value != 0 ||
                                  lotAreaMinObs.value.isNotEmpty &&
                                      lotAreaMinObs.value.isNotEmpty ||
                                  floorAreaMinObs.value.isNotEmpty &&
                                      floorAreaMaxObs.value.isNotEmpty ||
                                  ppsqmMinObs.value.isNotEmpty &&
                                      ppsqmMaxObs.value.isNotEmpty) {
                                return Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      final searchResultController =
                                          Get.find<SearchResultController>();
                                      searchResultController.initListing();
                                      currentRoute = '/searchresult';

                                      selectedPropertyTypeSearch.value = null;
                                      selectedLocation.value = null;
                                      selectedPriceRange.value = "";
                                      aiSearchController.clear();
                                      locationController.clear();
                                      priceController.clear();
                                      propertyController.clear();
                                      projectsController.clear();

                                      controllerPriceMin.clear();
                                      controllerPriceMax.clear();
                                      controllerPpsqmMin.clear();
                                      controllerPpsqmMax.clear();
                                      bedrooms.value = 0;
                                      bathrooms.value = 0;
                                      garage.value = 0;
                                      isForSale.value = 0;
                                      selectedSubProperty.value = null;
                                    },
                                    icon: Icon(Icons.clear),
                                    color: AppColors.white,
                                  ),
                                );
                              }
                              return Container();
                            }),
                          ],
                        ),
                        sb20(),
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
