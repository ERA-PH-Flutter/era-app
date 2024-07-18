import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum BaseState{
  loading,
  loaded,
  error,
}
class BaseController extends GetxController{
  var store = Get.find<LocalStorageService>();

}