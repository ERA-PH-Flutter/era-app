import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/app/widgets/app_text.dart';
import 'package:eraphilippines/app/widgets/box_widget.dart';
import 'package:eraphilippines/app/widgets/filter_options.dart';
import 'package:eraphilippines/app/widgets/navigation/customenavigationbar.dart';
import 'package:eraphilippines/app/widgets/search_widget.dart';
import 'package:eraphilippines/app/widgets/textformfield_widget.dart';
import 'package:eraphilippines/presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import '../../presentation/global.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../services/ai_search.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

//ignore: must_be_immutable
class FilteredSearchBox extends StatefulWidget {
  FilteredSearchBox({super.key});

  @override
  State<FilteredSearchBox> createState() => _FilteredSearchBoxState();
}

class _FilteredSearchBoxState extends State<FilteredSearchBox> {
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
  var selectedSubProperty = "".obs;
  var areaMin = TextEditingController();
  var areaMax = TextEditingController();
  var floorAreaMin = TextEditingController();
  var floorAreaMax = TextEditingController();
  var ppsqmMin = TextEditingController();
  var ppsqmMax = TextEditingController();
  var lotAreaMin = TextEditingController();
  var lotAreaMax = TextEditingController();
  var isForSale = 0.obs;
  var selectedLocation = RxnString();
  var selectedPriceRange = "".obs;
  var selectedPriceSearch = RxnString();
  var selectedPropertyTypeSearch = RxnString();
  var propertyTypeSearch = [
    //"Pre-selling",
    //"Residential",
    "Commercial",
    //"Rental",
    //"Auction",
  ];
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
  var priceSearch = [
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
  @override
  void initState(){
    super.initState();
    initSpeech();
  }
  initSpeech() async {
    speechEnabled = await speech.initialize();
  }
  void startListening() async {
    Timer? timer;
    await speech.listen(onResult: (result){
      aiSearchController.text = result.recognizedWords;
      setState(() {

      });
    });

  }
  aiSearch()async{
    var searchQuery = "";
    BaseController().showLoading();
    searchQuery = aiSearchController.text;
    var data = await AI(query: searchQuery).listingSearch();
    selectedIndex.value = 2;
    pageViewController = PageController(initialPage: 2);
    currentRoute = '/searchresult';
    Get.offAll(BaseScaffold(), binding: SearchResultBinding(), arguments: [data, searchQuery]);
  }
  @override
  Widget build(BuildContext context) {
    return BoxWidget.build(
      child: Column(
        children: [
          SizedBox(height: 10.h),
          if (!showFullSearch.value)
            SizedBox(
              height: 48.h,
              child: CupertinoTextField(
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w400, fontSize: 20.sp),
                controller: aiSearchController,
                placeholder: 'Use AI Search',
                prefix: Row(
                  children: [
                    SizedBox(width: 10.w,),
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
                      onTap: ()async{
                        await Permission.audio.request().isGranted;
                        if(speechStarted){
                          aiSearchController.text = "";
                          speechStarted = false;
                          speech.stop();
                          setState(() {

                          });
                        }else{
                          speechStarted = true;
                          setState(() {

                          });
                          if ( speechEnabled ) {
                            startListening();
                          }else{
                             await initSpeech();
                             startListening();
                          }
                        }
                      },
                      child: speechStarted ? Icon(Icons.hearing): Icon(Icons.mic,size: 25.sp,),
                    ),
                    SizedBox(width: 10.w,),
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
                    SizedBox(width: 10.w,),
                  ],
                ),
              ),
            ),
            // AppTextField(
            //     onPressed: () {},
            //     controller: aiSearchController,
            //     hint: 'Use AI Search',
            //     svgIcon: AppEraAssets.ai3,
            //     bgColor: AppColors.white,
            //     isSuffix: true,
            //     obscureText: false,
            //     suffixIcons: AppEraAssets.send,
            //     onSuffixTap: () async {
            //       var searchQuery = "";
            //       // data = await AI(query: aiSearchController.text).search();
            //       BaseController().showLoading();
            //       searchQuery = aiSearchController.text;
            //       var data = await AI(query: '').process2(q: searchQuery);
            //       selectedIndex.value = 2;
            //       pageViewController = PageController(initialPage: 2);
            //       currentRoute = '/searchresult';
            //       Get.offAll(BaseScaffold(), binding: SearchResultBinding(), arguments: [data, searchQuery]);
            //     }),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: () {
              expanded.value = !expanded.value;
              showFullSearch.value = !showFullSearch.value;
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
                            onChanged: (value) =>
                                selectedLocation.value = value!,
                            name: 'Location',
                            hintText: 'Select Location'),
                        AddListings.dropDownAddlistings1(
                            color: AppColors.white,
                            selectedItem: selectedPropertyTypeSearch,
                            Types: propertyTypeSearch,
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
                              fontSize: 18.sp,
                              color: AppColors.white,
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 50.h,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 21.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(99),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  alignment: Alignment.centerLeft,
                                  dropdownColor: AppColors.white,
                                  focusColor: AppColors.hint,
                                  iconEnabledColor: Colors.black,
                                  isExpanded: true,
                                  value: selectedPriceRange.value.isEmpty
                                      ? null
                                      : selectedPriceRange.value,
                                  hint: Align(
                                    alignment: Alignment.centerLeft,
                                    child: EraText(
                                      text: 'Select Price Range',
                                      textAlign: TextAlign.center,
                                      color: Colors.grey,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: '2',
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            child: TextformfieldWidget(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.h),
                                              controller: areaMin,
                                              hintText: 'Min Price',
                                              obscureText: false,
                                              color: AppColors.black,
                                              keyboardType:
                                                  TextInputType.number,
                                              borderSide: BorderSide.none,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: TextformfieldWidget(
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 10.h),
                                              controller: areaMax,
                                              hintText: 'Max Price',
                                              obscureText: false,
                                              color: AppColors.black,
                                              keyboardType:
                                                  TextInputType.number,
                                              borderSide: BorderSide.none,
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // String customPriceRange =
                                              //     '${areaMin.text} - ${areaMax.text}';

                                              // selectedPriceRange.value.isEmpty
                                              //     ? selectedPriceRange.value =
                                              //         customPriceRange
                                              //     : selectedPriceRange.value =
                                              //         selectedPriceRange
                                              //             .value;

                                              Get.back();
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      AppColors.hint
                                                          .withOpacity(0.5)),
                                            ),
                                            icon: Icon(Icons.check),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ...priceSearch.map((price) {
                                      return DropdownMenuItem<String>(
                                        value: price,
                                        child: EraText(
                                          text: price,
                                          color: AppColors.black,
                                        ),
                                      );
                                    }),
                                  ],
                                  onChanged: (value) {
                                    selectedPriceRange.value = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                          isForSale.value = value ?? 0;
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
                          height: 53.h,
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
                              openFilterDialog(
                                  subcategory: selectedSubProperty,
                                  bathrooms: bathrooms,
                                  bedrooms: bedrooms,
                                  garage: garage,
                                  floorAreaMax: floorAreaMax,
                                  floorAreaMin: floorAreaMin,
                                  ppsqmMin: ppsqmMin,
                                  ppsqmMax: ppsqmMax,
                                  areaMax: lotAreaMin,
                                  areaMin: lotAreaMax);
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
                          BaseController().showLoading();
                          var data;
                          var searchQuery = "aaaa";
                          if (isForSale.value == 1) {
                            data = await Database().getForSaleListing();
                            searchQuery = "All For Sale Listings";
                          } else if (isForSale.value == 2) {
                            data = await Database().getForRentListing();
                            searchQuery = "All For Rent Listings";
                          }
                          Query query = FirebaseFirestore.instance.collection('listings');
                          if (selectedLocation.value != null) {
                            query = query.where('location', isEqualTo: selectedLocation.value?.toLowerCase());
                          }
                          if (selectedPropertyTypeSearch.value != null) {
                            query = query.where('type', isEqualTo: selectedPropertyTypeSearch.value!.capitalizeFirst);
                          }
                          if (areaMin.text != "" && areaMax.text != "") {
                            query = query.where('price',
                                isGreaterThanOrEqualTo: areaMin.text.toInt());
                            query = query.where('price',
                                isLessThanOrEqualTo: areaMax.text.toInt());
                          }
                          if (selectedPriceRange.value != "") {
                            var price = selectedPriceRange.value.replaceAll(",", "").split(" - ");
                            query = query.where('price',
                                isGreaterThanOrEqualTo: price[0].contains('M')
                                    ? price[0].replaceAll("M", "").toInt() * 1000000
                                    : price[0].toInt());
                            query = query.where('price',
                                isLessThanOrEqualTo: price[1].contains('M')
                                    ? price[1].replaceAll("M", "").toInt() * 1000000
                                    : price[1].toInt());
                          }
                          if(areaMin.text != "" && areaMax.text != "" && selectedPriceRange.value == ""){
                            query = query.where('price',isLessThanOrEqualTo:areaMax.text);
                            query = query.where('price',isGreaterThanOrEqualTo:areaMin.text);
                          }
                          if (selectedSubProperty.value != "") {
                            query = query.where('sub_category',isLessThanOrEqualTo:selectedSubProperty.value.toLowerCase());
                          }
                          if (bedrooms.value != 0) {
                            query = query.where('beds',isLessThanOrEqualTo:bedrooms.value);
                          }
                          if (bathrooms.value != 0) {
                            query = query.where('baths',isLessThanOrEqualTo:bathrooms.value);
                          }
                          if (garage.value != 0) {
                            query = query.where('garage',isLessThanOrEqualTo:garage.value);
                          }
                          if (ppsqmMin.text.isNotEmpty &&
                              ppsqmMax.text.isNotEmpty) {
                            query = query.where('ppsqm',isLessThanOrEqualTo:ppsqmMax.text.toInt());
                            query = query.where('ppsqm',isGreaterThanOrEqualTo:ppsqmMin.text.toInt());
                          }
                          if (floorAreaMax.text.isNotEmpty &&
                              floorAreaMin.text.isNotEmpty) {
                            query = query.where('floor_area',isLessThanOrEqualTo:floorAreaMax.text.toInt());
                            query = query.where('floor_area',isGreaterThanOrEqualTo:floorAreaMin.text.toInt());
                          }
                          if (lotAreaMin.text.isNotEmpty &&
                              lotAreaMax.text.isNotEmpty) {
                            query = query.where('area',isLessThanOrEqualTo:lotAreaMin.text.toInt());
                            query = query.where('area',isGreaterThanOrEqualTo:lotAreaMax.text.toInt());
                          }
                          data =
                              (await query.get()).docs.map((QueryDocumentSnapshot doc) {
                                return doc.data();
                              }).toList();
                          //print(listings);
                          // if (listings.isNotEmpty && isForSale.value == 0) {
                          //   data = await EraFunctions.filter(listings, filters);
                          // } else if (isForSale.value == 0) {
                          //   BaseController().showSuccessDialog(
                          //       title: "Error",
                          //       description:
                          //           "No results found or invalid filter/s!",
                          //       hitApi: () {
                          //         Get.back();
                          //         Get.back();
                          //       });
                          // }

                          selectedIndex.value = 2;
                          pageViewController = PageController(initialPage: 2);
                          currentRoute = '/searchresult';
                          Get.offAll(BaseScaffold(),
                              binding: SearchResultBinding(),
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
    );
  }
}
