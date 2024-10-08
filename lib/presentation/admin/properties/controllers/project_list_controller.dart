import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/project.dart';

enum ProjectsListState {
  loading,
  loaded,
  error,
  empty,
}

class ProjectsListController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var projectsListState = ProjectsListState.loading.obs;
  var projects = [].obs;
  @override
  void onInit() async {
    projects.value =
        (await FirebaseFirestore.instance.collection('projects').get())
            .docs
            .map((doc) {
      return Project.fromJSON(doc.data());
    }).toList();
    projectsListState.value = ProjectsListState.loaded;
    super.onInit();
  }

  var selectedPropertyType = RxnString();
  var selectedLocation = RxnString();
  var selectedDeveloper = RxnString();

  var propertType = [
    "House and Lot",
    "Condominium",
    "Townhouse",
    "Commercial",
    "Industrial",
    "Agricultural",
    "Land",
    "Foreclosed",
    "Pre-selling",
    "Rent to Own",
    "Others",
  ];

  var location = [
    "Manila",
    "Quezon City",
    "Caloocan",
    "Makati",
    "Valenzuela",
    "San Juan",
    "Parañaque",
    "Navotas",
    "Taguig",
    "Davao",
    "Las Piñas",
    "Pasig",
    "Mandaluyong",
    "Pateros",
    "Marikina",
    "Muntinlupa",
    "Malabon",
    "Fort Bonifacio",
    "Binondo",
    "Rizal",
    "Antipolo",
    "Santa Ana",
  ];
  var developerType = [
    "Shang Properties",
  ];
}
