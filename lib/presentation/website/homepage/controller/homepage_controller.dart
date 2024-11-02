import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../agent/agents/bindings/agent_listings_binding.dart';
import '../../agents/pages/findagents.dart';
import '../../form/controllers/form_web_binding.dart';
import '../../form/pages/about_us_web.dart';
import '../../form/pages/contactus_web.dart';
import '../../form/pages/join_era_web.dart';
import '../../form/pages/sell_property_web.dart';
import '../../home_website/pages/home_web.dart';
import '../../listings/controllers/buyweb_binding.dart';
import '../../listings/pages/buy_web_listings.dart';
import '../../mortageCalculator.dart/pages/MortageCalculator.dart';

class HomsController extends GetxController {
  RxInt selectedIndex = 0.obs;
  RxInt navBarSelectedIndex = 0.obs;
  RxBool isMoreSelected = false.obs;

  RxList<Widget> pages = [
    BuyWeb(), //0
    FindAgentsWeb(), //0
    ContactUsWeb(), //1
    HomeWeb(), //2
    AboutUsWeb(), //01
    SellPropertyWeb(),
    JoinEraWeb(),
    MortageCalculatorWeb(),
  ].obs;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controllerOverlay = OverlayPortalController();

  final items = [
    'HOME',
    'BUY',
    'RENT',
    'SELL',
    'PROJECTS',
    'NEWS',
    'ABOUT US',
    'CONTACT US',
    'FIND AGENTS',
    'MORTGAGE CALCULATOR',
  ];

  void onIndexChanged() {
    switch (selectedIndex.value) {
      case 0:
        BuyWebBinding().dependencies();

        break;
      case 1:
        AgentListingsBinding().dependencies();
      case 2:
        FormBinding().dependencies();
        break;
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
