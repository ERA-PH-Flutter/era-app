import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum SearchResultState{
  loading,
  loaded,
  error,
}
class SearchResultController extends GetxController{
  var store = Get.find<LocalStorageService>();

}