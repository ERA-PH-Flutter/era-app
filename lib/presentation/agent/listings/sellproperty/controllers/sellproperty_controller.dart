import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum SellState { loading, loaded, error, empty }

class SellPropertyController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var sellState = SellState.loading.obs;
  @override
  void onInit() {
    sellState.value = SellState.loaded;
    super.onInit();
  }

  var selectedProperty = RxnString();
  var propertyTypes = [
    'Pre-Selling',
    'Residential',
    'Commercial',
    'Rental',
    'Auction'
  ];
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController emailAd = TextEditingController();
  TextEditingController propertyType = TextEditingController();
  TextEditingController propertyLocation = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController desc = TextEditingController();

  var images = [].obs;
}
