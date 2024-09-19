import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum SellPropertyState { loading, loaded, error, empty }

class SellPropertyAController extends GetxController {
  var sellPropertySate = SellPropertyState.loading.obs;
  var sellProperty = <Map<String, String>>[].obs;
  RxList images = [].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController propertyTypeController = TextEditingController();
  TextEditingController propertyLocController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void addSellProperty() {
    sellProperty.add({
      'name': nameController.text,
      'phone': phoneNumController.text,
      'email': emailController.text,
      'proertyType': propertyTypeController.text,
      'proertyLoc': priceController.text,
      'price': priceController.text,
      'description': descriptionController.text,
    });
  }

  void sellPropertyRemove(int index) {
    sellProperty.removeAt(index);
  }
}
