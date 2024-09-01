import 'package:eraphilippines/app/theme.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_binding.dart';
import 'package:eraphilippines/presentation/agent/home/controllers/home_controller.dart';
import 'package:eraphilippines/presentation/agent/home/pages/home.dart';
import 'package:eraphilippines/presentation/agent/splash/controllers/splash_binding.dart';
import 'package:eraphilippines/presentation/agent/splash/pages/splash.dart';
import 'package:eraphilippines/router/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'app/services/notification.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState(){
    super.initState();
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationServices.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationServices.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationServices.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationServices.onDismissActionReceivedMethod
    );
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    Size designSize = kIsWeb
        ? Size(1920, 1080)
        : shortestSide < 600
            ? Size(430, 932)
            : Size(768, 1024);
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        onGenerateRoute: (settings){
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context){
                Get.put(HomeController());
                return Home();
              });
            default:
              assert(false, 'Page ${settings.name} not found');
              return null;
          }
        },
        debugShowCheckedModeBanner: false,
        theme: MyTheme.getDefault(),
        initialRoute: "/",
        getPages: appRoutes(),
        initialBinding: SplashBinding(),
        home: const Splash(),
      ),
      builder: (context, child) =>
          NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: child!),
    );
  }
}
