import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';


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
  var isClicked = false.obs;
  var currentPage = 0.obs;

  final int totalPages = 10;

  void onPageSelected(int index) {
    currentPage.value = index;
  }

  var currentImage = ''.obs;

  ImageSwitcher() {
    currentImage.value = images[0];
  }

  void onSelectedImage(String newImage) {
    currentImage.value = newImage;
  }

  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2Flistings1.jpg?alt=media&token=acc378ee-4a5d-469f-a6c4-d2a778179ade",
    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2Flistings2.jpg?alt=media&token=e814f03b-f8de-473c-aa09-dac372485487",
    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2Flistings3.jpg?alt=media&token=9929b496-948a-478e-9aad-9544be2604ea",
    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2Flistings4.jpg?alt=media&token=3cc89e97-c2e5-4ea1-b889-b08bfb4a739f",
    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2Flistings5.jpg?alt=media&token=a59dd7ee-c831-4da4-9865-b2af85b1d871",
    "https://firebasestorage.googleapis.com/v0/b/era-philippines.appspot.com/o/listings%2Flistings6.jpg?alt=media&token=53b6c813-1591-4004-bde8-5089432cad0a"
  ];
}
