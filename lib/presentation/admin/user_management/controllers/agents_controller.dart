import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/presentation/admin/user_management/pages/pages/add-agent.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/logs.dart';
import '../../../global.dart';

enum AgentAdminState {
  loading,
  loaded,
  error,
}

class AgentAdminController extends GetxController with BaseController {
  var store = Get.find<LocalStorageService>();
  var results = [].obs;
  var resultText = "".obs;

  var agentState = AgentAdminState.loading.obs;
  @override
  void onInit() async {
    try {
      var randomUser =
          (await FirebaseFirestore.instance.collection('users').get()).docs;

      randomUser.shuffle();
      for (int i = 0;
          i < (randomUser.length > 6 ? 6 : randomUser.length);
          i++) {
        results.add(EraUser.fromJSON(randomUser[i].data()));
      }
      agentState.value = AgentAdminState.loaded;
    } catch (e) {
      agentState.value = AgentAdminState.error;
    }
    super.onInit();
  }

  RealEstateListing? agentListings;

  EraUser? agentListingssss;

  List<Listing> listings = [];

  var images;
  final picker = ImagePicker();
  final removeImage = false.obs;
  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream = FirebaseFirestore
      .instance
      .collection('users')
      .orderBy('full_name')
      .snapshots();

  var agentType = ['ASC', 'AMM', 'MM', 'SMM', 'MD', 'SMD', 'ADD', 'BDD'];
  var selectedAgentType = RxnString();

  var agentRole = [
    'ERA Agent',
    'ERA Broker',
    'ERA Infinity Agent',
    'ERA Infinity Broker'
  ];
  var selectedAgentRole = RxnString();

  var selectedGender = RxnString();
  var agentGender = ['Male', 'Female'];
  // edit agent
  TextEditingController fNameA = TextEditingController();
  TextEditingController lNameA = TextEditingController();
  TextEditingController emailAdressA = TextEditingController();
  TextEditingController dateBirthA = TextEditingController();
  TextEditingController sexA = TextEditingController();
  TextEditingController locationA = TextEditingController();
  TextEditingController licenseNA = TextEditingController();
  TextEditingController phoneNA = TextEditingController();
  TextEditingController passwordA = TextEditingController();
  TextEditingController confirmPA = TextEditingController();
  TextEditingController positionA = TextEditingController();
  TextEditingController descriptionA = TextEditingController();
  TextEditingController officeLA = TextEditingController();
  TextEditingController licensedNumA = TextEditingController();
  TextEditingController parking = TextEditingController();
  TextEditingController age = TextEditingController();
//add agent
  TextEditingController addfNameA = TextEditingController();
  TextEditingController addlNameA = TextEditingController();
  TextEditingController addemailAdressA = TextEditingController();
  TextEditingController adddateBirthA = TextEditingController();
  TextEditingController addsexA = TextEditingController();
  TextEditingController addlocationA = TextEditingController();
  TextEditingController addlicenseNA = TextEditingController();
  TextEditingController addphoneNA = TextEditingController();
  TextEditingController addpasswordA = TextEditingController();
  TextEditingController addconfirmPA = TextEditingController();
  TextEditingController addpositionA = TextEditingController();
  TextEditingController adddescriptionA = TextEditingController();
  TextEditingController addofficeLA = TextEditingController();
  TextEditingController addlicensedNumA = TextEditingController();
  TextEditingController addparking = TextEditingController();
  TextEditingController addage = TextEditingController();
  var addselectedGender = RxnString();
  var addagentGender = ['Male', 'Female'];

  var addagentType = ['ASC', 'AMM', 'MM', 'SMM', 'MD', 'SMD', 'ADD', 'BDD'];
  var addselectedAgentType = RxnString();
  var addselectedAgentRole = RxnString();

  var addagentRole = [
    'ERA Agent',
    'ERA Broker',
    'ERA Infinity Agent',
    'ERA Infinity Broker'
  ];

// roster
  TextEditingController message = TextEditingController();
  TextEditingController title = TextEditingController();
  //find agent text field
  TextEditingController fname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController emailAdress = TextEditingController();

