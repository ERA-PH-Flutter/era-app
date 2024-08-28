import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum MortageCalculatorState {
  loading,
  loaded,
  error,
}

class MortageCalculatorController extends GetxController {
  var store = Get.find<LocalStorageService>();

  TextEditingController propertyAmount = TextEditingController();
  TextEditingController downPayment = TextEditingController();
  TextEditingController loanTerm = TextEditingController();
  TextEditingController interestRate = TextEditingController();
  TextEditingController monthlyP = TextEditingController();
}
