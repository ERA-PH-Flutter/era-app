import 'package:eraphilippines/presentation/admin/agents/controllers/agents_bindings.dart';
import 'package:eraphilippines/presentation/admin/agents/pages/add-agent.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/controllers/home_analytics_binding.dart';
import 'package:eraphilippines/presentation/admin/dashboard/home_analytics/pages/home_analytics.dart';
import 'package:eraphilippines/presentation/admin/landingpage/controllers/landingpage_binding.dart';
import 'package:eraphilippines/presentation/admin/landingpage/pages/landingpage.dart';
import 'package:eraphilippines/presentation/admin/listingsss/controllers/add_edit_listings_binding.dart';
import 'package:eraphilippines/presentation/admin/listingsss/pages/add_listings.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';
import '../presentation/agent/a/controllers/base_binding.dart';
import '../presentation/agent/add-edit_listings/controllers/addlistings_bindings.dart';
import '../presentation/agent/add-edit_listings/pages/addlistings.dart';
import '../presentation/agent/add-edit_listings/pages/edit_listing.dart';
import '../presentation/agent/agents/controllers/agents_binding.dart';
import '../presentation/agent/agents/pages/agentsDashBoard.dart';
import '../presentation/agent/agents/pages/agentsMyListing.dart';
import '../presentation/agent/agents/pages/findagents.dart';
import '../presentation/agent/authentication/controllers/authentication_binding.dart';
import '../presentation/agent/authentication/pages/createaccount_page.dart';
import '../presentation/agent/authentication/pages/login_page.dart';
import '../presentation/agent/companynews/controllers/companynews_binding.dart';
import '../presentation/agent/companynews/pages/companynews.dart';
import '../presentation/agent/contacts/controllers/contacts_binding.dart';
import '../presentation/agent/contacts/pages/aboutus.dart';
import '../presentation/agent/contacts/pages/contact_us.dart';
import '../presentation/agent/contacts/pages/help.dart';
import '../presentation/agent/home/controllers/home_binding.dart';
import '../presentation/agent/home/pages/home.dart';
import '../presentation/agent/listingproperties/controllers/listing_binding.dart';
import '../presentation/agent/listingproperties/pages/findproperties.dart';
import '../presentation/agent/listingproperties/pages/property_infomation.dart';
import '../presentation/agent/projects/controllers/projects_binding.dart';
import '../presentation/agent/projects/pages/project.dart';
import '../presentation/agent/projects/pages/projectmain.dart';
import '../presentation/agent/searchresult/controllers/searchresult_binding.dart';
import '../presentation/agent/searchresult/pages/searchresult.dart';
import '../presentation/agent/searchresult/pages/selling_searchresult.dart';

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
          binding: SecondPageBinding()),
      GetPage(
          name: RouteString.project,
          page: () => const ProjectPage(),
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
          page: () => const Help(),
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
          page: () => AgentDashBoard(
                listing: Get.arguments,
              ),
          binding: AgentsBinding()),
      GetPage(
          name: RouteString.agentMyListing,
          page: () => AgentMyListing(),
          binding: AgentsBinding()),
      GetPage(
          name: RouteString.editListings,
          page: () => EditListing(),
          binding: AddListingsBinding()),

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
          name: RouteString.addlistingsAdmin,
          page: () => AddListingsAdmin(),
          binding: AddEditListingsBinding()),

      GetPage(
          name: RouteString.agentAdmin,
          page: () => AgentAdmin(),
          binding: AgentAdminBindings()),
    ];

class MyMiddleware extends GetMiddleware {}
