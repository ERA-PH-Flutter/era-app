import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum ContactState {
  loading,
  loaded,
  error,
}

class ContactusController extends GetxController {
  var store = Get.find<LocalStorageService>();

  TextEditingController username = TextEditingController();
}
