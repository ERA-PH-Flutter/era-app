import 'package:get/get.dart';

enum ListingApprovalState {loading,loaded,error}

class ListingApprovalController extends GetxController{
  var listingApprovalState = ListingApprovalState.loading.obs;

  @override
  void onInit() {
    listingApprovalState.value = ListingApprovalState.loaded;
    super.onInit();
  }
}