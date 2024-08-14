import 'package:eraphilippines/presentation/agent/splash/controllers/splash_binding.dart';
import 'package:eraphilippines/presentation/agent/splash/pages/splash.dart';
import 'package:eraphilippines/router/route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/constants/colors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    Size designSize;

     if (kIsWeb) {
      designSize = const Size(1920, 1080);  
    } else if (shortestSide < 600) {
      designSize = const Size(430, 932);  
    } else {
      designSize = const Size(768, 1024); 
    }

    return ScreenUtilInit(
      designSize: designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: AppColors.primary,
            fontFamily: GoogleFonts.poppins().fontFamily,
            dialogBackgroundColor: Colors.transparent,
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.white)),
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
