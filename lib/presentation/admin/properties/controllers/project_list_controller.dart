import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/project.dart';

enum ProjectsListState{
  loading,
  loaded,
  error,
  empty,
}
class ProjectsListController extends GetxController{
  var store = Get.find<LocalStorageService>();
  var projectsListState = ProjectsListState.loading.obs;
  var projects = [].obs;
  @override
  void onInit()async{
    projects.value = (await FirebaseFirestore.instance.collection('projects').get()).docs.map((doc){
      return Project.fromJSON(doc.data());
    }).toList();
    projectsListState.value = ProjectsListState.loaded;
    super.onInit();
  }
}