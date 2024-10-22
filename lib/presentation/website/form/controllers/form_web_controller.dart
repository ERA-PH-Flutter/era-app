import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../app/services/local_storage.dart';

// enum BuyWebState { loading, loaded, error, empty }

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

class FormWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  //var buylandingState = BuyWebState.loading.obs;

  var isCheckedYes = false.obs;
  var isCheckedNotNow = false.obs;

  late YoutubePlayerController youtubePlayerController;
  TextEditingController name = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController emailAd = TextEditingController();
  TextEditingController message = TextEditingController();
  var selectedValue = RxnString();

  var items = [
    'Agent',
    'Broker',
  ];
  // @override
  // void onInit() {
  //   buylandingState.value = BuyWebState.loaded;
  //   super.onInit();
  // }

  // @override
  // void onInit() {
  //   super.onInit();
  //   youtubePlayerController = YoutubePlayerController(
  //     initialVideoId: 'UcbQCfRCoeA',
  //     flags: YoutubePlayerFlags(
  //       autoPlay: true,
  //       mute: false,
  //     ),
  //   );
  // }
}
