import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/news.dart';
import '../../../global.dart';
import '../controllers/news_controller.dart';

class NewsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsWebPageController());
  }
}

enum NewsPageState {
  loading,
  loaded,
}

class NewsWebPageController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var newsState = NewsState.loading.obs;

  var news = [];
  var newsArgument;
  @override
  void onInit() async {
    print("idArgsNews: $idArgument" );
    newsArgument = (await News(id: idArgument).getNews()).toMap();
    newsState.value = NewsState.loaded;
    super.onInit();
  }

  getNews() async {
    var newsData = await FirebaseFirestore.instance.collection('news').get();
    for (int i = 0; i < newsData.docs.length; i++) {
      news.add(News.fromJSON(newsData.docs[i].data()));
    }
  }
}
