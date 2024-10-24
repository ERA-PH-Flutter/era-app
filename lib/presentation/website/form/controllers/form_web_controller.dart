import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../../../app/services/local_storage.dart';
import '../../../agent/utility/controller/base_controller.dart';

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
  //contact us
  TextEditingController usernameC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController numberC = TextEditingController();
  TextEditingController emailAC = TextEditingController();
  TextEditingController messageC = TextEditingController();
  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

  var selectedSubj = RxnString();

  var subject = [
    'General Inquiry',
    'Sales',
    'Tech Support',
  ];

  submitContact() async {
    print("a");
    try {
      var contactDoc =
          FirebaseFirestore.instance.collection('contact_us').doc();
      await contactDoc.set({
        'id': contactDoc.id,
        'name': nameC.text,
        'contact_number': numberC.text,
        'email': emailAC.text,
        'message': messageC.text,
        'type': selectedSubj.value
      });
      BaseController().showSuccessDialog(
          title: "Success",
          description: "Wait for an admin to contact you!",
          hitApi: () {
            nameC.clear();
            numberC.clear();
            emailAC.clear();
            messageC.clear();
            selectedSubj.value = null;
            Get.back();
          });
    } catch (e, ex) {
      print(ex);
    }
  }
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
