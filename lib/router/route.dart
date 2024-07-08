import 'package:architecture/presentation/base/controllers/base_binding.dart';
import 'package:architecture/presentation/home/controllers/home_binding.dart';
import 'package:architecture/presentation/listingpages/controllers/listing_binding.dart';
import 'package:architecture/presentation/listingpages/pages/pre_selling.dart';
import 'package:architecture/presentation/listingpages/pages/rental.dart';
import 'package:architecture/presentation/login_page/pages/login_page.dart';
import 'package:architecture/router/route_string.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../presentation/home/pages/home.dart';

appRoutes() => [
      /*
  GetPage(
    name: RoutePageString.auth,
    page: () => const AuthPage(),
    middlewares: [MyMiddelware()],
  ),
  */
      GetPage(
          name: RouteString.home,
          page: () => const Home(),
          binding: HomeBinding()),
      GetPage(
          name: RouteString.loginpage,
          page: () => const LoginPage(),
          binding: SecondPageBinding()),
      GetPage(
          name: RouteString.preSelling,
          page: () => const PreSelling(),
          binding: ListingBinding()),
      GetPage(
          name: RouteString.rental,
          page: () => const Rental(),
          binding: ListingBinding()),
    ];

class MyMiddleware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    return super.onPageCalled(page);
  }
}
