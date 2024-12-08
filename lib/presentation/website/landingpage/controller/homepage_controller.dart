import 'package:eraphilippines/presentation/website/form/pages/help.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_era_web.dart';
import 'package:eraphilippines/presentation/website/projects/pages/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/web/companynews_page_web.dart';
import '../../../agent/agents/bindings/agent_listings_binding.dart';
import '../../agents/pages/dashboard_web.dart';
import '../../agents/pages/findagents.dart';
import '../../form/controllers/form_web_binding.dart';
import '../../form/pages/about_us_web.dart';
import '../../form/pages/contactus_web.dart';
import '../../form/pages/sell_property_web.dart';
import '../../home/controllers/home_web_binding.dart';
import '../../home/pages/home_web.dart';
import '../../listings/controllers/buyweb_binding.dart';
import '../../listings/pages/buy_web_listing_page.dart';
import '../../listings/pages/buy_web_listings.dart';
import '../../mortageCalculator.dart/controllers/MortageCalculator_binding.dart';
import '../../mortageCalculator.dart/pages/MortageCalculator.dart';
import '../../news/bindings/news_binding.dart';
import '../../news/pages/companynews.dart';
import '../../projects/controllers/projects_binding.dart';

RxInt selectedIndex = 0.obs;

class HomsController extends GetxController {
  RxInt navBarSelectedIndex = 0.obs;
  RxBool isMoreSelected = false.obs;
  var isNavbarVisible = true.obs;
  var link = LayerLink();
  double? buttonWidth;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controllerOverlay = OverlayPortalController();
  var loginOverlay = OverlayPortalController();
  ScrollController scrollController = ScrollController();

  RxList<Widget> pages = [
    // AgentDashBoardWeb(),
    HomeWeb(), //0
    ProjectsList(), //1
    BuyWeb(), //2
    FindAgentsWeb(), //3
    HelpWeb(), //04
    // CompanyNewsWeb(),
    AboutUsWeb(), //5
    // JoinEraWeb(),
    SellPropertyWeb(), //6
    ContactUsWeb(), //7
    MortageCalculatorWeb(), //8
    CompanyNewsWeb(), //9
    CompanyNewsPageWeb(), // 10
    BuyWebListingPage(), // 11
  ].obs;

  HomsController() {
    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (isNavbarVisible.value) isNavbarVisible.value = false;
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!isNavbarVisible.value) isNavbarVisible.value = true;
    }
  }

  final items = [
    'HOME',
    'PROJECTS',
    'SEARCH',
    'FIND AGENTS',
    'HELP',
    'ABOUT US',
    'JOIN US',
    'SELL PROPERTY',
    'CONTACT US',
    'MORTGAGE CALCULATOR',
  ];

  void onIndexChanged() {
    switch (selectedIndex.value) {
      case 0:
        HomeWebBinding().dependencies();
        //  BuyWebBinding().dependencies();
        break;
      case 1:
        ProjectsWebBinding().dependencies();
      case 2:
        BuyWebBinding().dependencies();
        break;
      case 3:
        AgentListingsBinding().dependencies();
        break;
      case 4:
        FormBinding().dependencies();
        break;
      case 5:
        FormBinding().dependencies();
        break;
      case 6:
        FormBinding().dependencies();
        break;
      case 7:
        FormBinding().dependencies();
        break;
      case 8:
        FormBinding().dependencies();
        break;
      case 9:
        MortageCalculatorBinding().dependencies();
        break;
      // case 10:
      //   FormBinding().dependencies();
      //   break;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  onNavbarItemSelected(int v) {
    selectedIndex.value = v;
    onIndexChanged();
    update();
  }
}
