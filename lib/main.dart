import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'app/services/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{
  await initServices();
  runApp(const App());
}

initServices()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => LocalStorageService().init());
  Gemini.init(apiKey: AppStrings.geminiKey);
}