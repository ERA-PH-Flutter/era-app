import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  user,
}

class LocalStorageService extends GetxService {
  Future<LocalStorageService> init() async {
    return this;
  }
  /*
  set surveyResult(value){
    if(value != null){
      _sharedPreferences?.setString(_Key.surveyResult.toString(),jsonEncode(value));
    }
  }

  List? get surveyResult{
    return jsonDecode(_sharedPreferences!.getString(_Key.surveyResult.toString())!);
  }
  */
}
