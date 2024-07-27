import 'package:eraphilippines/presentation/agents/controllers/agents_binding.dart';
import 'package:eraphilippines/presentation/agents/pages/agentInfo.dart';
import 'package:eraphilippines/presentation/agents/pages/agentprofile.dart';
import 'package:eraphilippines/presentation/agents/pages/findagents.dart';
import 'package:eraphilippines/presentation/authentication/controllers/login_page_binding.dart';
import 'package:eraphilippines/presentation/authentication/pages/createaccount_page.dart';
import 'package:eraphilippines/presentation/base/controllers/base_binding.dart';
import 'package:eraphilippines/presentation/companynews/controllers/companynews_binding.dart';
import 'package:eraphilippines/presentation/companynews/pages/companynews.dart';
import 'package:eraphilippines/presentation/contacts/controllers/contacts_binding.dart';
import 'package:eraphilippines/presentation/contacts/pages/aboutus.dart';
import 'package:eraphilippines/presentation/contacts/pages/contact_us.dart';
import 'package:eraphilippines/presentation/contacts/pages/help.dart';
import 'package:eraphilippines/presentation/home/controllers/home_binding.dart';
import 'package:eraphilippines/presentation/Listingproperties/pages/findproperties.dart';
import 'package:eraphilippines/presentation/listingproperties/controllers/listing_binding.dart';
import 'package:eraphilippines/presentation/listingproperties/pages/property_infomation.dart';
import 'package:eraphilippines/presentation/projects/controllers/projects_binding.dart';
import 'package:eraphilippines/presentation/projects/pages/project.dart';
import 'package:eraphilippines/presentation/projects/pages/projectmain.dart';
import 'package:eraphilippines/presentation/authentication/pages/login_page.dart';
import 'package:eraphilippines/presentation/searchresult/controllers/searchresult_binding.dart';
import 'package:eraphilippines/presentation/searchresult/pages/searchresult.dart';
import 'package:eraphilippines/router/route_string.dart';
import 'package:get/get.dart';

import '../presentation/home/pages/home.dart';

appRoutes() => [
      /*
  GetPage(
    name: RoutePageString.auth,
    page: () => const AuthPage(),
    middlewares: [MyMiddelware()],
  ),
  */
      GetPage(
          name: RouteString.home,
          page: () => const Home(),
          binding: HomeBinding()),
      GetPage(
          name: RouteString.loginpage,
          page: () => const LoginPage(),
          binding: SecondPageBinding()),
      // GetPage(
      //     name: RouteString.preSelling,
      //     page: () => const PreSelling(),
      //     binding: ListingBinding()),
      // GetPage(
      //     name: RouteString.residential,
      //     page: () => const Residential(),
      //     binding: ListingBinding()),
      // GetPage(
      //     name: RouteString.commercial,
      //     page: () => const Commercial(),
      //     binding: ListingBinding()),
      // GetPage(
      //     name: RouteString.rental,
      //     page: () => const Rental(),
      //     binding: ListingBinding()),
      // GetPage(
      //     name: RouteString.auction,
      //     page: () => const Auction(),
      //     binding: ListingBinding()),
      GetPage(
          name: RouteString.project,
          page: () => const ProjectPage(),
          binding: ProjectsBinding()),
      GetPage(
          name: RouteString.projectmain,
          page: () => const ProjectMain(),
          binding: ProjectsBinding()),
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
      // GetPage(
      //     name: RouteString.agentprofile,
      //     page: () => const AgentProfile(),
      //     binding: AgentsBinding()),

      GetPage(
          name: RouteString.propertyInfo,
          page: () => PropertyInformation(
                listing: Get.arguments,
              ),
          binding: ListingBinding()),

      GetPage(
          name: RouteString.agentInfo,
          page: () => Agentinfo(
                listing: Get.arguments,
              ),
          binding: AgentsBinding()),
    ];

class MyMiddleware extends GetMiddleware {}
