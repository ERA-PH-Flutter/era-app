import 'package:eraphilippines/presentation/agent/terms_conditions/terms_condition.dart';
import 'package:eraphilippines/presentation/website/agents/bindings/agent_mylistingWeb_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/pages/edit_listing.dart';
import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/controllers/archived_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/pages/archived.dart';
import 'package:eraphilippines/presentation/website/news/pages/companynews.dart';
import 'package:eraphilippines/presentation/website/privacy_policy/privacy-policy.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';
import '../presentation/agent/home/controllers/home_binding.dart';
import '../presentation/agent/home/pages/home.dart';
import '../presentation/agent/listings/add-edit_listings/controllers/addlistings_bindings.dart';
import '../presentation/agent/listings/add-edit_listings/pages/addlistings.dart';
import '../presentation/agent/listings/add-edit_listings/pages/edit_listing.dart';
import '../presentation/agent/listings/archivedlisting/controllers/archived_binding.dart';
import '../presentation/agent/listings/archivedlisting/pages/archived.dart';
import '../presentation/agent/listings/sold_properties/controllers/sold_properties_binding.dart';
import '../presentation/agent/listings/sold_properties/pages/sold_properties.dart';
import '../presentation/website/agents/bindings/agent_web_binding.dart';
import '../presentation/website/agents/pages/agentsMyListing.dart';
import '../presentation/website/agents/pages/settingAgent.dart';
import '../presentation/website/landingpage/pages/homepage.dart';
import '../presentation/website/listings/pages/favorites/controllers/fav_binding.dart';
import '../presentation/website/listings/pages/favorites/pages/Fav.dart';
import '../presentation/website/listings/pages/sold_properties/controllers/sold_properties_binding.dart';
import '../presentation/website/listings/pages/sold_properties/pages/sold_properties.dart';

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
          name: RouteString.editListings,
          page: () => EditListing(),
          binding: AddListingsBinding()),
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
        name: RouteString.homs,
        page: () => HomePages(),
      ),
      GetPage(
        name: RouteString.homs,
        page: () => HomePages(),
      ),
      GetPage(
        name: RouteString.companyNewsWeb,
        page: () => CompanyNewsWeb(),
      ),
      GetPage(
        name: RouteString.favWeb,
        page: () => FavWeb(),
        binding: FavWebBinding(),
      ),
      GetPage(
          name: RouteString.agentMyListingWeb,
          page: () => AgentsMyListingWeb(),
          binding: AgentListingsWebBinding()),
      GetPage(
          name: RouteString.editListingsWeb,
          page: () => EditListingWeb(),
          binding: AddListingsBinding()),
      // GetPage(
      //     name: RouteString.joinUsWeb,
      //     page: () => JoinEraWeb(),
      //     binding: FormBinding()),
      GetPage(
          name: RouteString.settingsWeb,
          page: () => SettingsPageWeb(),
          binding: AgentWebBinding()),
      GetPage(
          name: RouteString.archivedWeb,
          page: () => ArchivedWeb(),
          binding: ArchivedWebBinding()),
      GetPage(
        name: RouteString.soldPropertiesWeb,
        page: () => SoldPropertiesWeb(),
        binding: SoldBindingWeb(),
      ),
      GetPage(
        name: RouteString.privacyPolicy,
        page: () => PrivacyPolicy(),
      ),
    ];

class MyMiddleware extends GetMiddleware {}
