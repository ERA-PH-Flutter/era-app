import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  userID,
}

class LocalStorageService extends GetxService {
  var _sharedPreferences;
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
  set userID(value){
    if(value != null){
      _sharedPreferences?.setString(_Key.userID.toString(),value);
    }
  }

  String get userID{
    return _sharedPreferences?.getString(_Key.userID.toString());
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
