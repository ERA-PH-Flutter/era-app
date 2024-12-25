import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';

enum AgentListingsState { loading, loaded, error, empty }

class AgentListingsWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var agentListingsState = AgentListingsState.loading.obs;
  var sortBy = 'date'.obs;
  var sortOrder = 'asc'.obs;
  var user;
  String? userID;
  List<Listing> listings = [];
  var data = [].obs;
  @override
  void onInit() async {
    // print("arguments: ${Get.arguments}");
    // print("args ${Get.arguments}");
    //print(idArgument);
    loadListing();
    super.onInit();
  }

  loadListing() async {
    user = await EraUser().getById(userID ?? FirebaseAuth.instance.currentUser!.uid); // changed the arguments not sure if it will affect anything
    listings = (await Database().searchListingsByUserId(idArgument ?? FirebaseAuth.instance.currentUser!.uid));
    if (listings.isEmpty) {
      agentListingsState.value = AgentListingsState.empty;
    } else {
      agentListingsState.value = AgentListingsState.loaded;
    }


    // user = await EraUser().getById(Get.arguments[0]);
    // listings = (await Database().searchListingsByUserId(Get.arguments[0]));
    // if (listings.isEmpty) {
    //   agentListingsState.value = AgentListingsState.empty;
    // } else {
    //   agentListingsState.value = AgentListingsState.loaded;
    // }
  }
}
