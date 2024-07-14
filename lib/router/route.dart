import 'package:eraphilippines/presentation/base/controllers/base_binding.dart';
import 'package:eraphilippines/presentation/home/controllers/home_binding.dart';
import 'package:eraphilippines/presentation/listingpages/controllers/listing_binding.dart';
import 'package:eraphilippines/presentation/listingpages/pages/auction.dart';
import 'package:eraphilippines/presentation/listingpages/pages/commercial.dart';
import 'package:eraphilippines/presentation/listingpages/pages/pre_selling.dart';
import 'package:eraphilippines/presentation/listingpages/pages/rental.dart';
import 'package:eraphilippines/presentation/listingpages/pages/residential.dart';
import 'package:eraphilippines/presentation/login_page/pages/login_page.dart';
import 'package:eraphilippines/router/route_string.dart';
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
          name: RouteString.residential,
          page: () => const Residential(),
          binding: ListingBinding()),
      GetPage(
          name: RouteString.commercial,
          page: () => const Commercial(),
          binding: ListingBinding()),
      GetPage(
          name: RouteString.rental,
          page: () => const Rental(),
          binding: ListingBinding()),
      GetPage(
          name: RouteString.auction,
          page: () => const Auction(),
          binding: ListingBinding()),
    ];

class MyMiddleware extends GetMiddleware {}
