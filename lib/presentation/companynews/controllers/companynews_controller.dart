import 'package:get/get.dart';
import '../../../app/services/local_storage.dart';

enum CompanyNewsState{
  loading,
  loaded,
  error,
}
class CompanyNewsController extends GetxController{
  var store = Get.find<LocalStorageService>();

}