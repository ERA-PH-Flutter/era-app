import 'package:eraphilippines/presentation/agent/terms_conditions/terms_condition.dart';
import 'package:eraphilippines/presentation/website/agents/bindings/agent_mylistingWeb_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/controllers/editlistings_bindings.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/pages/edit_listing.dart';
import 'package:eraphilippines/presentation/website/news/pages/companynews.dart';

import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';

import '../presentation/agent/home/controllers/home_binding.dart';
import '../presentation/agent/home/pages/home.dart';
import '../presentation/agent/listings/add-edit_listings/controllers/addlistings_bindings.dart';
import '../presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import '../presentation/agent/listings/add-edit_listings/pages/edit_listing.dart';
import '../presentation/agent/listings/archivedlisting/controllers/archived_binding.dart';
import '../presentation/agent/listings/archivedlisting/pages/archived.dart';
import '../presentation/agent/listings/favorites/controllers/fav_binding.dart';
import '../presentation/agent/listings/favorites/pages/Fav.dart';

import '../presentation/agent/listings/sold_properties/controllers/sold_properties_binding.dart';
import '../presentation/agent/listings/sold_properties/pages/sold_properties.dart';

import '../presentation/website/agents/pages/agentsMyListing.dart';
import '../presentation/website/landingpage/pages/homepage.dart';
import '../presentation/website/listings/pages/favorites/controllers/fav_binding.dart';
import '../presentation/website/listings/pages/favorites/pages/Fav.dart';

appRoutes() => [
      GetPage(
          name: RouteString.addListings,
          page: () => const AddListings(),
          binding: AddListingsBinding()),
      GetPage(
          name: RouteString.home,
          page: () => const Home(),
          binding: HomeBinding()),

      //projects

      // GetPage(
      //     name: RouteString.findagents,
      //     page: () => const FindAgents(),
      //     binding: AgentsBinding()),

      // GetPage(
      //     name: RouteString.agentDashBoard,
      //     page: () => AgentDashBoard(),
      //     binding: AgentDashboardBinding()),
      // GetPage(
      //     name: RouteString.agentMyListing,
      //     page: () => AgentsMyListing(),
      //     binding: AgentListingsBinding()),
      // GetPage(
      //     name: RouteString.agentListings,
      //     page: () => AgentListings(),
      //     binding: AgentListingsBinding()),

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
      GetPage(
        name: RouteString.favWeb,
        page: () => favWeb(),
        binding: FavWebBinding(),
      ),
      // GetPage(
      //   name: RouteString.createaccountweb,
      //   page: () => CreateAccountWeb(),
      // ),
      GetPage(
          name: RouteString.agentMyListingWeb,
          page: () => AgentsMyListingWeb(),
          binding: AgentListingsWebBinding()),
      GetPage(
          name: RouteString.editListingsWeb,
          page: () => EditListingWeb(),
          binding: AddListingsBinding()),
    ];

class MyMiddleware extends GetMiddleware {}
