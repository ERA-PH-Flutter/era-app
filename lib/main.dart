import 'package:eraphilippines/app.dart';
import 'package:eraphilippines/app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'app/services/local_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void configureApp() {
  setUrlStrategy(PathUrlStrategy());
}

void main() async {
  await initServices();
  configureApp();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(const App());
}

initServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Get.putAsync(() => LocalStorageService().init());
  Gemini.init(apiKey: AppStrings.geminiKey);
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/era_icon_notification',
      [
        NotificationChannel(
            channelGroupKey: 'download_channel_group',
            channelKey: 'download_channel',
            channelName: 'Download Notifications',
            channelDescription: 'Notification channel for Downloads',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'download_channel_group',
            channelGroupName: 'Downloads Group')
      ],
      debug: true);
}
