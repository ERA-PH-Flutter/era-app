import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eraphilippines/repository/news.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';

enum NewsState {
  loading,
  loaded,
}

class NewsWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var newsState = NewsState.loading.obs;

  var news = [];
  var newsArgument;
  @override
  void onInit() async {
    await getNews();
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
