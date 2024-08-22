import 'package:eraphilippines/presentation/agent/utility/controller/base_controller.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../app/services/firebase_database.dart';
import '../../../global.dart';

enum AgentsState {loading,loaded,empty,error,blank}
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
        agentState.value = AgentsState.empty;
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
      results.value = (await Database().searchUser(searchParam: 'era_id',searchQuery: agentName.text)) ?? [];
      hideLoading();
    }else if(agentLocation.text != ""){
      results.value = (await Database().searchUser(searchParam: 'location',searchQuery: agentName.text)) ?? [];
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
}

  // final List<String> sortOptions = ['name_ascending', 'name_descending'];

  // List<RealEstateListing> applyFiltersAndSorting(
  //     List<RealEstateListing> listings, AgentsController controller) {
  //   if (sortOption.value.contains('name')) {
  //     listings.sort(
  //         (a, b) => (a.user.firstname ?? '').compareTo(b.user.firstname ?? ''));
  //   }

  //   if (!controller.isAscending.value) {
  //     listings = listings.reversed.toList();
  //   }

  //   return listings;
  // }

  // void updateFilterName(String name) {
  //   filterName.value = name;
  // }

  // void updateDate(DateTime newDate) {
  //   date.value = newDate;
  // }