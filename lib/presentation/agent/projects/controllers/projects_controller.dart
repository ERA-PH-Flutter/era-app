import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum ProjectsState{
  loading,
  loaded,
  error,
}
class ProjectsController extends GetxController{
  var store = Get.find<LocalStorageService>();

}