import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import '../../../app/services/local_storage.dart';

enum ListingState {
  loading,
  loaded,
  error,
}

class ListingController extends GetxController {
  var store = Get.find<LocalStorageService>();

  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
  var isClicked = false.obs;



  // var  currentPage   = 0.obs;

  // var totalPages = 10.obs;

  // void onPageChanged(index) {
  //   currentPage.value = index;
  // }
}
