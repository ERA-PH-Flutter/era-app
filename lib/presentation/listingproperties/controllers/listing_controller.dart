import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum ListingState {
  loading,
  loaded,
  error,
}

class ListingController extends GetxController {
  var store = Get.find<LocalStorageService>();

  var selectedLocation = ''.obs;
  var selectedPropertyType = ''.obs;
  var selectedPriceRange = ''.obs;
  var isForSale = 0.obs;
  var isForLease = true.obs;
}
