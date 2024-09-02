import 'package:eraphilippines/presentation/admin/agents/controllers/agents_bindings.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/authentication.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/controllers/home_analytics_binding.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/pages/home_analytics.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_binding.dart';
import 'package:eraphilippines/presentation/admin/landingpage/pages/landingpage.dart';
import 'package:eraphilippines/presentation/agent/agents/bindings/agent_dashboard_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/bindings/agent_listings_binding.dart';
import 'package:eraphilippines/presentation/agent/agents/pages/agent_listings.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/aurelia.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/haraya.dart';
import 'package:eraphilippines/presentation/agent/projects/pages/laya.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';
import '../presentation/agent/agents/controllers/agents_binding.dart';
import '../presentation/agent/agents/pages/agentsDashBoard.dart';
import '../presentation/agent/agents/pages/agentsMyListing.dart';
import '../presentation/agent/agents/pages/findagents.dart';
import '../presentation/agent/authentication/controllers/authentication_binding.dart';
import '../presentation/agent/authentication/pages/createaccount_page.dart';
import '../presentation/agent/authentication/pages/login_page.dart';
import '../presentation/agent/company_news/controllers/companynews_binding.dart';
import '../presentation/agent/company_news/pages/companynews.dart';
import '../presentation/agent/forms/contacts/controllers/contacts_binding.dart';
import '../presentation/agent/forms/contacts/pages/aboutus.dart';
import '../presentation/agent/forms/contacts/pages/contact_us.dart';
import '../presentation/agent/forms/contacts/pages/direct-contactus.dart';
import '../presentation/agent/forms/contacts/pages/help.dart';
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
import '../presentation/agent/projects/controllers/projects_binding.dart';
import '../presentation/agent/projects/pages/projectmain.dart';
import '../presentation/agent/tools/mortageCalculator.dart/controllers/MortageCalculator_binding.dart';
import '../presentation/agent/tools/mortageCalculator.dart/pages/MortageCalculator.dart';

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
          name: RouteString.haraya,
          page: () => const HarayaProject(),
          binding: ProjectsBinding()),

      GetPage(
          name: RouteString.laya,
          page: () => const LayaProject(),
          binding: ProjectsBinding()),

      GetPage(
          name: RouteString.aurelia,
          page: () => const AureliaProject(),
          binding: ProjectsBinding()),

      GetPage(
        name: RouteString.projectmain,
        page: () => const ProjectMain(),
        binding: ProjectsBinding(),
      ),
      GetPage(
          name: RouteString.contactus,
          page: () => const ContactUs(),
          binding: ContactUsBinding()),
      GetPage(
          name: RouteString.aboutus,
          page: () => const AboutUs(),
          binding: ContactUsBinding()),
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
          name: RouteString.help,
          page: () => Help(),
          binding: ContactUsBinding()),
      GetPage(
          name: RouteString.findagents,
          page: () => const FindAgents(),
          binding: AgentsBinding()),
      GetPage(
          name: RouteString.companynews,
          page: () => const CompanyNews(),
          binding: CompanyNewsBinding()),
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
          name: RouteString.mortageCalculator,
          page: () => MortageCalculator(),
          binding: MortageCalculatorBinding()),
      GetPage(
          name: RouteString.directContactUs,
          page: () => DirectContactUs(),
          binding: ContactUsBinding()),
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
//admin
      GetPage(
          name: RouteString.landingPage,
          page: () => LandingPage(),
          binding: LandingpageBinding()),
      GetPage(
          name: RouteString.homeAnalytics,
          page: () => const HomeAnalytics(),
          binding: HomeAnalyticsBinding()),

      GetPage(
          name: RouteString.addAgent,
          page: () => AddAgent(),
          binding: AgentAdminBindings()),

      GetPage(
        name: RouteString.adminLogin,
        page: () => AuthenticationPage(),
      ),
    ];

class MyMiddleware extends GetMiddleware {}
