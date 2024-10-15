import 'package:get/get.dart';

import '../../../../repository/listing.dart';

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
