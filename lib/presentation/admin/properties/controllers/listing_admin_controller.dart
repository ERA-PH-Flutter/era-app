import 'package:get/get.dart';

import '../../../../repository/listing.dart';
import '../../../agent/listings/add-edit_listings/controllers/addlistings_controller.dart';
import '../../landingpage/controllers/landingpage_controller.dart';

enum AdminEditState {loading,loaded,picker}

class ListingsController extends GetxController {
  var state = AdminEditState.loaded.obs;
  Listing? listing;
  var args;
  @override
  onReady()async{
    super.onInit();
  }
}
