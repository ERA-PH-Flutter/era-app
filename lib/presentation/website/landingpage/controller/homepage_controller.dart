import 'package:eraphilippines/app/widgets/web/companynews_page_web.dart';
import 'package:eraphilippines/presentation/website/projects/pages/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../agent/agents/bindings/agent_listings_binding.dart';
import '../../agents/pages/findagents.dart';
import '../../form/controllers/form_web_binding.dart';
import '../../form/pages/about_us_web.dart';
import '../../form/pages/contactus_web.dart';
import '../../form/pages/join_era_web.dart';
import '../../form/pages/sell_property_web.dart';
import '../../home/controllers/home_web_binding.dart';
import '../../home/pages/home_web.dart';
import '../../listings/controllers/buyweb_binding.dart';
import '../../listings/pages/buy_web_listings.dart';
import '../../mortageCalculator.dart/controllers/MortageCalculator_binding.dart';
import '../../mortageCalculator.dart/pages/MortageCalculator.dart';
import '../../news/bindings/news_binding.dart';
import '../../projects/controllers/projects_binding.dart';
import '../../projects/pages/project_view.dart';

class HomsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt navBarSelectedIndex = 0.obs;
  RxBool isMoreSelected = false.obs;
  var isNavbarVisible = true.obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controllerOverlay = OverlayPortalController();
  ScrollController scrollController = ScrollController();

  RxList<Widget> pages = [
    HomeWeb(), //0
    BuyWeb(), //1

    BuyWeb(), //2
    SellPropertyWeb(), //3
//projects
    ProjectsList(),
    FindAgentsWeb(), //04
    CompanyNewsPageWeb(), //5
    AboutUsWeb(),
    ContactUsWeb(), //6
    //2
    //7

    MortageCalculatorWeb(),
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
    'BUY',
    'RENT',
    'SELL',
    'PROJECTS',
    'FIND AGENTS',
    'NEWS',
    'ABOUT US',
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
        BuyWebBinding().dependencies();
      case 2:
        BuyWebBinding().dependencies();
        break;
      case 3:
        FormBinding().dependencies();
        break;
      case 4:
        ProjectsWebBinding().dependencies();
        break;
      case 5:
        AgentListingsBinding().dependencies();
        break;
      case 6:
        NewsBinding().dependencies();
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
