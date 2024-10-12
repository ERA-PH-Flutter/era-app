import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LogListAdminController extends GetxController {
  var selectedFilter = 'all'.obs;
  var stream = FirebaseFirestore.instance.collection('logs').orderBy('date_created').snapshots().obs;
  var initialDate = DateTime.now().obs;
  var nextDate = DateTime(2024,1,1).obs;
}
