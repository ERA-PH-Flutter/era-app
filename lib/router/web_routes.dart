import 'package:eraphilippines/presentation/website/re_route/re_route.dart';
import 'package:eraphilippines/presentation/website/re_route/re_route_controller.dart';
import 'package:get/get.dart';

appRoutesWeb() => [
      GetPage(
        name: '/',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
        // arguments: RouteArgs.home
      ),
      GetPage(
        name: '/home',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
        // arguments: RouteArgs.home
      ),
      GetPage(
        name: '/projects',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/view-project',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/search',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/view-listing',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/find-agents',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/view-agent',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/help',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/join-us',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/mortgage-calculator',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/sell-property',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/agent-dashboard',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/settings',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/add-listing',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/edit-listing',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/my-listings',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/my-favorites',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/sold-properties',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/archives',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/news',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/view-news',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/privacy-policy',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
      GetPage(
        name: '/find-agent-view-listings',
        page: () => ReRoute(),
        binding: ReRouteBinding(),
      ),
    ];
