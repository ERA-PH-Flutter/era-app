import 'dart:io';

import 'package:eraphilippines/app/services/firebase_storage.dart';
import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../app/services/firebase_database.dart';
import '../../../global.dart';

enum AgentsState {loading,loaded,empty,error,blank,noFeaturedAgent}
class AgentsController extends GetxController with BaseController{

  var sortOption = 'name_ascending'.obs;
  var isAscending = true.obs;
  var filterName = ''.obs;
  var date = DateTime.now().obs;
  var agentState = AgentsState.loading.obs;
  var resultText = "FEATURED AGENTS".obs;
  var results = [].obs;
  TextEditingController agentId = TextEditingController();
  TextEditingController agentLocation = TextEditingController();
  TextEditingController agentName = TextEditingController();

  void toggleSortDirection() {
    isAscending.value = !isAscending.value;
    updateSortOption(isAscending.value ? 'name_ascending' : 'name_descending');
  }

  void updateSortOption(String newSortOption) {
    sortOption.value = newSortOption;
  }

  @override
  void onInit() {
    try{
      var agents = settings!.featuredAgents ?? [];

      if(agents.isNotEmpty){
        agents.forEach((agent) async {
          results.add(await EraUser().getById(agent));
        });
        agentState.value = AgentsState.loaded;
      }else{
        agentState.value = AgentsState.noFeaturedAgent;
      }
    }catch(e){
      agentState.value = AgentsState.error;
    }
    super.onInit();
  }

  search()async{
    results.clear();
    resultText.value = "SEARCH RESULTS";
    agentState.value = AgentsState.loading;
    showLoading();
    if(agentName.text != ""){
      results.value = (await Database().searchUser(searchParam: 'full_name',searchQuery: agentName.text)) ?? [];
      hideLoading();
    }else if(agentId.text != ""){
      results.value = (await Database().searchUser(searchParam: 'era_id',searchQuery: agentId.text)) ?? [];
      hideLoading();
    }else if(agentLocation.text != ""){
      results.value = (await Database().searchUser(searchParam: 'location',searchQuery: agentLocation.text)) ?? [];
      hideLoading();
    }else{
      hideLoading();
      await showSuccessDialog(hitApi: (){
        agentState.value = AgentsState.error;
        Get.back();
      },title: "Error!",description: "Empty Search Fields!");
    }
    if(results.isNotEmpty){
      agentState.value = AgentsState.loaded;
    }else{
      agentState.value = AgentsState.empty;
    }
  }

  final picker = ImagePicker();
  Rx<File?> image = Rx<File?>(null);
  final removeImage = false.obs;

  Future<void> getImageGallery() async {
    try {
      final List<XFile>? imagePicks = await picker.pickMultiImage();
      if (imagePicks != null && imagePicks.isNotEmpty) {
        showLoading();
        image.value = File(imagePicks[0].path);
        try{
          var ref = await FirebaseStorage.instance.ref('users/images/${user!.id}.png').delete();
        }catch(e){
          print(e);
        }
        var im = await CloudStorage().upload(file: image.value!, target: 'users/images',customName: '${user!.id}.png');

        user!.image = im;
        await user!.update();
        showSuccessDialog(description: "Change profile image success!",title: "Success",hitApi: (){
          Get.back();Get.back();Get.back();
        });
      }
    } on PlatformException catch (e) {
      showErroDialog(description: "Failed to pick image: ${e.message}");
    }
  }

  Future<void> getImagePic() async {
    try {
      final XFile? imagePick =
          await picker.pickImage(source: ImageSource.camera);

      if (imagePick != null) {
        image.value = File(imagePick.path);
        try{
          var ref = await FirebaseStorage.instance.ref('users/images/${user!.id}.png').delete();
        }catch(e){
          print(e);
        }
        var im = await CloudStorage().upload(file: image.value!, target: 'users/images',customName: '${user!.id}.png');
        user!.image = im;
        await user!.update();
        showSuccessDialog(description: "Change profile image success!",title: "Success",hitApi: (){
          Get.back();Get.back();Get.back();
        });
      }
    } on PlatformException catch (e) {
      showErroDialog(description: "Failed to pick image: ${e.message}");
    }
  }
}
 