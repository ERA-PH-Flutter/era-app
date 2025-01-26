import 'dart:ui';
import 'package:eraphilippines/app/theme.dart';
import 'package:eraphilippines/presentation/agent/splash/controllers/splash_binding.dart';
import 'package:eraphilippines/presentation/agent/splash/pages/splash.dart';
import 'package:eraphilippines/router/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    Size designSize = shortestSide > 600
        ? Size(1920, 1080)
        : shortestSide < 600
            ? Size(430, 932)
            : Size(768, 1024);
    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        scrollBehavior: MaterialScrollBehavior().copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        }),
        debugShowCheckedModeBanner: false,
        theme: MyTheme.getDefault(),
        initialRoute: "/",
        getPages: appRoutes(),
        initialBinding: SplashBinding(),
        home: const Splash(),
      ),
    );
  }
}
