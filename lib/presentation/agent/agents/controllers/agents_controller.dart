import 'package:get/get.dart';

class AgentsController extends GetxController {
  var sortOption = 'name_ascending'.obs;
  var isAscending = true.obs;
  var filterName = ''.obs;
  var date = DateTime.now().obs;


  void toggleSortDirection() {
    isAscending.value = !isAscending.value;
    updateSortOption(isAscending.value ? 'name_ascending' : 'name_descending');
  }

  void updateSortOption(String newSortOption) {
    sortOption.value = newSortOption;
  }

 
}

  // final List<String> sortOptions = ['name_ascending', 'name_descending'];

  // List<RealEstateListing> applyFiltersAndSorting(
  //     List<RealEstateListing> listings, AgentsController controller) {
  //   if (sortOption.value.contains('name')) {
  //     listings.sort(
  //         (a, b) => (a.user.firstname ?? '').compareTo(b.user.firstname ?? ''));
  //   }

  //   if (!controller.isAscending.value) {
  //     listings = listings.reversed.toList();
  //   }

  //   return listings;
  // }

  // void updateFilterName(String name) {
  //   filterName.value = name;
  // }

  // void updateDate(DateTime newDate) {
  //   date.value = newDate;
  // }