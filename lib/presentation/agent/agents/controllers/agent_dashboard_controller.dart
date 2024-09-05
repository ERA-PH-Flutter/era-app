import 'package:eraphilippines/app/services/firebase_database.dart';
import 'package:get/get.dart';
import '../../../../app/services/local_storage.dart';
import '../../../../repository/listing.dart';
import '../../../../repository/news.dart';
import '../../../global.dart';

enum AgentDashboardState{
  loading,
  loaded,
  error,
}
class AgentDashboardController extends GetxController{
    var store = Get.find<LocalStorageService>();
    var agentDashboardState = AgentDashboardState.loading.obs;
    var listings = [].obs;
    var favorites = [].obs;
    var news = [];
  @override
  void onInit()async{
    listings.value = await Database().searchListingsByUserId(user!.id!);
    for(int i = 0;i<user!.favorites!.length;i++){
      favorites.add( await Listing().getListing(user!.favorites![i]));
    }
    listings.shuffle();
    favorites.shuffle();
    await getNews();
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
      agentDashboardState.value = AgentDashboardState.loaded;
    }

}