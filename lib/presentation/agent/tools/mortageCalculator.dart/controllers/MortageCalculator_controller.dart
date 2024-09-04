import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum MortageCalculatorState {
  loading,
  loaded,
  error,
}

class MortageCalculatorController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var monthlyAmount = 1.0.obs;
  var initialAmount = 1.0.obs;
  var interestAmount = 1.0.obs;
  TextEditingController propertyAmount = TextEditingController();
  TextEditingController downPayment = TextEditingController();
  TextEditingController loanTerm = TextEditingController();
  TextEditingController interestRate = TextEditingController();
  TextEditingController monthlyP = TextEditingController();
  void reset() {
    propertyAmount.clear();
    downPayment.clear();
    loanTerm.clear();
    interestRate.clear();
    monthlyP.clear();
  }
}
