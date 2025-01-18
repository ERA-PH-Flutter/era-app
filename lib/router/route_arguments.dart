import 'package:eraphilippines/app/widgets/web/companynews_page_web.dart';
import 'package:eraphilippines/app/widgets/web/project_views_web.dart';
import 'package:eraphilippines/presentation/agent/listings/add-edit_listings/controllers/addlistings_bindings.dart';
import 'package:eraphilippines/presentation/global.dart';
import 'package:eraphilippines/presentation/website/agents/bindings/agent_dashboard_binding.dart';
import 'package:eraphilippines/presentation/website/agents/bindings/agent_mylistingWeb_binding.dart';
import 'package:eraphilippines/presentation/website/agents/bindings/agent_web_binding.dart';
import 'package:eraphilippines/presentation/website/agents/pages/agentsMyListing.dart';
import 'package:eraphilippines/presentation/website/agents/pages/dashboard_web.dart';
import 'package:eraphilippines/presentation/website/agents/pages/findagents.dart';
import 'package:eraphilippines/presentation/website/agents/pages/settingAgent.dart';
import 'package:eraphilippines/presentation/website/form/pages/help.dart';
import 'package:eraphilippines/presentation/website/form/pages/join_era_web.dart';
import 'package:eraphilippines/presentation/website/form/pages/sell_property_web.dart';
import 'package:eraphilippines/presentation/website/listings/controllers/buyweb_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/controllers/editlistings_bindings.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/pages/addlistings.dart';
import 'package:eraphilippines/presentation/website/listings/pages/add-edit_listings/pages/edit_listing.dart';
import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/controllers/archived_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/archivedlisting/pages/archived.dart';
import 'package:eraphilippines/presentation/website/listings/pages/favorites/controllers/fav_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/favorites/pages/Fav.dart';
import 'package:eraphilippines/presentation/website/listings/pages/listings/listing_web.dart';
import 'package:eraphilippines/presentation/website/listings/pages/listings/listing_web_page.dart';
import 'package:eraphilippines/presentation/website/listings/pages/sold_properties/controllers/sold_properties_binding.dart';
import 'package:eraphilippines/presentation/website/listings/pages/sold_properties/pages/sold_properties.dart';
import 'package:eraphilippines/presentation/website/mortageCalculator.dart/controllers/MortageCalculator_binding.dart';
import 'package:eraphilippines/presentation/website/mortageCalculator.dart/pages/MortageCalculator.dart';
import 'package:eraphilippines/presentation/website/news/controllers/news_binding.dart';
import 'package:eraphilippines/presentation/website/news/pages/companynews.dart';
import 'package:eraphilippines/presentation/website/privacy_policy/privacy-policy.dart';
import 'package:eraphilippines/presentation/website/projects/controllers/projects_binding.dart';
import '../presentation/website/agents/pages/agent_listings.dart';
import '../presentation/website/form/controllers/form_web_binding.dart';
import '../presentation/website/home/controllers/home_web_binding.dart';
import '../presentation/website/home/pages/home_web.dart';
import '../presentation/website/news/controllers/news_webpage_controller.dart';
import '../presentation/website/projects/pages/projects_list.dart';
import '../presentation/website/re_route/re_route_args.dart';
import '../presentation/website/terms_conditions_web/privacy_policy_binding.dart';

class RouteArgs {
  static List routeArguments = [
    ReRouteArgs(
      name: "/",
      page: HomeWeb(),
      binding: HomeWebBinding(),
    ),
    ReRouteArgs(
      name: "/home",
      page: HomeWeb(),
      binding: HomeWebBinding(),
    ),
    ReRouteArgs(
      name: "/projects",
      page: ProjectsList(),
      binding: ProjectsWebBinding(),
    ),
    ReRouteArgs(
      name: "/view-project",
      page: ProjectViewsWeb(),
      binding: ProjectsWebBinding(),
    ),
    ReRouteArgs(
      name: "/search",
      page: BuyWeb(),
      binding: BuyWebBinding(),
    ),
    ReRouteArgs(
      name: "/find-agents",
      page: FindAgentsWeb(),
      binding: AgentWebBinding(),
    ),
    ReRouteArgs(
      name: "/view-agent",
      page: AgentListingsWeb(),
      binding: AgentListingsWebBinding(),
    ),
    ReRouteArgs(
      name: "/help",
      page: HelpWeb(),
      binding: FormBinding(),
    ),
    ReRouteArgs(
      name: "/join-us",
      page: JoinEraWeb(),
      binding: FormBinding(),
    ),
    ReRouteArgs(
      name: "/sell-property",
      page: SellPropertyWeb(),
      binding: FormBinding(),
    ),
    ReRouteArgs(
      name: "/mortgage-calculator",
      page: MortgageCalculatorWeb(),
      binding: MortageCalculatorBinding(),
    ),
    ReRouteArgs(
      name: "/agent-dashboard",
      page: AgentDashBoardWeb(),
      binding: AgentDashboardWebBinding(),
    ),
    ReRouteArgs(
      name: "/settings",
      page: SettingsPageWeb(),
      binding: AgentWebBinding(),
    ),
    ReRouteArgs(
      name: "/add-listing",
      page: AddListingsWeb(),
      binding: AddListingsBinding(),
    ),
    ReRouteArgs(
      name: "/edit-listing",
      page: EditListingWeb(),
      binding: EditListingsBinding(),
    ),
    ReRouteArgs(
      name: "/view-listing",
      page: BuyWebListingPage(),
      binding: BuyWebBinding(),
    ),
    ReRouteArgs(
      name: "/my-listings",
      page: AgentsMyListingWeb(),
      binding: AgentListingsWebBinding(),
    ),
    ReRouteArgs(
      name: "/my-favorites",
      page: FavWeb(),
      binding: FavWebBinding(),
    ),
    ReRouteArgs(
      name: "/archives",
      page: ArchivedWeb(),
      binding: ArchivedWebBinding(),
    ),
    ReRouteArgs(
      name: "/sold-properties",
      page: SoldPropertiesWeb(),
      binding: SoldBindingWeb(),
    ),
    ReRouteArgs(
      name: "/news",
      page: CompanyNewsWeb(),
      binding: NewsBinding(),
    ),
    ReRouteArgs(
      name: "/view-news",
      page: CompanyNewsPageWeb(),
      binding: NewsPageBinding(),
    ),
    ReRouteArgs(
      name: "/privacy-policy",
      page: PrivacyPolicy(),
      binding: PrivacyPolicyBinding(),
    ),
    ReRouteArgs(
      name: "/agent-listings",
      page: AgentListingsWeb(),
      binding: AgentDashboardWebBinding(),
    ),
  ];
  static getArgs(routeName) {
    String? id =
        routeName.split("/").length > 2 ? routeName.split("/")[2] : null;

    for (ReRouteArgs route in routeArguments) {
      if (id != null && route.name == "/${routeName.split("/")[1]}") {
        ReRouteArgs tempRoute = route;
        idArgument = id;
        return tempRoute;
      } else if (id == null && route.name == routeName) {
        idArgument = null;
        return route;
      }
    }
    return routeArguments.first;
  }
}
