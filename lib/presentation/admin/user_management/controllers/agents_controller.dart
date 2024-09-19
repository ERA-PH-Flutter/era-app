import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/app/models/realestatelisting.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/listing.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../app/services/local_storage.dart';

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
  Stream<QuerySnapshot<Map<String, dynamic>>> searchStream = FirebaseFirestore.instance.collection('users').orderBy('full_name').snapshots();

  var agentType = ['ASC', 'AMM', 'MM', 'SMM', 'MD', 'SMD', 'ADD', 'BDD'];
  var selectedAgentType = RxnString();

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

// roster
  TextEditingController message = TextEditingController();
  TextEditingController title = TextEditingController();

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
  setValues(EraUser user){
    agentListingssss = user;
    fNameA.text = user.firstname!;
    lNameA.text = user.lastname!;
    emailAdressA.text = user.email!;
    dateBirthA.text = user.birthday ?? "";
    sexA.text = user.gender!;
    locationA.text = user.location!;
    phoneNA.text = user.whatsApp!;
    passwordA.text = "eraaccount";
    confirmPA.text = "eraaccount";
    positionA.text = user.position!;
    descriptionA.text = user.description!;
    officeLA.text = user.office ?? "";
    licensedNumA.text = user.licence?? "";
    selectedAgentType.value = user.position ?? "ASC";
  }
  updateValues()async{
    agentListingssss!.birthday = dateBirthA.text;
    agentListingssss!.firstname = fNameA.text;
    agentListingssss!.lastname = lNameA.text;
    agentListingssss!.eraId = emailAdressA.text;
    agentListingssss!.gender = sexA.text;
    agentListingssss!.location = locationA.text;
    agentListingssss!.licence = licensedNumA.text;
    agentListingssss!.whatsApp = phoneNA.text;
    agentListingssss!.position = selectedAgentType.value;
    agentListingssss!.description = descriptionA.text;
    agentListingssss!.office = officeLA.text;
    await agentListingssss!.update();
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

    if (images.isEmpty) {
      print("itsfine");
    }
  }

  removeMode() {
    removeImage.value = !removeImage.value;
  }

  clearImage() {
    images.clear();
  }
  Stream<QuerySnapshot<Map<String, dynamic>>> getStream(){
    if(fNameA.text.isNotEmpty){
      return  FirebaseFirestore.instance.collection('users').where('full_name',isGreaterThanOrEqualTo: fNameA.text)
          .where('full_name', isLessThanOrEqualTo:  '${fNameA.text}\uf8ff').orderBy('full_name').snapshots();
    }else if(phoneNA.text.isNotEmpty){
      return  FirebaseFirestore.instance.collection('users').where('phone',isEqualTo: emailAdressA.text).snapshots();
    }else if(emailAdressA.text.isNotEmpty){
      return  FirebaseFirestore.instance.collection('users').where('email',isEqualTo: emailAdressA.text).snapshots();
    }else{
      return  FirebaseFirestore.instance.collection('users').orderBy('full_name').snapshots();
    }
  }
}
