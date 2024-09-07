import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum CompanyNewsState {
  loading,
  loaded,
}

class CompanyNewsController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var companyNewsState = CompanyNewsState.loading.obs;

  var news = [];
  @override
  void onInit() async {
    await getNews();
    companyNewsState.value = CompanyNewsState.loaded;
    super.onInit();
  }

  getNews() async {
    if (settings!.featuredNews!.isNotEmpty) {
      for (int i = 0; i < settings!.featuredNews!.length; i++) {
        settings!.featuredNews![i] != ''
            ? news.add(await News(id: settings!.featuredNews![i]).getNews())
            : null;
      }
    }
  }
}
