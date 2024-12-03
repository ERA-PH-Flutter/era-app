import 'package:eraphilippines/presentation/agent/agents/bindings/agent_dashboard_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/bindings/agent_listings_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/agent_listings.dart';
import 'package:eraphilippines/presentation/agent/authentication/pages/nextPage.dart';

import 'package:eraphilippines/presentation/agent/terms_conditions/terms_condition.dart';
import 'package:eraphilippines/presentation/website/news/pages/companynews.dart';

import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';
import '../presentation/agent/agents/bindings/agents_binding.dart';
import '../presentation/agent/agents/pages/agentsDashBoard.dart';
import '../presentation/agent/agents/pages/agentsMyListing.dart';
import '../presentation/agent/agents/pages/findagents.dart';
import '../presentation/agent/authentication/controllers/authentication_binding.dart';
import '../presentation/agent/authentication/pages/createaccount_page.dart';
import '../presentation/agent/authentication/pages/login_page.dart';

import '../presentation/agent/home/controllers/home_binding.dart';
import '../presentation/agent/home/pages/home.dart';
import '../presentation/agent/listings/add-edit_listings/controllers/addlistings_bindings.dart';
import '../presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import '../presentation/agent/listings/add-edit_listings/pages/edit_listing.dart';
import '../presentation/agent/listings/archivedlisting/controllers/archived_binding.dart';
import '../presentation/agent/listings/archivedlisting/pages/archived.dart';
import '../presentation/agent/listings/favorites/controllers/fav_binding.dart';
import '../presentation/agent/listings/favorites/pages/Fav.dart';
import '../presentation/agent/listings/listingproperties/controllers/listing_binding.dart';
import '../presentation/agent/listings/listingproperties/pages/findproperties.dart';
import '../presentation/agent/listings/listingproperties/pages/property_infomation.dart';
import '../presentation/agent/listings/searchresult/controllers/searchresult_binding.dart';
import '../presentation/agent/listings/searchresult/pages/searchresult.dart';
import '../presentation/agent/listings/searchresult/pages/selling_searchresult.dart';
import '../presentation/agent/listings/sellproperty/controllers/sellproperty_binding.dart';
import '../presentation/agent/listings/sellproperty/pages/sellproperty.dart';
import '../presentation/agent/listings/sold_properties/controllers/sold_properties_binding.dart';
import '../presentation/agent/listings/sold_properties/pages/sold_properties.dart';

import '../presentation/website/landingpage/pages/homepage.dart';

appRoutes() => [
      GetPage(
          name: RouteString.addListings,
          page: () => const AddListings(),
          binding: AddListingsBinding()),
      GetPage(
          name: RouteString.home,
          page: () => const Home(),
          binding: HomeBinding()),
      GetPage(
          name: RouteString.loginpage,
          page: () => const LoginPage(),
          binding: LoginPageBinding()),

      //projects

      GetPage(
          name: RouteString.createaccount,
          page: () => const CreateAccount(),
          binding: LoginPageBinding()),
      GetPage(
          name: RouteString.findproperties,
          page: () => const FindProperties(),
          binding: ListingBinding()),
      GetPage(
          name: RouteString.searchresult,
          page: () => const SearchResult(),
          binding: SearchResultBinding()),
      GetPage(
          name: RouteString.sellingsearchresult,
          page: () => const SellingSearchresult(),
          binding: SearchResultBinding()),
      GetPage(
          name: RouteString.rentsearchresult,
          page: () => const SearchResult(),
          binding: SearchResultBinding()),

      GetPage(
          name: RouteString.findagents,
          page: () => const FindAgents(),
          binding: AgentsBinding()),

      GetPage(
          name: RouteString.propertyInfo,
          page: () => PropertyInformation(
                listing: Get.arguments,
              ),
          binding: ListingBinding()),
      GetPage(
          name: RouteString.agentDashBoard,
          page: () => AgentDashBoard(),
          binding: AgentDashboardBinding()),
      GetPage(
          name: RouteString.agentMyListing,
          page: () => AgentsMyListing(),
          binding: AgentListingsBinding()),
      GetPage(
          name: RouteString.agentListings,
          page: () => AgentListings(),
          binding: AgentListingsBinding()),

      GetPage(
          name: RouteString.editListings,
          page: () => EditListing(),
          binding: AddListingsBinding()),

      GetPage(
        name: RouteString.fav,
        page: () => Fav(),
        binding: FavBinding(),
      ),
      GetPage(
          name: RouteString.archived,
          page: () => Archived(),
          binding: ArchivedBinding()),
      GetPage(
        name: RouteString.soldP,
        page: () => SoldProperties(),
        binding: SoldBinding(),
      ),
      GetPage(
        name: RouteString.sellProperty,
        page: () => SellProperty(),
        binding: SellPropertyBinding(),
      ),
      GetPage(
        name: RouteString.nextPage,
        page: () => Nextpage(),
        binding: LoginPageBinding(),
      ),
      GetPage(
        name: RouteString.termsAndConditions,
        page: () => TermsCondition(),
      ),

      GetPage(
        name: RouteString.webLandingPage,
        page: () => HomePages(),
      ),
      GetPage(
        name: RouteString.companyNewsWeb,
        page: () => CompanyNewsWeb(),
      ),

      GetPage(
        name: RouteString.homs,
        page: () => HomePages(),
      ),
      // GetPage(
      //   name: RouteString.createaccountweb,
      //   page: () => CreateAccountWeb(),
      // ),
    ];

class MyMiddleware extends GetMiddleware {}