  clearfieldEditAgents() {
    print('Clearing fields...');

    addfNameA.clear();
    addlNameA.clear();
    addemailAdressA.clear();
    adddateBirthA.clear();
    addsexA.clear();
    addlocationA.clear();
    addlicenseNA.clear();
    addphoneNA.clear();
    addpasswordA.clear();
    addconfirmPA.clear();
    addpositionA.clear();
    adddescriptionA.clear();
    addofficeLA.clear();
    addlicensedNumA.clear();
    addparking.clear();
    addselectedAgentType.value = null;
    addage.clear();
    addselectedAgentRole.value = null;
    addselectedGender.value = null;
  }

  clearfield() {
    fNameA.clear();
    lNameA.clear();
    emailAdressA.clear();
    dateBirthA.clear();
    sexA.clear();
    locationA.clear();
    licenseNA.clear();
    phoneNA.clear();
    passwordA.clear();
    confirmPA.clear();
    positionA.clear();
    descriptionA.clear();
    officeLA.clear();
    licensedNumA.clear();
    parking.clear();
    selectedAgentType.value = null;
  }

  clearFindAgentsField() {
    phoneNumber.clear();
    fname.clear();
    emailAdress.clear();
  }

  setValues(EraUser user) {
    agentListingssss = user;
    fNameA.text = user.firstname!;
    lNameA.text = user.lastname!;
    emailAdressA.text = user.email!;
    //dateBirthA.text = user.birthday ?? "";
    //sexA.text = user.gender!;
    selectedAgentType.value = user.role!;

    locationA.text = user.location!;
    phoneNA.text = user.whatsApp!;
    passwordA.text = "eraaccount";
    confirmPA.text = "eraaccount";
    positionA.text = user.position!;
    descriptionA.text = user.description!;
    officeLA.text = user.office ?? "";
    licensedNumA.text = user.licence ?? "";
    selectedAgentType.value = user.position ?? "ASC";
  }

  updateValues() async {
    //agentListingssss!.birthday = dateBirthA.text;
    agentListingssss!.firstname = fNameA.text;
    agentListingssss!.lastname = lNameA.text;
    agentListingssss!.eraId = emailAdressA.text;
    //agentListingssss!.gender = sexA.text;
    agentListingssss!.location = locationA.text;
    agentListingssss!.licence = licensedNumA.text;
    agentListingssss!.whatsApp = phoneNA.text;
    agentListingssss!.position = selectedAgentType.value;
    agentListingssss!.role = selectedAgentRole.value;
    agentListingssss!.description = descriptionA.text;
    agentListingssss!.office = officeLA.text;
    await agentListingssss!.update();
    await Logs(
            title:
                "${user!.firstname} ${user!.lastname} edited an agent with ID ${agentListingssss!.eraId}",
            type: "account")
        .add();
  }
//create listing controller

  // TextEditingController officeLA = TextEditingController();

  Future getImageGallery() async {
    try {
      final imagePick = await picker.pickImage(source: ImageSource.gallery);
      if (imagePick != null) {
        images = File(imagePick.path);
      }
    } on PlatformException catch (e) {
      return e;
    }
  }

  removeAt(int index) {
    images.removeAt(index);

    if (images.isEmpty) {}
  }

  removeMode() {
    removeImage.value = !removeImage.value;
  }

  clearImage() {
    images.clear();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getStream({status = 'approved'}) {
    if (fname.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('users')
          .where('full_name', isGreaterThanOrEqualTo: fname.text)
          .where('full_name', isLessThanOrEqualTo: '${fname.text}\uf8ff')
          .where('status', isEqualTo: status)
          .orderBy('full_name')
          .snapshots();
    } else if (phoneNumber.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('users')
          .where('phone', isEqualTo: phoneNumber.text)
          .where('status', isEqualTo: status)
          .snapshots();
    } else if (emailAdress.text.isNotEmpty) {
      return FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: emailAdress.text)
          .where('status', isEqualTo: status)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('users')
          .orderBy('full_name')
          .where('status', isEqualTo: status)
          .snapshots();
    }
  }
}
