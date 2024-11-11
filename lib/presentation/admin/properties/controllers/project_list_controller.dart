import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/project.dart';

enum ProjectsListState {
  loading,
  loaded,
  error,
  empty,
}

class ProjectsListController extends GetxController {
  var store = Get.find<LocalStorageService>();
  ScrollController scrollController = ScrollController();

  var projectsListState = ProjectsListState.loading.obs;
  var projects = [].obs;
  RxInt count = 5.obs;
  int pageSize = 0;
  @override
  void onInit() async {
  
    pageSize = count.value;
    projects.value = (await FirebaseFirestore.instance
            .collection('projects')
            .orderBy('order_id')
            .get())
        .docs
        .map((doc) {
      return Project.fromJSON(doc.data());
    }).toList();
    projectsListState.value = ProjectsListState.loaded;
    super.onInit();
  }

  var selectedPropertyType = RxnString();
  var selectedLocation = RxnString();
  var selectedDeveloper = RxnString();

  var developerType = [
    "Shang Properties",
  ];
}
