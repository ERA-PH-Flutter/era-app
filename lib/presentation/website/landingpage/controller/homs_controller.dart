import 'package:eraphilippines/presentation/website/agents/bindings/agent_mylistingWeb_binding.dart';
import 'package:eraphilippines/presentation/website/agents/pages/agentsMyListing.dart';
import 'package:eraphilippines/presentation/website/form/pages/help.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_era_web.dart';
import 'package:eraphilippines/presentation/website/listings/pages/favorites/pages/Fav.dart';
import 'package:eraphilippines/presentation/website/projects/pages/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/web/companynews_page_web.dart';
import '../../../../app/widgets/web/project_views_web.dart';
import '../../agents/bindings/agent_dashboard_binding.dart';
import '../../agents/bindings/agent_web_binding.dart';
import '../../agents/pages/dashboard_web.dart';
import '../../agents/pages/findagents.dart';
import '../../form/controllers/form_web_binding.dart';
import '../../form/pages/about_us_web.dart';
import '../../form/pages/contactus_web.dart';
import '../../form/pages/sell_property_web.dart';
import '../../home/pages/home_web.dart';
import '../../listings/controllers/listings_web_binding.dart';
import '../../listings/pages/add-edit_listings/controllers/addlistings_bindings.dart';
import '../../listings/pages/add-edit_listings/controllers/editlistings_bindings.dart';
import '../../listings/pages/add-edit_listings/pages/addlistings.dart';
import '../../listings/pages/add-edit_listings/pages/edit_listing.dart';
import '../../listings/pages/favorites/controllers/fav_binding.dart';
import '../../listings/pages/listings/listing_web_page.dart';
import '../../listings/pages/listings/listing_web.dart';
import '../../mortageCalculator.dart/controllers/MortageCalculator_binding.dart';
import '../../mortageCalculator.dart/pages/MortageCalculator.dart';
import '../../news/controllers/news_binding.dart';
import '../../news/pages/companynews.dart';
import '../../projects/controllers/projects_binding.dart';

RxInt selectedIndex = 0.obs;

class HomsController extends GetxController {
  RxInt navBarSelectedIndex = 0.obs;
  RxBool isMoreSelected = false.obs;
  var isNavbarVisible = true.obs;
  RxBool getBack = false.obs;
  var link = LayerLink();
  double? buttonWidth;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var controllerOverlay = OverlayPortalController();
  var loginOverlay = OverlayPortalController();
  ScrollController scrollController = ScrollController();

  RxList<Widget> pages = [
    HomeWeb(), //0
    ProjectsList(), //1
    BuyWeb(), //2
    FindAgentsWeb(), //3
    HelpWeb(), //04
    // CompanyNewsWeb(),
    AboutUsWeb(), //5
    JoinEraWeb(), //6
    SellPropertyWeb(), //7
    ContactUsWeb(), //8
    MortageCalculatorWeb(), //9
    CompanyNewsWeb(), //10
    CompanyNewsPageWeb(), // 11
    BuyWebListingPage(), // 12
    AgentDashBoardWeb(), //13
    ProjectViewsWeb(), //14
    AddListingsWeb(), //15
    favWeb(), //16
    AgentsMyListingWeb(), //17
    EditListingWeb(), //18
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
        AgentListingsWebBinding().dependencies();

        // HomeWebBinding().dependencies();
        //  BuyWebBinding().dependencies();
        break;
      case 1:
        ProjectsWebBinding().dependencies();
      case 2:
        ListingsWebBinding().dependencies();
        break;
      case 3:
        AgentWebBinding().dependencies();
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
      case 10:
        NewsBinding().dependencies();
        break;
      case 11:
        NewsBinding().dependencies();
        break;
      case 12:
        ListingsWebBinding().dependencies();
        break;
      case 13:
        AgentDashboardWebBinding().dependencies();
        break;
      case 14:
        MortageCalculatorBinding().dependencies();
        break;
      case 15:
        //this is the edit listing page just like the add listing page
        //  EditListingsBinding().dependencies();
        AddListingsBinding().dependencies();
        break;
      case 16:
        FavWebBinding().dependencies();
        break;
      case 17:
        AgentListingsWebBinding().dependencies();
        break;
      case 18:
        EditListingsBinding().dependencies();
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
