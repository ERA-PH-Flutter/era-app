import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ContactUsAController extends GetxController {
  var contactusInfo = <Map<String, String>>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController subjectTypeController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  void addSellProperty() {
    contactusInfo.add({
      'name': nameController.text,
      'phone': phoneNumController.text,
      'email': emailController.text,
      'subjectType': subjectTypeController.text,
      'message': messageController.text,
    });
  }

  void contactusRemove(int index) {
    contactusInfo.removeAt(index);
  }
}
