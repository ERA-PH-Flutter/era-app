import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum FaqsState { loading, loaded, error, empty }

class FaqsController extends GetxController {
  var faqsSate = FaqsState.loading.obs;
  var faqs = <Map<String, String>>[].obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  void addFAQ() {
    faqs.add({
      'title': titleController.text,
      'type': typeController.text,
      'answer': answerController.text,
    });
  }

  void editFAQ(int index) {
    faqs[index] = {
      'title': titleController.text,
      'type': typeController.text,
      'answer': answerController.text,
    };
  }

  void faqRemove(int index) {
    faqs.removeAt(index);
  }

  // getFAQs() {
  //   if
  // }
}
