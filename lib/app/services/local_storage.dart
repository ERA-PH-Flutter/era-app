import 'dart:convert';

import 'package:eraphilippines/app/models/settings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  userID,
  settings,
  downloadedImage
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

  set images(value){
    if(value != null){
      _sharedPreferences?.setString(_Key.downloadedImage.toString(),jsonEncode(value));
    }
  }

  Map<String,dynamic>? get images{
    if(_sharedPreferences?.getString(_Key.downloadedImage.toString()) != null){
      return jsonDecode(_sharedPreferences?.getString(_Key.downloadedImage.toString()));
    }else{
      return null;
    }

  }

  set settings(Settings? value){
    if(value != null){
      _sharedPreferences?.setString(_Key.settings.toString(),jsonEncode(value.toMap()));
    }
  }

  Settings? get settings{
    var data = _sharedPreferences?.getString(_Key.settings.toString());
    if(data == null){
      return null;
    }
    return Settings.fromJSON(jsonDecode(data));
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
