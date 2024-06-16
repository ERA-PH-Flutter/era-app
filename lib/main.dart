import 'package:architecture/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/services/local_storage.dart';

void main()async{
  await initServices();
  runApp(const App());
}

initServices()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => LocalStorageService().init());
}