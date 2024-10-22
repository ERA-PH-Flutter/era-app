import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../app/services/ai_search.dart';
import '../../../../app/services/firebase_database.dart';
import '../../../global.dart';

enum AgentsState { loading, loaded, empty, error, blank, noFeaturedAgent }

class AgentsController extends GetxController with BaseController {
  var sortOption = 'name_ascending'.obs;
  var isAscending = true.obs;
  var filterName = ''.obs;
  var date = DateTime.now().obs;
  var agentState = AgentsState.loading.obs;
  var resultText = "".obs;
  var results = [].obs;
  var agentCount = [].obs;
  var count = 10.obs;
  var pageSize = 1;
  var selectedLocation = RxnString();
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
    pageSize = count.value;
    try {
      var randomUser = (await FirebaseFirestore.instance
              .collection('users')
              .where('status', isEqualTo: 'approved')
              .get())
          .docs;
      randomUser.shuffle();
      for (int i = 0;
          i < (randomUser.length > 6 ? 6 : randomUser.length);
          i++) {
        results.add(EraUser.fromJSON(randomUser[i].data()));
      }
      agentState.value = AgentsState.loaded;
    } catch (e) {
      agentState.value = AgentsState.error;
    }
    super.onInit();
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'UcbQCfRCoeA',
      flags: YoutubePlayerFlags(
        enableCaption: false,
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    );
  }

  aiSearch(query) async {
    BaseController().showLoading();
    results.clear();
    resultText.value = "SEARCH RESULTS";
    agentState.value = AgentsState.loading;
    var aiSearchResult = await AI(query: query).userSearch();
    if (aiSearchResult.isNotEmpty) {
      aiSearchResult.forEach((user) {
        if (user.data()['status'] == "approved") {
          results.add(EraUser.fromJSON(user.data()));
        }
      });
    }
    BaseController().hideLoading();
    if (results.isNotEmpty) {
      agentState.value = AgentsState.loaded;
    } else {
      agentState.value = AgentsState.empty;
    }
  }

  search() async {
    results.clear();
    resultText.value = "SEARCH RESULTS";
    agentState.value = AgentsState.loading;
    showLoading();
    if (agentName.text != "") {
      results.value = (await Database().searchUser(
              searchParam: 'full_name', searchQuery: agentName.text)) ??
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
            agentState.value = AgentsState.error;
            Get.back();
          },
          title: "Error!",
          description: "Empty Search Fields!");
    }
    if (results.isNotEmpty) {
      agentState.value = AgentsState.loaded;
    } else {
      agentState.value = AgentsState.empty;
    }
  }

  final picker = ImagePicker();
  Rx<File?> image = Rx<File?>(null);
  final removeImage = false.obs;

  Future<void> getImageGallery() async {
    try {
      final List<XFile> imagePicks = await picker.pickMultiImage();
      if (imagePicks.isNotEmpty) {
        showLoading();
        image.value = File(imagePicks[0].path);
        try {
          await FirebaseStorage.instance
              .ref('users/images/${user!.id}.png')
              .delete();
        } catch (e) {
          print(e);
        }
        var im = await CloudStorage().upload(
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
        image.value = File(imagePick.path);
        try {
          await FirebaseStorage.instance
              .ref('users/images/${user!.id}.png')
              .delete();
        } catch (e) {
          print(e);
        }
        await CloudStorage().deleteFileDirect(docRef: previousPicture);
        var im = await CloudStorage().upload(
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
}
