import 'package:eraphilippines/presentation/website/agents/bindings/agent_mylistingWeb_binding.dart';
import 'package:eraphilippines/presentation/website/agents/pages/agentsMyListing.dart';
import 'package:eraphilippines/presentation/website/agents/pages/settingAgent.dart';
import 'package:eraphilippines/presentation/website/form/pages/help.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_era_web.dart';
import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/pages/archived.dart';
import 'package:eraphilippines/presentation/website/listings/pages/sold_properties/controllers/sold_properties_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/sold_properties/pages/sold_properties.dart';
import 'package:eraphilippines/presentation/website/projects/pages/projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import '../../../../app/widgets/web/companynews_page_web.dart';
import '../../../../app/widgets/web/project_views_web.dart';
import '../../agents/bindings/agent_dashboard_binding.dart';
import '../../agents/bindings/agent_web_binding.dart';
import '../../agents/pages/agent_listings.dart';
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
import '../../listings/pages/archivedlisting/controllers/archived_binding.dart';
import '../../listings/pages/favorites/controllers/fav_binding.dart';
import '../../listings/pages/favorites/pages/Fav.dart';
import '../../listings/pages/listings/listing_web_page.dart';
import '../../listings/pages/listings/listing_web.dart';
import '../../mortageCalculator.dart/controllers/MortageCalculator_binding.dart';
import '../../mortageCalculator.dart/pages/MortageCalculator.dart';
import '../../news/controllers/news_binding.dart';
import '../../news/pages/companynews.dart';
import '../../privacy_policy/privacy-policy.dart';
import '../../projects/controllers/projects_binding.dart';

RxInt selectedIndex = 0.obs;

class HomsController extends GetxController {
  RxInt navBarSelectedIndex = 0.obs;
  RxBool isMoreSelected = false.obs;
  var isNavbarVisible = true.obs;
  RxBool getBack = false.obs;
  var link = LayerLink();
  double? buttonWidth;

  RxBool isDropdownVisible = false.obs;
  var overlayPortal = OverlayPortalController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  ScrollController scrollController = ScrollController();

  final Uri emailUrl = Uri.parse(
      'mailto:sales@eraphilippines.com?subject=Your%20Subject&body=Your%20Message');

  final Uri whatsappUrl = Uri.parse('https://wa.me/639177710572');

  final Uri facebook = Uri.parse(
      'https://www.facebook.com/profile.php?id=61556521950596&mibextid=wwXIfr&rdid=KQZJrEeFQYosVzxe&share_url=https%3A%2F%2Fwww.facebook.com%2Fshare%2F15W4JqJJRc%2F%3Fmibextid%3DwwXIfr#');
  final Uri instagram = Uri.parse('https://www.instagram.com/era_philippines/');

  RxList<Widget> pages = [
    HomeWeb(), //0
    ProjectsList(), //1
    BuyWeb(), //2
    FindAgentsWeb(), //3
    HelpWeb(), //04
    // CompanyNewsWeb(),
    //AboutUsWeb(), //5
    JoinEraWeb(), //5
    SellPropertyWeb(), //6
    // ContactUsWeb(), //7
    MortgageCalculatorWeb(), //7
    CompanyNewsWeb(), //8
    CompanyNewsPageWeb(), // 9
    BuyWebListingPage(), // 10
    AgentDashBoardWeb(), //11
    ProjectViewsWeb(), //12
    AddListingsWeb(), //13
    FavWeb(), //14
    AgentsMyListingWeb(), //15
    EditListingWeb(), //16
    ArchivedWeb(), //17
    SoldPropertiesWeb(), //18
    AgentListingsWeb(), //19
    SettingsPageWeb(), //20
    PrivacyPolicy(), //21
  ].obs;

  HomsController() {
    scrollController.addListener(_scrollListener);
  }

  // void _scrollListener() {
  //   if (scrollController.position.userScrollDirection ==
  //       ScrollDirection.reverse) {
  //     if (isNavbarVisible.value) isNavbarVisible.value = false;
  //   } else if (scrollController.position.userScrollDirection ==
  //       ScrollDirection.forward) {
  //     if (!isNavbarVisible.value) isNavbarVisible.value = true;
  //   }
  // }

  
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
    //  'ABOUT US',
    'JOIN US',
    'SELL PROPERTY',
    //  'CONTACT US',
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
      // case 5:
      //   FormBinding().dependencies();
      //   break;
      case 5:
        FormBinding().dependencies();
        break;
      case 6:
        FormBinding().dependencies();
        break;
      // case 7:
      //   FormBinding().dependencies();
      //   break;
      case 7:
        MortageCalculatorBinding().dependencies();
        break;
      case 8:
        NewsBinding().dependencies();
        break;
      case 9:
        NewsBinding().dependencies();
        break;
      case 10:
        ListingsWebBinding().dependencies();
        break;
      case 11:
        AgentDashboardWebBinding().dependencies();
        break;
      case 12:
        MortageCalculatorBinding().dependencies();
        break;
      case 13:
        //  EditListingsBinding().dependencies();
        AddListingsBinding().dependencies();
        break;
      case 14:
        FavWebBinding().dependencies();
        break;
      case 15:
        AgentListingsWebBinding().dependencies();
        break;
      case 16:
        EditListingsBinding().dependencies();
        break;
      case 17:
        ArchivedWebBinding().dependencies();
        break;
      case 18:
        SoldBindingWeb().dependencies();
        break;
      case 19:
        AgentDashboardWebBinding().dependencies();
        break;
      default:
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
