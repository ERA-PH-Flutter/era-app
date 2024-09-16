import 'dart:typed_data';

import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../app/services/local_storage.dart';

enum NewsState { loading, loaded, error, empty }

// enum AdminSection {
//   agentProfile,
//   addAgent,
//   approvedAgents,
//   roster,
//   addProject,
//   propertyList,
//   propertyInfo,
//   addProperty,
// //    editProperty,
//   homepage,
//   aboutUs,
// }

class NewsController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var newsState = NewsState.loading.obs;
  var arguments = [];
  // var selectedSection = AdminSection.homepage.obs;
  var selectedSectionIndex = 0.obs;
  var news = [];
  Rx<Uint8List>? selectedNewsImage;
  final OverlayPortalController menu = OverlayPortalController();
  getNews() async {
    if (settings!.featuredNews!.isNotEmpty) {
      for (int i = 0; i < settings!.featuredNews!.length; i++) {
        settings!.featuredNews![i] != ''
            ? news.add(await News(id: settings!.featuredNews![i]).getNews())
            : null;
      }
    }
  }
  @override
  void onInit() {
    newsState.value = NewsState.loaded;
    super.onInit();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController content = TextEditingController();
}
