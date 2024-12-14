import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';
import '../../../../repository/news.dart';
import '../../../../repository/user.dart';
import '../../../global.dart';

enum AgentDashboardWebState {
  loading,
  loaded,
  error,
}

class AgentDashboardWebController extends GetxController {
  var store = Get.find<LocalStorageService>();
  var agentDashboardWebState = AgentDashboardWebState.loading.obs;
  var listings = [].obs;
  var favorites = [].obs;
  var news = [];
  ScrollController scrollController = ScrollController();
  RxBool scrolling = false.obs;

  @override
  void onInit() async {
    for (int i = 0; i < user!.favorites!.length; i++) {
      if (await Database().doDocumentExist(user!.favorites![i])) {
        favorites.add(await Listing().getListing(user!.favorites![i]));
      } else {
        user!.favorites!.removeAt(i);
      }
    }
    listings.value = await Database().searchListingsByUserId(user!.id!);
    listings.shuffle();
    favorites.shuffle();
    await getNews();
    scrollController.addListener(() async {
      if (!scrolling.value) {
        scrolling.value = true;
        await Future.delayed(Duration(seconds: 4)).then((val) {
          scrolling.value = false;
        });
      }
    });
    agentDashboardWebState.value = AgentDashboardWebState.loaded;

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
    agentDashboardWebState.value = AgentDashboardWebState.loaded;
  }
}
