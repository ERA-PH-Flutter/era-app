import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../global.dart';

enum AgentsStateWeb { loading, loaded, empty, error, blank, noFeaturedAgent }

class AgentsWebController extends GetxController with BaseController {
  var sortOption = 'name_ascending'.obs;
  var isAscending = true.obs;
  var filterName = ''.obs;
  var date = DateTime.now().obs;
  var agentState = AgentsStateWeb.loading.obs;
  var resultText = "".obs;
  var results = [].obs;
  var agentCount = [].obs;
  var selectedLocation = RxnString();
  var agentNameObs = "".obs;
  var aiObs = "".obs;
  TextEditingController agentId = TextEditingController();
  TextEditingController agentLocation = TextEditingController();
  TextEditingController agentName = TextEditingController();
  late YoutubePlayerController youtubePlayerController;

  void toggleSortDirection() {
    isAscending.value = !isAscending.value;
    updateSortOption(isAscending.value ? 'name_ascending' : 'name_descending');
  }

  void updateSortOption(String newSortOption) {
    sortOption.value = newSortOption;
  }

  @override
  void onInit() async {
    image.value = ((await CloudStorage().getFileBytes(
        docRef:
            (await EraUser().getById(FirebaseAuth.instance.currentUser?.uid))
                    .image ??
                AppStrings.noUserImageWhite))!);
    try {
      // var allUser = (await FirebaseFirestore.instance
      //         .collection('users')
      //         .where('status', isEqualTo: 'approved')
      //         .get())
      //     .docs;

      // results.addAll(allUser.map((e) => EraUser.fromJSON(e.data())));

      //agentState.value = AgentsStateWeb.loaded;

      var allUser = (await FirebaseFirestore.instance
              .collection('users')
              .where('status', isEqualTo: 'approved')
              .get())
          .docs;

      results.addAll(allUser.map((e) => EraUser.fromJSON(e.data())));
      agentState.value =
          results.isNotEmpty ? AgentsStateWeb.loaded : AgentsStateWeb.empty;
    } catch (e) {
      agentState.value = AgentsStateWeb.error;
    }
    agentState.value = AgentsStateWeb.loaded;
    super.onInit();
  }

  aiSearch(query) async {
    results.clear();
    resultText.value = "SEARCH RESULTS";
    agentState.value = AgentsStateWeb.loading;
    var aiSearchResult = await AI(query: query).userSearch();
    if (aiSearchResult.isNotEmpty) {
      aiSearchResult.forEach((user) {
        if (user.data()['status'] == "approved") {
          results.add(EraUser.fromJSON(user.data()));
        }
      });
    }

    if (results.isNotEmpty) {
      agentState.value = AgentsStateWeb.loaded;
    } else {
      agentState.value = AgentsStateWeb.empty;
    }
  }

  search() async {
    results.clear();
    resultText.value = "SEARCH RESULTS";
    agentState.value = AgentsStateWeb.loading;
    showLoading();
    if (agentName.value != "") {
      results.value = (await Database().searchUser(
              searchParam: 'full_name', searchQuery: agentName.value)) ??
          [];
      hideLoading();
    } else if (agentId.text != "") {
      results.value = (await Database()
              .searchUser(searchParam: 'era_id', searchQuery: agentId.text)) ??
          [];
      hideLoading();
    } else if (selectedLocation.value != "") {
      results.value = (await Database().searchUser(
              searchParam: 'location', searchQuery: selectedLocation.value)) ??
          [];
      hideLoading();
    } else {
      hideLoading();
      await showSuccessDialog(
          hitApi: () {
            agentState.value = AgentsStateWeb.error;
            Get.back();
          },
          title: "Error!",
          description: "Empty Search Fields!");
    }
    if (results.isNotEmpty) {
      agentState.value = AgentsStateWeb.loaded;
    } else {
      agentState.value = AgentsStateWeb.empty;
    }
  }

  final picker = ImagePicker();
  Rx<Uint8List?> image = Rx<Uint8List?>(null);
  final removeImage = false.obs;

  Future<void> getImageGallery() async {
    try {
      final List<XFile>? imagePicks = await picker.pickMultiImage();
      if (imagePicks != null && imagePicks.isNotEmpty) {
        showLoading();
        image.value = await imagePicks[0].readAsBytes();
        try {
          var ref = await FirebaseStorage.instance
              .ref('users/images/${user!.id}.png')
              .delete();
        } catch (e, ex) {
          print('settings error: $e');
        }
        var im = await CloudStorage().uploadFromMemory(
            file: image.value!,
            target: 'users/images',
            customName: '${user!.id}.png');

        user!.image = im;
        await user!.update();
        showSuccessDialog(
            description: "Change profile image success!",
            title: "Success",
            hitApi: () {
              Get.back();
              Get.back();
              Get.back();
            });
      }
    } on PlatformException catch (e) {
      showErroDialog(description: "Failed to pick image: ${e.message}");
    }
  }

  Future<void> getImagePic(previousPicture) async {
    try {
      final XFile? imagePick =
          await picker.pickImage(source: ImageSource.camera);

      if (imagePick != null) {
        image.value = await File(imagePick.path).readAsBytes();
        try {
          var ref = await FirebaseStorage.instance
              .ref('users/images/${user!.id}.png')
              .delete();
        } catch (e) {
          print(e);
        }
        try {
          await CloudStorage().deleteFileDirect(docRef: previousPicture);
        } catch (e) {
          print("settings error: $e");
        }
        var im = await CloudStorage().uploadFromMemory(
            file: image.value!,
            target: 'users/images',
            customName: '${user!.id}.png');
        user!.image = im;
        await user!.update();
        showSuccessDialog(
            description: "Change profile image success!",
            title: "Success",
            hitApi: () {
              Get.offAndToNamed('/settings');
            });
      }
    } on PlatformException catch (e) {
      showErroDialog(description: "Failed to pick image: ${e.message}");
    }
  }
}
