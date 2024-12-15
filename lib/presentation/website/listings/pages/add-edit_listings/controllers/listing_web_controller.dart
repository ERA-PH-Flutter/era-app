import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../../repository/listing.dart';
import '../../../../../agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import '../../../../../global.dart';
 
enum AdminEditState {loading,loaded,picker}

class ListingsController extends GetxController {
  var state = AdminEditState.loading.obs;
  AddListingsController c = Get.find<AddListingsController>();
  Listing? listing;
  var args;
  @override
  onReady()async{
    try{
      listing = editListingArgument;
      await c.assignData(listing!.id!,isWeb: true);
      state.value = AdminEditState.loaded;
    }on PlatformException catch (e) {
      print('PlatformException: ${e.message}');
      // Handle the error
    }catch(e,ex){
      print(e);
    }
    super.onInit();
  }
}
